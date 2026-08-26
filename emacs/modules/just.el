;; Justfile
(use-package just-mode
  :ensure t
  :mode ("\\(?:Justfile\\|justfile\\)\\'" . just-mode))
(use-package justl
  :ensure t
  :bind ("C-c C-j" . justl))
