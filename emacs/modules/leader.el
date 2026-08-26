;; -*- lexical-binding: t; -*-

(defun kr/make-keymap (&optional prompt)
  "Create a sparse keymap with C-g bound to keyboard-quit."
    (let ((map (make-sparse-keymap prompt)))
      (define-key map (kbd "C-g") #'keyboard-quit)
      map))

(require 'general)

;; General.el
(use-package general
  :ensure t
  :demand t
  :init
  ;; Unset the key early during initialization
  (keymap-global-unset "C-SPC")
  :general
  (:prefix "C-SPC"
   "C-g"   'keyboard-quit
   "C-SPC" '("set mark" . set-mark-command)
   ;; Buffers
   "b"     (cons "buffers" (kr/make-keymap "buffers"))
   "bb"    '("switch buffer" . switch-to-buffer)
   "bk"    '("kill buffer" . kill-current-buffer)
   ;; Consult
   "c"     (cons "consult" (kr/make-keymap "consult"))
   "cb"    '("switch buffer" . consult-buffer)
   "ce"    '("flycheck" . consult-flycheck)
   "cf"    '("find" . consult-find)
   "ci"    '("imenu" . consult-imenu)
   "cI"    '("project imenu" . consult-project-imenu)
   "cl"    '("goto line" . consult-line)
   "cL"    '("locate" . consult-locate)
   "ck"    '("ripgrep" . consult-ripgrep)
   ;; Files
   "f"     '("find file" . find-file)
   ;; Flycheck
   "e"     (cons "flycheck" (kr/make-keymap "flycheck"))
   "en"    '("next error" . flycheck-next-error)
   "ep"    '("prev error" . flycheck-prev-error)
   "el"    '("list errors" . flycheck-list-errors)
   ;; Keycast
   "k"     (cons "keycast" (kr/make-keymap "keycast"))
   "kc"    '("toggle keycast" . keycast-mode-line-mode)))
