;; -*- lexical-binding: t; -*-

;; Custom modeline
(use-package kyra-modeline
  :ensure nil)

(use-package emacs
  :after (:all kyra-modeline)
  :delight
  (overwrite-mode)
  :custom
  (column-number-mode t)
  (mode-line-position-column-line-format '("%l:%c"))
  (mode-line-format '("%e"
		      mode-line-front-space
		      mode-line-mule-info
		      mode-line-modified
		      "   "
		      mode-line-buffer-directory
		      mode-line-buffer-identification
		      "   "
		      mode-line-input "  "
		      mode-line-position
		      (vc-mode vc-mode)
		      "   "
		      mode-line-modes
		      mode-line-misc-info
		      mode-line-end-spaces)))

