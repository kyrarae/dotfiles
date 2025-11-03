;; Native compilation
;(when (native-comp-available-p)
;  (startup-redirect-eln-cache "~/.cache/emacs/eln/")
;  (setq-default native-comp-jit-compilation nil))

;; Optimize startup
(customize-set-value 'gc-cons-threshold most-positive-fixnum)
(setq-default read-process-output-max (* 1024 1024))

(customize-set-value 'package-user-dir "~/.local/share/emacs/packages"
		     "For `package-vc'")

(setq-default mode-line-end-spaces nil)

;; Use fish shell
(setq-default shell-file-name "/usr/local/bin/fish")

;; Fix ugly gap on the right window side when at 100% width
;; https://github.com/d12frosted/homebrew-emacs-plus/issues/177
(setq frame-resize-pixelwise t)

;; MacOS specific appearance
;; Make title bar tranparent & no icon
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil)

;; Custom frame title
(setq frame-title-format '("" "%b @ Emacs " emacs-version))

;; Set frame to maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Make special key combos usable in terminal mode
;; https://stackoverflow.com/a/10867354
;; Note: These do not work when using tmux
(add-hook 'term-setup-hook
  (lambda ()
    (define-key function-key-map "\e[1;9A" [s-up])
    (define-key function-key-map "\e[1;9B" [s-down])
    (define-key function-key-map "\e[1;9C" [s-right])
    (define-key function-key-map "\e[1;9D" [s-left])
    (define-key function-key-map "\e[1;10A" [s-S-up])
    (define-key function-key-map "\e[1;10B" [s-S-down])
    (define-key function-key-map "\e[1;10C" [s-S-right])
    (define-key function-key-map "\e[1;10D" [s-S-left])
    (define-key function-key-map "\e[1;13A" [C-s-up])
    (define-key function-key-map "\e[1;13B" [C-s-down])
    (define-key function-key-map "\e[1;13C" [C-s-right])
    (define-key function-key-map "\e[1;13D" [C-s-left])))

(provide 'early-init)
