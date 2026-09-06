;; -*- lexical-binding: t; -*-

(defun kyra-get-base16-color (colors key)
  "Extract KEY from COLORS palette whether defined as an alist or plist."
  (if (alist-get key colors)
      (alist-get key colors)
    (plist-get colors key)))

(defun kyra-get-base16-palette (theme)
  "Robustly fetch color alist/plist for THEME checking both symbol variants."
  (let ((sym-theme-colors (intern (format "%s-theme-colors" theme)))
        (sym-colors       (intern (format "%s-colors" theme))))
    (cond ((and (boundp sym-theme-colors) (symbol-value sym-theme-colors))
           (symbol-value sym-theme-colors))
          ((and (boundp sym-colors) (symbol-value sym-colors))
           (symbol-value sym-colors))
          (t nil))))

(defun kyra-set-face (face &rest args)
  "Set face attributes safely if FACE is defined."
  (when (facep face)
    (apply #'set-face-attribute face nil args)))

(defun kyra-apply-base16-custom-faces (&rest _)
  "Centralize face customizations using active base16 theme colors."
  (when-let* ((theme (seq-find (lambda (t-name)
                                 (string-prefix-p "base16-" (symbol-name t-name)))
                               custom-enabled-themes))
	      (colors (kyra-get-base16-palette theme)))
    (let ((base00 (kyra-get-base16-color colors :base00))  ; Background
          (base01 (kyra-get-base16-color colors :base01))  ; Lighter Background / Selection
          (base02 (kyra-get-base16-color colors :base02))  ; Selection Background
          (base03 (kyra-get-base16-color colors :base03))  ; Comments / Muted
          (base04 (kyra-get-base16-color colors :base04))  ; Dark Foreground
          (base05 (kyra-get-base16-color colors :base05))  ; Main Text
          (base06 (kyra-get-base16-color colors :base06))  ; Light Foreground
          (base07 (kyra-get-base16-color colors :base07))  ; Dark Foreground
          (base08 (kyra-get-base16-color colors :base08))  ; Errors
          (base09 (kyra-get-base16-color colors :base09))  ; Constants
          (base0A (kyra-get-base16-color colors :base0A))  ; Warnings
          (base0B (kyra-get-base16-color colors :base0B))  ; Info
          (base0C (kyra-get-base16-color colors :base0C))  ; Regex / Operators
          (base0D (kyra-get-base16-color colors :base0D))  ; Functions
          (base0E (kyra-get-base16-color colors :base0E))) ; Keywords

      ;; Syntax Highlighting (Lighter Comments)
      (kyra-set-face 'font-lock-comment-face
                     :foreground base04)
      (kyra-set-face 'font-lock-comment-delimiter-face
                     :foreground base04)

      ;; Custom Modeline
      (when (fboundp 'kyra-modeline-apply-base16-colors)
        (kyra-modeline-apply-base16-colors colors))

      ;; Line Numbers Gutter
      (kyra-set-face 'line-number
		     :background base00)
      (kyra-set-face 'line-number-current-line
		     :background base00)

      ;; Window Fringes (Left/Right side stripes)
      (kyra-set-face 'fringe
		     :background base00)

      ;; Cursor / Caret Color
      (kyra-set-face 'cursor
		     :background base06)

      ;; Column Indicator
      (kyra-set-face 'fill-column-indicator
		     :foreground base02)

      ;; Key bindings in messages / echo area
      (kyra-set-face 'help-key-binding
		     :background 'unspecified
		     :foreground base0D
		     :box nil)

      ;; Dashboard UI (Remove Link Underlines)
      (kyra-set-face 'dashboard-heading
		     :underline 'unspecified)
      (kyra-set-face 'widget-button
		     :underline 'unspecified)
      (kyra-set-face 'dashboard-items-face
		     :underline 'unspecified)

      ;; Centaur Tabs / Header Line
      (kyra-set-face 'header-line
		     :background base00
		     :foreground base05
		     :box nil)

      ;; Vertico Posframe Border
      (kyra-set-face 'vertico-posframe-border
		     :background base02
		     :foreground base02)

      ;; Keycast Key Display
      (kyra-set-face 'keycast-key
		     :background base0D
		     :foreground base00
		     :box nil)

      ;; Vundo Highlights
      (kyra-set-face 'vundo-highlight
		     :foreground base0D)
      (kyra-set-face 'vundo-saved
		     :foreground base0B)

      ;; Flycheck Diagnostics Undercurls
      (kyra-set-face 'flycheck-error
		     :underline `(:style wave :color ,base08))
      (kyra-set-face 'flycheck-warning
		     :underline `(:style wave :color ,base0A))
      (kyra-set-face 'flycheck-info
		     :underline `(:style wave :color ,base0B))

      ;; Custom Unclosed Parens Face
      (kyra-set-face 'kr/unclosed-paren-face
		     :foreground base00
		     :background base08
		     :weight 'bold)

      ;; Rainbow Delimiters Unmatched
      (kyra-set-face 'rainbow-delimiters-unmatched-face
                     :foreground base00
		     :background base08
		     :weight 'bold
		     :underline nil
		     :inherit nil)

      ;; Built-in Diff Mode
      (kyra-set-face 'diff-added
		     :foreground base0B
		     :background 'unspecified)
      (kyra-set-face 'diff-removed
		     :foreground base08
		     :background 'unspecified)
      (kyra-set-face 'diff-changed
		     :foreground base0A
		     :background 'unspecified)
      (kyra-set-face 'diff-header
		     :foreground base0D
		     :background base00)
      (kyra-set-face 'diff-file-header
		     :foreground base0D
		     :background base01
		     :weight 'bold)
      
      ;; Fine/Inline word highlights within diffs
      (kyra-set-face 'diff-refine-added
		     :foreground base00
		     :background base0B
		     :weight 'bold)
      (kyra-set-face 'diff-refine-changed
		     :foreground base00
		     :background base0A
		     :weight 'bold)
      (kyra-set-face 'diff-refine-removed
		     :foreground base00
		     :background base08
		     :weight 'bold)

      ;; Ediff Mode (if you use ediff)
      (kyra-set-face 'ediff-current-diff-A
		     :foreground base08
		     :background base01)
      (kyra-set-face 'ediff-fine-diff-A
		     :foreground base00
		     :background base08
		     :weight 'bold)
      (kyra-set-face 'ediff-current-diff-B
		     :foreground base0B
		     :background base01)
      (kyra-set-face 'ediff-fine-diff-B
		     :foreground
		     :background base0B
		     :weight 'bold))))

;; Base16 theme
(use-package base16-theme
  :ensure t
  :config
  ;; Automatically re-apply custom faces every time a base16 theme is loaded
  (advice-add 'load-theme :after #'kyra-apply-base16-custom-faces)
  ;; Re-apply faces once all deferred packages have finished loading on startup
  (add-hook 'after-init-hook #'kyra-apply-base16-custom-faces)
  ;; Initial Theme Load
  (load-theme 'base16-catppuccin-mocha t))
