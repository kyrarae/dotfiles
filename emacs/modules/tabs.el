;; -*- lexical-binding: t; -*-

;; Centaur
(use-package centaur-tabs
  :ensure t
  :demand t
  :functions
  centaur-tabs-headline-match
  centaur-tabs-change-fonts
  :custom
  (centaur-tabs-style "bar")
  (centaur-tabs-height 20)
  (centaur-tabs-set-icons t)
  (centaur-tabs-show-new-tab-button t)
  (centaur-tabs-set-close-button nil)
  (centaur-tabs-modified-marker "•")
  (centaur-tabs-set-modified-marker t)
  (centaur-tabs-show-navigation-buttons t)
  (centaur-tabs-cycle-scope 'default)
  (centaur-tabs-left-edge-margin nil)
  (centaur-tabs-right-edge-margin nil)
  (centaur-tabs-excluded-prefixes `(" *which"
				    "*compilation"
				    "*Flycheck"
				    "*dashboard"
				    "*Packages"
				    " *posframe-"
				    "*posframe-"
				    " *vundo"
				    " *Embark"
				    " *Minibuf"))
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-change-fonts (face-attribute 'default :font) 130)
  (centaur-tabs-headline-match)
  :hook
  (dashboard-mode-hook . centaur-tabs-local-mode)
  :bind
  ("M-<left>" . centaur-tabs-backward)
  ("M-<right>" . centaur-tabs-forward))
