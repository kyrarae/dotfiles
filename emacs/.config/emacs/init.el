;; ███████╗███╗   ███╗ █████╗  ██████╗███████╗
;; ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝
;; █████╗  ██╔████╔██║███████║██║     ███████╗
;; ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║
;; ███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║
;; ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
;; A cross-platform, extensible & free text editor.
;; https://www.gnu.org/software/emacs

(use-package cus-edit
  :defer t
  :custom
  (custom-file null-device "Don't store customizations."))

(use-package use-package
  :demand t
  :custom
  (use-package-hook-name-suffix nil))

(use-package package
  :demand t
  :config
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/")))

;; Don't litter Emacs config directory
(use-package no-littering
  :ensure t
  :init
  (setq no-littering-etc-directory
	(file-name-concat "~/.local/state/emacs" "etc"))
  (setq no-littering-var-directory
	(file-name-concat "~/.local/state/emacs" "var")))

;; Delight
(use-package delight
  :ensure t)

;; Make MacOS alt key useful again
(use-package emacs
  :init
  (setq mac-option-key-is-meta t
	mac-option-modifier 'meta
	mac-right-option-modifier nil))

;; Don't show splash screen
(use-package emacs
  :demand t
  :custom
  (inhibit-startup-screen t)
  (initial-buffer-choice #'messages-buffer)
  (initial-scratch-message nil))

;; Disable automatic backups
(use-package emacs
  :demand t
  :custom
  (auto-save-default nil)
  (make-backup-files nil))

;; Make yes-or-no way shorter
(use-package novice
  :config
  (defalias 'yes-or-no-p 'y-or-n-p))

;; Show menu-bar only in gui
(use-package emacs
  :demand t
  :config
  (defun contextual-menu-bar (&optional frame)
    (interactive)
    (set-frame-parameter frame 'menu-bar-lines
                         (if (display-graphic-p frame)
                             1 0)))
  :hook
  (after-make-frame-functions . contextual-menu-bar)
  (after-init-hook . contextual-menu-bar))

;; Editor appearance & settings
(use-package emacs
  :custom
  (tool-bar-mode nil)
  (scroll-bar-mode nil)
  (global-display-line-numbers-mode t)
  (display-line-numbers-grow-only   t)
  (display-line-numbers-type        'absolute)
  (display-line-numbers-width-start t)
  (delete-selection-mode t))
; :hook
; (prog-mode-hook . hl-line-mode))

;; Column indicator
;; Reference->https://emacs.stackexchange.com/a/81307
(use-package display-fill-column-indicator
  :hook
  (prog-mode-hook . (lambda()
		      (display-fill-column-indicator-mode 1)
		      (setq fill-column 80)
		      (setq display-fill-column-indicator t)
		      (setq display-fill-column-indicator-character ?▏)
		      (set-face-attribute 'fill-column-indicator nil
					  :foreground "#2d2e3b"))))

;; Default theme
(use-package catppuccin-theme
  :ensure t
  :config
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'mocha)
  (catppuccin-reload))

;; Set the default font
(use-package emacs
  :custom-face
  (default ((t (:height 130 :family "FiraMono Nerd Font Mono")))))

;; Custom mode-line
(use-package modeline
  :load-path "~/.config/emacs/local/")
(use-package emacs
  :after (:all modeline)
  :delight
  (overwrite-mode)
  :custom
  (column-number-mode t)
  (mode-line-position-column-line-format '("%l:%c"))
  (mode-line-format '("%e"
		      mode-line-front-space
		      mode-line-mule-info
		      mode-line-modified
		      "   "
		      mode-line-buffer-directory
		      mode-line-buffer-identification
		      "   "
		      mode-line-input "  "
		      mode-line-position
		      (vc-mode vc-mode)
		      "   "
		      mode-line-modes
		      mode-line-misc-info
		      mode-line-end-spaces)))

;; Highlight parenthesis
(use-package paren
  :ensure nil
  :custom
  (show-paren-mode t)
  (show-paren-delay 0.0)
  (show-paren-style 'parenthesis))

;; Smartparens
(use-package smartparens
  :ensure t
  :delight)
(use-package smartparens-config
  :ensure smartparens
  :config
; (show-smartparens-global-mode t)
  (defmacro def-pairs (pairs)
  `(progn
     ,@(cl-loop for (key . val) in pairs
             collect
             `(defun ,(read (concat
                             "wrap-with-"
                             (prin1-to-string key)
                             "s"))
                  (&optional arg)
                (interactive "p")
                (sp-wrap-with-pair ,val)))))
  (def-pairs ((paren . "(")
              (bracket . "[")
              (brace . "{")
              (single-quote . "'")
              (double-quote . "\"")
              (back-quote . "`")))
  :hook
  (prog-mode-hook . smartparens-mode)
  :bind (:map
	 smartparens-mode-map
	 ("C-<right>"     . sp-forward-symbol)
	 ("C-<left>"      . sp-backward-symbol)
	 ("C-s-<right>"   . sp-forward-slurp-sexp)
	 ("C-M-<right>"   . sp-backward-barf-sexp)
	 ("C-s-<left>"    . sp-backward-slurp-sexp)
	 ("C-M-<left>"    . sp-forward-barf-sexp)
	 ("C-M-t"         . sp-transpose-sexp)
	 ("C-M-k"         . sp-kill-sexp)
	 ("C-k"           . sp-kill-hybrid-sexp)
	 ("M-k"           . sp-backward-kill-sexp)
	 ("C-M-w"         . sp-copy-sexp)
	 ("M-<backspace>" . sp-unwrap-sexp)
	 ("C-<backspace>" . sp-backward-kill-word)
	 ([remap sp-backward-kill-word] . backward-kill-word)
	 ("C-x C-t"       . sp-transpose-hybrid-sexp)
	 ("C-c ("         . wrap-with-parens)
	 ("C-c ["         . wrap-with-brackets)
	 ("C-c {"         . wrap-with-braces)
	 ("C-c '"         . wrap-with-single-quotes)
	 ("C-c \""        . wrap-with-double-quotes)
	 ("C-c `"         . wrap-with-back-quotes)))

;; IDO
(use-package ido
  :custom
  (ido-mode t)
  (ido-everywhere t))

(use-package ido-completing-read+
  :ensure t
  :custom
  (ido-ubiquitous-mode t))

;; Smex
(use-package smex
  :ensure t
  :config
  (smex-initialize)
  :bind (("M-x"           . smex)
	 ("C-c C-c M-x"   . execute-extended-command)))

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind-keymap ("C-r"     . mc/keymap)
  :bind (:map
	 mc/keymap
	 ("<up>"          . mc/mark-previous-like-this)
         ("<down>"        . mc/mark-next-like-this)
         ("C-<up>"        . mc/mark-previous-like-this-word)
         ("C-<down>"      . mc/mark-next-like-this-word)
         ("M-<up>"        . mc/mark-previous-like-this-symbol)
         ("M-<down>"      . mc/mark-next-like-this-symbol)
         ("h"             . mc/mark-all-like-this)
         ("C-h"           . mc/mark-all-words-like-this)
         ("M-h"           . mc/mark-all-symbols-like-this)
         ("e"             . mc/mark-more-like-this-extended)
         ("r"             . mc/edit-lines)
         ("M-n"           . mc/insert-letters)
         ("n"             . mc/insert-numbers)
         ("s"             . mc/sort-regions)
         ("M-s"           . mc/reverse-regions)))

;; Editing
(use-package emacs
  :bind (("M-<right>"     . next-buffer)
	 ("M-<left>"      . previous-buffer)
	 ("C-,"           . duplicate-line)
	 ("s-<up>"        . beginning-of-buffer)
	 ("s-<down>"      . end-of-buffer)
	 ("s-S-<up>"      . backward-paragraph)
	 ("s-S-<down>"    . forward-paragraph)
	 ("s-i"           . overwrite-mode)))

;; Move text
(use-package move-text
  :ensure t
  :bind (("M-<up>"        . move-text-up)
	 ("M-<down>"      . move-text-down)))

;; Magit
(use-package magit
  :ensure t
  :custom
; (magit-auto-revert-mode nil)
  (magit-completing-read-function 'magit-ido-completing-read)
  :bind (("C-c g"         . magit-status)
	 ("C-c l"         . magit-log)
	 ("C-c f"         . magit-grep)))

;; Git gutter
(use-package git-gutter
  :ensure t
  :custom
  (git-gutter:update-interval 0.02)
  :hook
  (prog-mode-hook . git-gutter-mode)
  :delight
  (git-gutter-mode " gg"))

(use-package git-gutter-fringe
  :ensure t
  :config
  (define-fringe-bitmap 'git-gutter-fr:added
    [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified
    [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted
    [128 192 224 240] nil nil 'bottom))

;; Company
(use-package company
  :ensure t
  :config
  (global-company-mode))

;; Which key
(use-package which-key
  :ensure t 
  :config
  (which-key-mode)
  :delight)

;; yas
(use-package yasnippet
  :ensure t
  :custom
  (yas-snippet-dirs '("~/.config/emacs/snippets"))
  :hook
  (prog-mode-hook . yas-minor-mode-on))

;; Visual undo
(use-package vundo
  :ensure t
  :custom
  (vundo-compact-display t)
  (vundo-glyph-alist vundo-unicode-symbols)
  :custom-face
  (vundo-highlight ((t (:foreground "#84adef"))))
  (vundo-saved     ((t (:foreground "#a6e3a1"))))
  :bind (("C-x C-u" . vundo)))

;; Render html color code as colored text
(use-package rainbow-mode
  :ensure t
  :hook
  (prog-mode-hook . rainbow-mode)
  :delight
  :defer t)

;; Rainbow delimiters mode
(use-package rainbow-delimiters
  :ensure t
  :hook
  (emacs-lisp-mode-hook       . rainbow-delimiters-mode)
  (lisp-interaction-mode-hook . rainbow-delimiters-mode)
  :defer t)

;; Simple C mode
(use-package simpc-mode
  :load-path "~/.config/emacs/modes/"
  :mode ("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; Markdown mode
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
	 ("README\\.md\\'" . gfm-mode)
	 ("\\.page\\'" . gfm-mode)))

(provide 'init)
