;; -*- lexical-binding: t; -*-

;; Auto-select help windows
(use-package emacs
  :ensure nil
  :custom
  (help-window-select t))

;; Helpful
(use-package helpful
  :ensure t
  :bind
  ([remap describe-key]      . helpful-key)
  ([remap describe-command]  . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-function] . helpful-callable)
  ("C-c C-d"                 . helpful-at-point))
