;; -*- lexical-binding: t; -*-

;; Customize compilation buffer
(use-package compile
  :defer t
  :custom
  (compile-command "")
  (compilation-scroll-output t)
  :config
  (defun toggle-compilation-window ()
    "Hide or re-open the *compilation* buffer window."
    (interactive)
    (if-let ((win (get-buffer-window "*compilation*")))
        (delete-window win)
      (if-let ((buf (get-buffer "*compilation*")))
          (display-buffer buf)
        (call-interactively #'compile))))
  (add-to-list 'display-buffer-alist
               '("\\*compilation\\*"
                 (display-buffer-reuse-mode-window display-buffer-at-bottom)
                 (window-height . 0.25))) ; Limits buffer to 25% height at the bottom
  :hook
  (compilation-filter-hook . ansi-color-compilation-filter)
  :bind
  (("C-c c"   . compile)
   ("C-c C-c" . toggle-compilation-window)))
