;; Selected
;; Use special keymap when region is active
(use-package selected
  :ensure t
  :delight
  selected-minor-mode
  :init (selected-global-mode 1)
  :bind (:map selected-keymap
              ("q" . selected-off)
              ("u" . upcase-region)
              ("d" . downcase-region)
              ("w" . count-words-region)
              ("m" . apply-macro-to-region-lines)))

;; Expand region
(use-package expreg
  :ensure t
  :bind (("C-=" . expreg-expand)
         ("C--" . expreg-contract)
         (:repeat-map expreg-repeat-map
                      ("=" .  expreg-expand)
                      ("-" .  expreg-contract))))
