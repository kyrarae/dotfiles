;; -*- lexical-binding: t; -*-

;; Embark
(use-package embark
  :ensure t
  :init
  (setq embark-indicators
	'(embark-mixed-indicator
          embark-highlight-indicator
          embark-isearch-highlight-indicator)
	embark-verbose-indicator-display-action
	'((display-buffer-at-bottom)
          (window-parameters (mode-line-format . none))
          (window-height . fit-window-to-buffer)))
  :config
  ;; Open target right
  (defun +embark:find-file-right (target)
    (split-window-right)
    (other-window 1)
    (find-file target))

  ;; Open target below
  (defun +embark:find-file-below (target)
    (split-window-below)
    (other-window 1)
    (find-file target))

  ;; Embark actions
  (defun +embark:split-right-current-completion-candidate ()
    "Open current candidate in a new split on the right."
    (interactive)
    (embark--act #'+embark:find-file-right (car (embark--targets)) t))

  (defun +embark:split-below-current-completion-candidate ()
    "Open current candidate in a new split below."
    (interactive)
    (embark--act #'+embark:find-file-below (car (embark--targets)) t))
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)
	 ("C-c s r" . +embark:split-right-current-completion-candidate)
	 ("C-c s b" . +embark:split-below-current-completion-candidate)))

(use-package embark-consult
  :after (embark consult)
  :ensure t)
