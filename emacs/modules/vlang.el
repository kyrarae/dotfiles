;; V mode
(use-package v-mode
  :ensure t
  :mode ("\\.v\\'" "\\.vsh\\'")
  :hook (v-mode-hook . eglot-ensure)
  :bind (:map v-mode-map
	      ("M-z" . v-menu)
	      ("C-c C-f" . v-format-buffer))
  :init
  ;; Disable format-on-save to prevent server crash
  (advice-add 'v-after-save-hook :override #'ignore)
  ;; Suppress jsonrpc errors during shutdown so kill-buffer isn't aborted
  (advice-add 'eglot-shutdown :around
              (lambda (orig-fun &rest args)
		(if (derived-mode-p 'v-mode)
                    (ignore-errors (apply orig-fun args))
                  (apply orig-fun args))))
  :config
  ;; Register the LSP server when Eglot loads
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
		 '(v-mode . ("v-analyzer" "server")))))
