;; -*- lexical-binding: t; -*-

;; Dashboard
(use-package dashboard
  :ensure t
  :init
  (defun kyra-toggle-dashboard ()
    "Toggle display of the Emacs dashboard."
    (interactive)
    (if (string-equal (buffer-name) "*dashboard*")
        (quit-window)
      (dashboard-open)))
  :custom
  (dashboard-items '((bookmarks . 5)
                     (recents  . 5)
                     (projects . 5)))
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-banner-logo-title "NEWGAMACS!")
  (dashboard-startup-banner
        (cons (expand-file-name "banner.png" user-config-directory)
              (expand-file-name "banner.txt" user-config-directory)))
  (dashboard-startupify-list '(dashboard-insert-banner
			       dashboard-insert-newline
			       dashboard-insert-newline
                               dashboard-insert-newline
			       dashboard-insert-newline
			       dashboard-insert-banner-title
			       dashboard-insert-newline
			       kyra-dashboard-init-time
			       dashboard-insert-newline
			       kyra-dashboard-package-count
                               dashboard-insert-newline
                               dashboard-insert-items
			       dashboard-insert-newline
                               dashboard-insert-footer))
  (initial-buffer-choice 'dashboard-open)
  :config
  (defun kyra-dashboard-init-time ()
    "Insert custom startup time message into dashboard."
    (let* ((msg (format "Emacs started in %s." (emacs-init-time)))
           (styled-msg (propertize msg 'face 'font-lock-comment-face))
           (padding (max 0 (/ (- (window-width) (string-width msg)) 2))))
      (insert (make-string padding ?\s) styled-msg)))
  (defun kyra-dashboard-package-count ()
    "Insert custom installed packages count message into dashboard."
    (let* ((pkg-count (length package-activated-list))
           (msg (format "%d packages installed." pkg-count))
           (styled-msg (propertize msg 'face 'font-lock-comment-face))
           (padding (max 0 (/ (- (window-width) (string-width msg)) 2))))
      (insert (make-string padding ?\s) styled-msg)))
  (defun kyra-fallback-to-dashboard-on-kill ()
    "Open *dashboard* if no user buffers remain after killing a buffer."
    (let ((user-buffers (seq-filter (lambda (b)
                                      (let ((name (buffer-name b)))
                                        (and (not (string-prefix-p " " name))
                                             (not (string-prefix-p "*" name)))))
                                    (buffer-list))))
      (when (or (null user-buffers)
                (equal user-buffers (list (current-buffer))))
        (run-at-time 0 nil #'dashboard-open))))
  :hook
  (kill-buffer . kyra-fallback-to-dashboard-on-kill)
  :bind
  ("C-c d" . kyra-toggle-dashboard))
