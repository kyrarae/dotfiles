;; -*- lexical-binding: t; -*-

(defvar kyra-completion-+childframe-p nil)

;; Corfu
(use-package corfu
  :ensure t
  ;; Force load on startup so :config runs immediately
  :demand t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 1)
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  (corfu-popupinfo-delay '(0.05 . 0.02))
  (corfu-popupinfo-max-height 20)
  (corfu-popupinfo-max-width 70)
  :bind (:map corfu-map
              ("TAB"      . corfu-next)
              ([tab]      . corfu-next)
              ("S-TAB"    . corfu-previous)
              ([backtab]  . corfu-previous)
              ("RET"      . corfu-insert)
              ("<return>" . corfu-insert)
	      ("M-d"      . corfu-popupinfo-toggle)
              ("M-n"      . corfu-popupinfo-scroll-up)
              ("M-p"      . corfu-popupinfo-scroll-down))
  :config
  (global-corfu-mode 1)
  (corfu-popupinfo-mode 1))

;; Ensure Eglot and Orderless play nicely with Corfu's completion backend
(setq completion-category-defaults nil)

;; Vertico helper
(defun vertico-format-candidate-with-arrow (orig-fun cand prefix suffix index start)
  "Prefix current Vertico candidate with an arrow."
  (let ((formatted-cand (funcall orig-fun cand prefix suffix index start)))
    (concat
     (if (= vertico--index index)
         (propertize "» " 'face 'vertico-current)
       "  ")
     formatted-cand)))

;; Vertico
(use-package vertico
  :ensure t
  :demand t
  :custom
  (vertico-count 17)
  ;; (vertico-multiform-categories
  ;;  '((file grid posframe)))
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1)
  (vertico-multiform-mode 1)
  (advice-add #'vertico--format-candidate
	      :around 'vertico-format-candidate-with-arrow)
  :bind (:map vertico-map
              ("M-j" . vertico-quick-jump)
	      ("C-g" . abort-recursive-edit)))

(use-package vertico-directory
  :after vertico
  :ensure nil ; vertico-directory comes bundled with the vertico package
  :bind (:map vertico-map
         ("DEL" . vertico-directory-delete-char)))

;; Show vertico in a child frame via posframe
(use-package vertico-posframe
  :ensure t
  :demand t
  :after vertico
  :when kyra-completion-+childframe-p
  :custom
  (posframe-text-scale-factor-function (lambda (_) 0))
  (vertico-posframe-poshandler #'posframe-poshandler-frame-bottom-center)
  (vertico-posframe-border-width 1)
  (vertico-posframe-hide-minibuffer t)
  (vertico-posframe-global t)
  (vertico-posframe-height nil)
  ;; (vertico-posframe-width 150)
  ;; (marginalia-margin-threshold 500)
  (vertico-posframe-parameters '((left-fringe . 5)
				 (right-fringe . 5)
				 (parent-frame . nil)
				 (alpha . 1.0)))
  :config
  (vertico-posframe-mode 1)
  (with-eval-after-load 'desktop
    (add-hook 'desktop-after-read-hook
              (lambda ()
                (when vertico-posframe-mode
                  (vertico-posframe-mode -1)
                  (vertico-posframe-mode 1))))))

;; Marginalia
;; Marginalia causes perf problems when using vertico-posframe.
;; Keep vertico-count <= 10, or disable marginalia
(use-package marginalia
  :ensure t
  :custom
  (marginalia-align 'left)
  (marginalia-max-relative-age 0)
  :config
  (marginalia-mode 1))

;; Orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((eglot (styles orderless basic)))))
