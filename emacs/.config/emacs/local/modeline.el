(use-package shrink-path
  :ensure t)

;; Helper functions

(defun truncate-directory-name ()
  (let ((base/dir (shrink-path-prompt default-directory)))
    (list (propertize (car base/dir)
		      'face 'modeline-directory)
	  (propertize (cdr base/dir)
		      'face 'modeline-parent-directory)
	  (propertize "/"
		      'face 'modeline-directory))))

(defun buffer-state ()
  (cond (buffer-read-only
	 "R")
	((buffer-modified-p)
	 "*")
	(inhibit-read-only
	 "R")
	(t
	 "-")))

(defun buffer-modified ()
  (cond ((buffer-modified-p)
	 "*")
	(t
	 "-")))

;; Mode line custom faces

(defface
  modeline-overwrite-mode
  '((t :foreground "maroon"
       :background "#332323"))
  "Face for overwrite mode."
  :group 'modeline)

(defface
  modeline-directory
  '((t :foreground "#45475a"))
  "Face for directory name."
  :group 'modeline)

(defface
  modeline-parent-directory
  '((t :foreground "#585b70"))
  "Face for parent directory name."
  :group 'modeline)

(defface
  modeline-buffer-id
  '((t :foreground "#84adef"))
  "Face for buffer name."
  :group 'modeline)

;; Customize existing faces

(set-face-attribute
  'mode-line-highlight nil
  :box '(:line-width 1 :color "grey40" :style flat-button))

;; Mode line constructs

(defvar
 mode-line-input
  '(:eval
    (propertize (if overwrite-mode "Ovr" "Ins")
		'face (if overwrite-mode
			  'modeline-overwrite-mode
			'default)))
  "Mode line construct for displaying current input mode.")
(put 'mode-line-input 'risky-local-variable t)

(defvar
  mode-line-buffer-directory
  '(:eval
    (truncate-directory-name))
  "Mode line construct for displaying the buffer directory.")
(put 'mode-line-buffer-directory 'risky-local-variable t)

(setq-default
 mode-line-modified
  '(:eval
    (list (propertize
 	   (buffer-state)
 	   'help-echo 'mode-line-read-only-help-echo
 	   'local-map (purecopy (make-mode-line-mouse-map
 				 'mouse-1 #'mode-line-toggle-read-only))
 	   'mouse-face 'mode-line-highlight)
          (propertize
 	   (buffer-modified)
 	   'help-echo 'mode-line-modified-help-echo
 	   'local-map (purecopy (make-mode-line-mouse-map
 				 'mouse-1 #'mode-line-toggle-modified))
 	   'mouse-face 'mode-line-highlight))))

(setq-default
 mode-line-buffer-identification
  '(:eval
    (propertize "%b"
		'face (if (mode-line-window-selected-p)
			  '(modeline-buffer-id (:weight bold))
			'(modeline-buffer-id (:slant italic))))))



(provide 'modeline)
