;; YAML Treesitter mode
(use-package yaml-ts-mode
  :ensure nil
  :custom
  (yaml-indent-offset 4)
  :mode ("\\.ya?ml\\'" . yaml-ts-mode)
  :init
  (treesit-ensure-grammar
   '(yaml "https://github.com/ikatyang/tree-sitter-yaml")))
