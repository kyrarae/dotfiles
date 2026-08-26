;; -*- lexical-binding: t; -*-

;; Frame width toggle
(use-package frame
  :init
  (setq frame-resize-pixelwise t)
  :bind ("C-c t f" . kyra-toggle-frame-width)
  :preface
  (defvar kyra-frame-wide-cols 383
    "Target column count for the wide frame state.")

  (defvar kyra-frame-narrow-cols 283
    "Target column count for the narrow frame state.")

  (defun kyra-center-frame-horizontally (&optional frame)
    "Center FRAME horizontally within its active monitor's workarea."
    (let* ((frame (or frame (selected-frame)))
           (workarea (cdr (assoc 'workarea (frame-monitor-attributes frame))))
           (wa-x (nth 0 workarea))
           (wa-width (nth 2 workarea))
           (frame-px-width (frame-pixel-width frame))
           (new-left (+ wa-x (/ (- wa-width frame-px-width) 2)))
           (current-top (cdr (assoc 'top (frame-parameters frame)))))
      (set-frame-position frame new-left current-top)))

  (defun kyra-toggle-frame-width ()
    "Toggle frame width using exact subpixel text geometry and fringe padding."
    (interactive)
    (let* ((frame (selected-frame))
           (current-cols (frame-width frame))
           (current-text-px (frame-text-width frame))
           ;; Measure exact glyph width for current columns
           (current-glyphs-px (string-pixel-width (make-string current-cols ?x)))
           ;; Calculate internal padding (fringes + internal borders)
           (internal-chrome (max 0 (- current-text-px current-glyphs-px)))
           ;; Total target text-area width = glyph subpixel width + internal padding
           (wide-px (+ (string-pixel-width (make-string kyra-frame-wide-cols ?x)) internal-chrome))
           (narrow-px (+ (string-pixel-width (make-string kyra-frame-narrow-cols ?x)) internal-chrome))
           (target-px (if (< (abs (- current-text-px wide-px))
                             (abs (- current-text-px narrow-px)))
                          narrow-px
                        wide-px)))
      (set-frame-size frame target-px (frame-text-height frame) t)
      (kyra-center-frame-horizontally frame))))
