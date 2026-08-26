;; -*- lexical-binding: t; -*-

(defun vundo-live-diff-post-command ()
  "Post command hook function for live diffing."
  (when (and (derived-mode-p 'vundo-mode)
             (not (memq this-command '(vundo-quit vundo-confirm))))
    (ignore-errors
      (let* ((node (vundo--current-node vundo--prev-mod-list))
             (parent (and node (vundo-m-parent node))))
        (when parent
          (vundo-diff-mark parent)
          (vundo-diff))))))

(define-minor-mode vundo-live-diff-mode
  "Shows live diff between the current node and its parent."
  :lighter nil
  (if vundo-live-diff-mode
      (add-hook 'post-command-hook #'vundo-live-diff-post-command 0 t)
    (remove-hook 'post-command-hook #'vundo-live-diff-post-command t)))

(defun vundo-append-help (&rest _)
  (when (derived-mode-p 'vundo-mode)
    (let ((inhibit-read-only t))
      (goto-char (point-max))
      (insert "\n" (propertize (concat "f/b: fwd/back | "
				       "p/n: branch | "
				       "m: mark | "
				       "u: unmark | "
				       "d: diff | "
				       "v: live diff | "
				       "q: quit "
				       "ret: confirm")
			       'face 'font-lock-comment-face)))
    ;; Force window to adjust height to buffer content after rendering tree + help
    (fit-window-to-buffer nil nil nil nil nil t)))

;; Visual undo
(use-package vundo
  :ensure t
  :demand t
  :custom
  (vundo-compact-display t)
  (vundo-glyph-alist vundo-unicode-symbols)
  :config
  ;; Ensure sub-line/pixel accurate window height calculations
  (setq window-resize-pixelwise t)
  (add-to-list 'display-buffer-alist
               '("\\*vundo tree\\*"
                 (display-buffer-in-side-window)
                 (side . bottom)
                 (window-height . fit-window-to-buffer)))
  ;; Turn off line numbers after global-display-line-numbers-mode enables them
  (add-hook 'after-change-major-mode-hook
            (lambda ()
              (when (derived-mode-p 'vundo-mode)
                (display-line-numbers-mode -1)))
            t)
  ;; Automatically activate live diffing whenever vundo launches
  (add-hook 'vundo-mode-hook (lambda () (vundo-live-diff-mode 1)))
  (advice-add 'vundo--draw-tree :after #'vundo-append-help)
  :bind
  (("C-x C-u" . vundo)
   :map vundo-mode-map
   ("v" . vundo-live-diff-mode)))
