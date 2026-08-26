;; -*- lexical-binding: t; -*-

;; I-search
(use-package isearch
  :ensure nil
  :custom
  (isearch-lazy-count t)
  (lazy-count-prefix-format "(%s/%s) ")
  (lazy-count-suffix-format nil)
  (search-highlight t)
  (isearch-lazy-highlight t)
  (isearch-allow-scroll t))

;; I-search minibuffer
(use-package isearch-mb
  :ensure t
  :init
  (isearch-mb-mode 1)
  :config
  ;; Workaround to use avy-isearch with isearch-mb instead
  ;; of just using isearch-mode-map.
  (add-to-list 'isearch-mb--after-exit #'avy-isearch)
  (add-to-list 'isearch-mb--after-exit #'consult-line)
  :bind (:map isearch-mb-minibuffer-map
         ("M-j"   . avy-isearch)      ; Jump with Avy
         ("M-l"   . consult-line)     ; Pivot search to Consult menu
         ("M-r"   . query-replace)))  ; Start find-and-replace for this string

;; wgrep
(use-package wgrep
  :ensure t
  :bind (:map grep-mode-map
              ("e" . wgrep-change-to-wgrep-mode)
              ("C-x C-q" . wgrep-change-to-wgrep-mode)
              ("C-c C-c" . wgrep-finish-edit)))
