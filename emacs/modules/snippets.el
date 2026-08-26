;; yas
(use-package yasnippet
  :ensure t
  :custom
  (yas-snippet-dirs (list (expand-file-name "snippets" user-config-directory)))
  :hook
  (prog-mode-hook . yas-minor-mode-on))
