;;; kyra-modeline.el --- Custom modeline -*- lexical-binding: t; -*-

(use-package shrink-path
  :ensure t)

;; Modeline custom faces (abstracted from specific colors)
(defgroup kyra-modeline nil
  "Custom mode line styling."
  :group 'mode-line)

(defface modeline-overwrite-mode '((t :inherit error))
  "Face for overwrite mode." :group 'kyra-modeline)

(defface modeline-directory '((t :inherit shadow))
  "Face for directory name." :group 'kyra-modeline)

(defface modeline-parent-directory '((t :inherit font-lock-comment-face))
  "Face for parent directory name." :group 'kyra-modeline)

(defface modeline-buffer-id '((t :inherit font-lock-keyword-face))
  "Face for buffer name." :group 'kyra-modeline)

;; Centralized modeline color & padding applicator
(defun kyra-modeline-apply-base16-colors (colors-alist-or-plist)
  "Apply base16 COLORS to custom modeline faces and recalculate padding."
  (let* ((get-col (lambda (key)
                    (if (alist-get key colors-alist-or-plist)
                        (alist-get key colors-alist-or-plist)
                      (plist-get colors-alist-or-plist key))))
         (base00 (funcall get-col :base00)) ; Default background
         (base01 (funcall get-col :base01)) ; Lighter background / status lines
         (base02 (funcall get-col :base02)) ; Selection / highlights
         (base03 (funcall get-col :base03)) ; Comments / muted text
         (base04 (funcall get-col :base04)) ; Dark foreground
         (base08 (funcall get-col :base08)) ; Red / Overwrite
         (base0D (funcall get-col :base0D))) ; Blue / Buffer ID

    ;; Apply dynamic colors to custom faces
    (set-face-attribute 'modeline-overwrite-mode nil :foreground base08 :weight 'bold)
    (set-face-attribute 'modeline-directory nil :foreground base03)
    (set-face-attribute 'modeline-parent-directory nil :foreground base04)
    (set-face-attribute 'modeline-buffer-id nil :foreground base0D)
    (set-face-attribute 'mode-line-highlight nil
                        :background base02
                        :foreground 'unspecified
                        :box `(:line-width 1 :color ,base02))

    ;; Apply padded mode-line borders
    (let* ((v-padding 3)
           (h-padding 1)
           (bg-active (or (face-background 'mode-line-active nil t)
                          (face-background 'mode-line nil t)
                          base01))
           (bg-inactive (or (face-background 'mode-line-inactive nil t)
                            base00)))
      (set-face-attribute 'mode-line-active nil
                          :box `(:line-width (,h-padding . ,v-padding)
                                 :color ,bg-active))
      (set-face-attribute 'mode-line-inactive nil
                          :box `(:line-width (,h-padding . ,v-padding)
                                 :color ,bg-inactive)))))

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
  (cond (buffer-read-only "R")
        ((buffer-modified-p) "*")
        (inhibit-read-only "R")
        (t "-")))

(defun buffer-modified ()
  (cond ((buffer-modified-p) "*")
        (t "-")))

;; Mode line constructs

(defvar mode-line-input
  '(:eval
    (propertize (if overwrite-mode "Ovr" "Ins")
                'face (if overwrite-mode
                          'modeline-overwrite-mode
                        nil)))
  "Mode line construct for displaying current input mode.")
(put 'mode-line-input 'risky-local-variable t)

(defvar mode-line-buffer-directory
  '(:eval (truncate-directory-name))
  "Mode line construct for displaying the buffer directory.")
(put 'mode-line-buffer-directory 'risky-local-variable t)

(setq-default mode-line-modified
  '(:eval
    (list (propertize (buffer-state)
                      'help-echo 'mode-line-read-only-help-echo
                      'local-map (purecopy (make-mode-line-mouse-map
                                            'mouse-1 #'mode-line-toggle-read-only))
                      'mouse-face 'mode-line-highlight)
          (propertize (buffer-modified)
                      'help-echo 'mode-line-modified-help-echo
                      'local-map (purecopy (make-mode-line-mouse-map
                                            'mouse-1 #'mode-line-toggle-modified))
                      'mouse-face 'mode-line-highlight))))

(setq-default mode-line-buffer-identification
  '(:eval
    (propertize "%b"
                'face (if (mode-line-window-selected-p)
                          '(modeline-buffer-id (:weight bold))
                        '(modeline-buffer-id (:slant italic))))))

(provide 'kyra-modeline)
;;; kyra-modeline.el ends here
