;; Use vterm
(use-package vterm
  :ensure t)
(use-package vterm-toggle
  :ensure t
  :bind ("C-`" . vterm-toggle)
  :custom
  (setq vterm-toggle-fullscreen-p nil)
  :config
  (add-to-list 'display-buffer-alist
               '("\\*vterm\\*"
                 (display-buffer-in-side-window)
                 (side . bottom)
                 (window-height . 0.25))))
