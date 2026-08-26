;; C3 Treesitter mode
(use-package c3-ts-mode
  :vc (:url "https://github.com/c3lang/c3-ts-mode.git"
       :main-file "c3-ts-mode.el"
       :rev :head)
  :mode "\\.c3[it]?\\'"
  ;; :hook ((c3-ts-mode-hook . eglot-ensure))
  :hook (c3-ts-mode-hook . (lambda ()
                        ;; Disable hover checks to prevent c3lsp syntax panic
                        (setq-local eglot-ignored-server-capabilities '(:hoverProvider))
                        (eglot-ensure)))
  :init
  (treesit-ensure-grammar
   '(c3 "https://github.com/c3lang/tree-sitter-c3"))
  :custom
  (c3-ts-mode-indent-offset 4)
  :config
  ;; Register the LSP server when Eglot loads
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs '(c3-ts-mode . ("c3lsp")))))
