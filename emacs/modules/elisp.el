;; -*- lexical-binding: t; -*-

;; Check parentheses in Emacs Lisp mode
(defun kr/check-parens ()
  "Block saving if parentheses are unbalanced, keeping the cursor stationary."
  (interactive)
  (save-excursion
    (condition-case err
        (progn
          (check-parens)
          (let ((depth (car (syntax-ppss (point-max)))))
            (when (> depth 0)
              (user-error "%d unclosed parenthesis" depth))))
      (error
       (user-error "%s" (error-message-string err))))))

(defun kr/check-parens-before-save (&rest _)
  "Check parentheses before saving in `emacs-lisp-mode`."
  (when (derived-mode-p 'emacs-lisp-mode)
    (kr/check-parens)))

(advice-add 'save-buffer :before #'kr/check-parens-before-save)

(defface kr/unclosed-paren-face
  '((t :inherit error :weight bold))

  "Face used to highlight unclosed opening parentheses.")
(defvar-local kr/unclosed-paren-overlays nil
  "List of active overlays highlighting unclosed parentheses.")

(defun kr/highlight-unclosed-parens ()
  "Dynamically highlight all unclosed opening parentheses."
  (interactive)
  (when (derived-mode-p 'emacs-lisp-mode)
    (save-excursion
      (save-restriction
        (widen)
        ;; Clear old overlays
        (mapc #'delete-overlay kr/unclosed-paren-overlays)
        (setq kr/unclosed-paren-overlays nil)
        ;; Inspect low-level syntax parser
        (let* ((state (syntax-ppss (point-max)))
               (open-positions (nth 9 state)))
          (dolist (pos open-positions)
            (let ((ov (make-overlay pos (1+ pos))))
              (overlay-put ov 'face 'kr/unclosed-paren-face)
              ;; High priority forces overlay on top of font-lock & rainbow-delimiters
              (overlay-put ov 'priority 1000)
              (push ov kr/unclosed-paren-overlays))))))))

(defun kr/enable-unclosed-paren-highlighting ()
  "Attach unclosed paren highlighter to the current buffer."
  (add-hook 'post-command-hook #'kr/highlight-unclosed-parens nil t)
  (kr/highlight-unclosed-parens))

;; Emacs Lisp mode
(use-package emacs-lisp-mode
  :ensure nil
  :hook
  ((emacs-lisp-mode-hook . kr/enable-unclosed-paren-highlighting)))

;; Render html color code as colored text
(use-package rainbow-mode
  :ensure t
  :hook
  (prog-mode-hook . rainbow-mode)
  :delight)

;; Rainbow delimiters mode
(use-package rainbow-delimiters
  :ensure t
  :hook
  (emacs-lisp-mode-hook       . rainbow-delimiters-mode)
  (lisp-interaction-mode-hook . rainbow-delimiters-mode))
