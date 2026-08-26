;; C/C++ Treesitter mode
(use-package c-ts-mode
  :ensure nil
  :mode (("\\.[hc]\\'" . c-ts-mode)
         ("\\.cpp\\'"  . c++-ts-mode)
         ("\\.hpp\\'"  . c++-ts-mode))
  :hook
  ((c-ts-mode . eglot-ensure)
   (c++-ts-mode . eglot-ensure))
  :init
  (treesit-ensure-grammar
   '(c "https://github.com/tree-sitter/tree-sitter-c"))
  (treesit-ensure-grammar
   '(cpp "https://github.com/tree-sitter/tree-sitter-cpp"))
  :config
  ;; Register the LSP server when Eglot loads
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
		 '((c-ts-mode c++-ts-mode) "clangd"))))
