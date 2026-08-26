;; -*- lexical-binding: t; -*-

;; Eglot
(use-package eglot
  :ensure t
  :custom
  (eglot-autoshutdown t)
  (eglot-shutdown-timeout 1)
  :bind (:map eglot-mode-map
         ("C-c C-d" . eldoc)
         ("C-c C-e" . eglot-rename)
         ("C-c C-f" . eglot-format-buffer)))

;; Disable Flymake
;; (add-hook 'eglot-managed-mode-hook (lambda ()
;; 	  (remove-hook 'flymake-diagnostic-functions 'eglot-flymake-backend)))
(use-package flymake
  :delight)

;; Flycheck
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode 1)
  :hook (flycheck-mode-hook . flycheck-annotate-mode)
  :custom
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (flycheck-temp-prefix (expand-file-name "flycheck/flycheck" user-emacs-directory))
  :bind (("M-g M-n" . flycheck-next-error)
         ("M-g M-p" . flycheck-previous-error)
         ("M-g M-=" . flycheck-list-errors)))

;; Flycheck-Eglot bridge
(use-package flycheck-eglot
  :after (flycheck eglot)
  :ensure t
  :config
  (global-flycheck-eglot-mode 1))
