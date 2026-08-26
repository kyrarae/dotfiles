;; -*- lexical-binding: t; -*-

;; Window stuff
(use-package emacs
  :ensure nil
  :custom
  ;; Proportional window resizing
  (window-combination-resize t)
  (switch-to-prev-buffer-skip-regexp "^ "))

;; Reversible C-x 1
(use-package winner
  :ensure nil
  :init
  (winner-mode +1)
  :bind
  ("C-x 1" . toggle-delete-other-windows)
  :config
  (defun toggle-delete-other-windows ()
    "Delete other windows in frame if any, or restore previous window config."
    (interactive)
    (if (and winner-mode (equal (selected-window) (next-window)))
        (winner-undo)
      (delete-other-windows))))

;; Move buffer windows
(use-package windmove
  :ensure nil
  :bind (("M-S-<left>"    . windmove-left)
	 ("C-M-S-<left>"  . windmove-swap-states-left)
	 ("M-S-<right>"   . windmove-right)
	 ("C-M-S-<right>" . windmove-swap-states-right)
	 ("M-S-<up>"      . windmove-up)
	 ("C-M-S-<up>"    . windmove-swap-states-up)
	 ("M-S-<down>"    . windmove-down)
	 ("C-M-S-<down>"  . windmove-swap-states-down)))
