;; Desktop save mode
(use-package desktop
  :ensure nil
  :init
  (desktop-save-mode 1)
  :custom
  (desktop-restore-frames t)
  (desktop-save t)
  (desktop-load-locked-desktop t)
  (desktop-dirname (expand-file-name "var/desktop/" user-emacs-directory))
  (desktop-path (list (expand-file-name "var/desktop/" user-emacs-directory)))
  ;; Do not save or restore any buffers/files
  (desktop-buffers-not-to-save ".*")
  (desktop-files-not-to-save ".*")
  :config
  (add-to-list 'desktop-clear-preserve-buffers ".*posframe.*"))
