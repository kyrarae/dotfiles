;; Define user-config-directory for user files residing in ~/.config/emacs/
(defconst user-config-directory (expand-file-name "~/.config/emacs/"))

;; Redirect user-emacs-directory so ALL built-in state, caches, projects, and
;; native compilation sub-processes write to ~/.cache/emacs/ by default
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/"))

;; Redirect native compilation cache
(when (boundp 'native-comp-eln-load-path)
  (let ((eln-dir (expand-file-name "var/eln-cache/" user-emacs-directory)))
    (startup-redirect-eln-cache eln-dir)
    (setq native-comp-eln-load-path (list eln-dir))
    (setenv "EMACSNATIVELOADPATH" eln-dir)))

;; Don't flicker GUI elements on startup
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Optimize startup
;;(customize-set-value 'gc-cons-threshold most-positive-fixnum)
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.5)
(setq-default read-process-output-max (* 1024 1024))
(setq large-file-warning-threshold (* 25 1024 1024))

(customize-set-value 'package-user-dir "~/.local/share/emacs/packages"
		     "For `package-vc'")

;; No spaces at the end of the mode line
(setq-default mode-line-end-spaces nil)

;; Use fish shell
;; (setq-default shell-file-name "/opt/homebrew/bin/fish")
(setq-default shell-file-name
              (or (executable-find "fish")
                  "/bin/sh"))

;; Fix ugly gap on the right window side when at 100% width
;; https://github.com/d12frosted/homebrew-emacs-plus/issues/177
(setq frame-resize-pixelwise t)

;; MacOS specific appearance
;; Make title bar tranparent & no icon
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil)

;; No titlebar (emacs+)
;;(add-to-list 'default-frame-alist '(undecorated . t))
;;(add-to-list 'default-frame-alist '(undecorated-round . t))

(add-to-list 'default-frame-alist '(font . "Terminess Nerd Font-14"))

;; Custom frame title
;; (setq frame-title-format '("" "%b @ Emacs " emacs-version))
(setq-default frame-title-format "Emacs")

;; Set frame to maximized
;;(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; NOTE: using desktop-save in init to remember frame size/position

;; Don't beep. Just don't.
(setq ring-bell-function (lambda ()))

;; (add-hook 'emacs-startup-hook
;;           (lambda ()
;;             (setq gc-cons-threshold (* 100 100 8)
;;                   gc-cons-percentage 0.1)))
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 32 1024 1024) ; 32 MB
                  gc-cons-percentage 0.1)))

;; Define user-lisp-directory and add it to load-path early
(defvar user-lisp-directory (expand-file-name "lisp" user-config-directory)
  "Directory for custom LISP utilities.")

(add-to-list 'load-path user-lisp-directory)
