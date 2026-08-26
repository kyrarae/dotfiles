;; Lua Treesitter mode
(use-package lua-ts-mode
  :ensure nil
  :mode "\\.lua\\'"
  :custom
  (lua-ts-indent-offset 2)
  :init
  (treesit-ensure-grammar
   '(lua "https://github.com/MunifTanjim/tree-sitter-lua")))
