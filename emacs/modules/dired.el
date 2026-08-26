;; -*- lexical-binding: t; -*-

;; Dired helpers
(defun kr/dired-open ()
  "Use the OSX `open' command to open a file with the correct editor."
  (interactive)
  (save-window-excursion
    (when (fboundp 'dired-do-async-shell-command)
      (dired-do-async-shell-command
       "~/bin/open" current-prefix-arg
       (when (fboundp 'dired-get-marked-files)
	 (dired-get-marked-files t current-prefix-arg))))))

(defun kr/dired-mode-hook ()
  "Highlight mode in Dired buffer for better visibility."
  (hl-line-mode 1)
  (toggle-truncate-lines 1))

;; Dired
(use-package dired
  :ensure nil
  :custom
  (ls-lisp-dirs-first t)
  (diredp-hide-details-initially-flag nil)
  (dired-kill-when-opening-new-dired-buffer t)
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (dired-dwim-target t)
  (dired-ls-F-marks-symlinks t)
  (delete-by-moving-to-trash t)
  (global-auto-revert-non-file-buffers t)
  (wdired-allow-to-change-permissions t)
  :hook
  (dired-mode-hook . kr/dired-mode-hook)
  :config
  (put 'dired-find-alternate-file 'disabled nil)
  :bind (:map dired-mode-map
              ("RET" . dired-find-alternate-file)
              ("s"   . dired-do-shell-command)
              ("u"   . dired-up-directory)
              ("h"   . dired-hide-details-mode)
              ("b"   . dired-do-byte-compile)
              ("o"   . kr/dired-open)
              ("e"   . nil)
              ("e c" . dired-do-copy)
              ("e n" . dired-create-directory)
              ("e m" . dired-mark-files-regexp)
              ("e r" . dired-do-rename)
              ("e u" . dired-unmark-all-marks)))

;; Built-in extensions
(use-package dired-x
  :ensure nil
  :init
  (setq-default dired-omit-files-p t)
  :config
  (add-to-list 'dired-omit-extensions ".DS_Store"))

(use-package dired-aux
  :ensure nil)

;; External package downloaded via VC
(use-package dired+
  :vc (:url "https://github.com/emacsmirror/dired-plus.git"
       :main-file "dired+.el"))
