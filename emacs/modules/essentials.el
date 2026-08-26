;; -*- lexical-binding: t; -*-

;; Make MacOS alt key useful again
(use-package emacs
  :demand t
  :custom
  (mac-option-key-is-meta t)
  (mac-option-modifier 'meta)
  (mac-right-option-modifier nil)
  (mac-control-modifier 'control))

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

;; Make yes-or-no shorter
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

(defun kyra-lock-minibuffer-size ()
  "Lock the echo area / minibuffer window size, ignoring child/posframe frames."
  (unless (frame-parameter nil 'parent-frame)
    (set-window-parameter (minibuffer-window) 'window-size-fixed 'height)
    (window-resize (minibuffer-window) (- 2 (window-height (minibuffer-window))))))

;; Set echo area/minibuffer size
(use-package emacs
  :init
  (setq resize-mini-windows nil)
  :config
  ;; Run on startup
  (add-hook 'window-setup-hook #'kyra-lock-minibuffer-size)
  ;; Run anytime macOS alters the frame configurations/monitors
  (add-hook 'window-configuration-change-hook #'kyra-lock-minibuffer-size))

;; Editor appearance & settings
(use-package emacs
  :custom
  (tool-bar-mode nil)
  (scroll-bar-mode nil)
  (global-display-line-numbers-mode t)
  (display-line-numbers-grow-only t)
  (display-line-numbers-type 'relative)
  (display-line-numbers-width-start t)
  (delete-selection-mode t)
  (savehist-mode 1)
  (recentf-mode 1)
  ;; Keep point in the same relative screen position when scrolling/resizing
  (scroll-preserve-screen-position t)
  ;; Scroll line-by-line instead of jumping
  (scroll-conservatively 101)
  (repeat-mode 1)
  ;; Exit after 5 seconds of inactivity
  (repeat-exit-timeout 5)
  :config
  (put 'upcase-region   'disabled nil)
  (put 'downcase-region 'disabled nil)
  (defun reload-init-file ()
    (interactive)
    (load-file user-init-file))
  :bind
  ("C-c r" . reload-init-file))

;; Cursor
(use-package emacs
  :custom
  ;; Prevent the cursor from stopping after 10 blinks
  (blink-cursor-blinks 0)
  :config
  ;; Turn on cursor blinking globally
  (blink-cursor-mode t))

;; Editing
(use-package emacs
  :bind (("C-,"        . duplicate-line)
	 ("s-<up>"     . beginning-of-buffer)
	 ("s-<down>"   . end-of-buffer)
	 ("s-S-<up>"   . backward-paragraph)
	 ("s-S-<down>" . forward-paragraph)
	 ("C-c u"      . upcase-region)
	 ("C-c l"      . downcase-region)
	 ("s-i"        . overwrite-mode)
	 ("C-S-/"      . undo-redo)))

;; Move text
(use-package move-text
  :ensure t
  :bind (("M-<up>"     . move-text-up)
	 ("M-<down>"   . move-text-down)))

;; Smarter move-beginning-of-line
(use-package emacs
  :preface
  (defun smarter-move-beginning-of-line (arg)
    (interactive "^p")
    (setq arg (or arg 1))
    ;; Move lines first
    (when (/= arg 1)
      (let ((line-move-visual nil))
	(forward-line (1- arg))))
    (let ((orig-point (point)))
      (back-to-indentation)
      (when (= orig-point (point))
	(move-beginning-of-line 1))))
  :bind
  ([remap move-beginning-of-line] . smarter-move-beginning-of-line))

;; Abort half typed key bindings
(use-package emacs
  :config
  ;; Cleanly abort prefix key maps with C-g
  (dolist (map (list mode-specific-map ctl-x-map help-map esc-map))
    (keymap-set map "C-g" #'keyboard-quit)))

;; Column indicator
;; Reference->https://emacs.stackexchange.com/a/81307
(use-package display-fill-column-indicator
  :hook
  (prog-mode-hook . (lambda ()
		      (display-fill-column-indicator-mode 1)
		      (setq fill-column 80)
		      (setq display-fill-column-indicator t)
		      (setq display-fill-column-indicator-character ?▏))))
