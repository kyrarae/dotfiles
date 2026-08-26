;; -*- lexical-binding: t; -*-

(defun avy-action-exchange (pt)
  "Exchange sexp at PT with the one at point."
  (set-mark pt)
  (transpose-sexps 0))

(defun avy-action-embark (pt)
  "Invoke Emabark Action on PT."
  (save-excursion
    (goto-char pt)
    (embark-act))
  (select-window
   (cdr (ring-ref avy-ring 0)))
  t)

(defun avy-action-mark-to-char (pt)
  "Mark the region from PT to a candidate."
  (activate-mark)
  (goto-char pt))

(defun avy-action-copy-whole-line (pt)
  "Copy the whole line from PT."
  (save-excursion
    (goto-char pt)
    (cl-destructuring-bind (start . end)
        (bounds-of-thing-at-point 'line)
      (copy-region-as-kill start end)))
  (select-window
   (cdr
    (ring-ref avy-ring 0)))
  t)

(defun avy-action-yank-whole-line (pt)
  "Yank the whole line from PT."
  (avy-action-copy-whole-line pt)
  (save-excursion (yank))
  t)

(defun avy-action-teleport-whole-line (pt)
  "Teleport the whole line from PT."
  (avy-action-kill-whole-line pt)
  (save-excursion (yank)) t)

(defun avy-action-kill-whole-line (pt)
  "Kill the whole line from PT."
  (save-excursion
    (goto-char pt)
    (kill-whole-line))
  (select-window
   (cdr
    (ring-ref avy-ring 0)))
  t)

;; Avy
(use-package avy
  :ensure t
  :config
  (add-to-list 'avy-dispatch-alist '(?e . avy-action-exchange))
  (setf (alist-get ?. avy-dispatch-alist) 'avy-action-embark)
  (setf (alist-get ?  avy-dispatch-alist) 'avy-action-mark-to-char)
  (setf (alist-get ?k avy-dispatch-alist) 'avy-action-kill-stay
        (alist-get ?K avy-dispatch-alist) 'avy-action-kill-whole-line)
  (setf (alist-get ?t avy-dispatch-alist) 'avy-action-teleport
        (alist-get ?T avy-dispatch-alist) 'avy-action-teleport-whole-line)
  (setf (alist-get ?y avy-dispatch-alist) 'avy-action-yank
        (alist-get ?w avy-dispatch-alist) 'avy-action-copy
        (alist-get ?W avy-dispatch-alist) 'avy-action-copy-whole-line
        (alist-get ?Y avy-dispatch-alist) 'avy-action-yank-whole-line)
  :bind (("M-j" . avy-goto-char-timer)))

;; Consult
(use-package consult
  :ensure t
  :custom
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref)
  :bind (("C-x b"   . consult-buffer)
	 ("C-x C-b" . switch-to-buffer)
	 ("C-x 4 b" . consult-buffer-other-window)
	 ("C-c e"   . consult-flycheck)
	 ("C-c f"   . consult-find)
	 ("C-c i"   . consult-imenu)
         ("C-c I"   . consult-project-imenu)
	 ("C-c l"   . consult-line)
	 ("C-c L"   . consult-locate)
	 ("C-c k"   . consult-ripgrep)))

;; Integrate flycheck
(use-package consult-flycheck
  :ensure t)
