;; Fish mode
(use-package fish-mode
  :ensure t
  :custom
  (fish-enable-auto-indent t)
  :mode ("\\.fish$" . fish-mode))
