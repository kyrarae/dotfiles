;; Markdown mode
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.page\\'"     . gfm-mode)))

;; Markdown Treesitter mode
(use-package markdown-ts-mode
  :ensure nil
  :mode ("\\.md\\'"        . markdown-ts-mode)
  :config
  (treesit-ensure-grammar
   '(markdown "https://github.com/ikatyang/tree-sitter-markdown"))
  (treesit-ensure-grammar
   '(markdown_inline "https://github.com/ikatyang/tree-sitter-markdown"
		     "split_parser"
		     "tree-sitter-markdown-inline")))
