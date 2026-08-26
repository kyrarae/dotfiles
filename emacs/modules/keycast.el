;; -*- lexical-binding: t; -*-

;; Keycast
(use-package keycast
  :after (modeline)
  :ensure t
  :demand t
  :config
  (setq keycast-mode-line-format " %2s%k%c%R "
        keycast-mode-line-insert-after 'mode-line-end-spaces
        keycast-mode-line-window-predicate 'mode-line-window-selected-p
        keycast-mode-line-remove-tail-elements nil)
  ;; Skip keycast updates on mouse events to retain the last displayed key
  (define-advice keycast--update (:before-until () ignore-mouse-events)
    (when (or (memq this-command '(handle-select-window
                                   mouse-set-point
                                   mouse-drag-region
                                   mwheel-scroll
                                   scroll-up-command
                                   scroll-down-command))
              (and (arrayp (this-command-keys))
                   (> (length (this-command-keys)) 0)
                   (mouse-event-p (elt (this-command-keys) 0))))
      t))
  (dolist (input '(self-insert-command org-self-insert-command))
    (add-to-list 'keycast-substitute-alist `(,input "." "typing…")))
  :hook (after-init . keycast-mode-line-mode))
