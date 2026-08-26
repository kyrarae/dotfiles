;; Odin Treesitter mode
(use-package odin-ts-mode
  :vc (:url "https://github.com/Sampie159/odin-ts-mode.git"
       :main-file "odin-ts-mode.el")
  :mode "\\.odin\\'"
  :hook ((odin-ts-mode-hook . eglot-ensure))
  :init
  (treesit-ensure-grammar
   '(odin "https://github.com/tree-sitter-grammars/tree-sitter-odin"))
  :config
  ;; Register the LSP server when Eglot loads
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs '(odin-ts-mode . ("ols")))))
