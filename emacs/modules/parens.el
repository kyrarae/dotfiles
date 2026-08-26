;; -*- lexical-binding: t; -*-

;; Highlight parenthesis
(use-package paren
  :ensure nil
  :custom
  (show-paren-mode t)
  (show-paren-delay 0.1)
  (show-paren-style 'parenthesis))

;; Smartparens
(use-package smartparens
  :ensure t
  :delight)
(use-package smartparens-config
  :ensure smartparens
  :functions
  sp-wrap-with-pair
  :config
  (dolist (pair '((paren "(")
                  (bracket "[")
                  (brace "{")
                  (single-quote "'")
                  (double-quote "\"")
                  (back-quote "`")))
    (let ((name (intern (format "wrap-with-%ss" (car pair))))
          (char (cadr pair)))
      (defalias name
        (lambda (&optional _arg)
          (interactive "p")
          (sp-wrap-with-pair char)))))
  :hook
  (prog-mode-hook . smartparens-mode)
  (conf-mode-hook . smartparens-mode)
  :bind (:map smartparens-mode-map
	      ("C-<right>"     . sp-forward-symbol)
	      ("C-<left>"      . sp-backward-symbol)
	      ("C-s-<right>"   . sp-forward-slurp-sexp)
	      ("C-M-<right>"   . sp-backward-barf-sexp)
	      ("C-s-<left>"    . sp-backward-slurp-sexp)
	      ("C-M-<left>"    . sp-forward-barf-sexp)
	      ("C-M-t"         . sp-transpose-sexp)
	      ("C-M-k"         . sp-kill-sexp)
	      ("C-k"           . sp-kill-hybrid-sexp)
	      ("M-k"           . sp-backward-kill-sexp)
	      ("C-M-w"         . sp-copy-sexp)
	      ("M-<backspace>" . sp-unwrap-sexp)
	      ("C-<backspace>" . sp-backward-kill-word)
	      ([remap sp-backward-kill-word] . backward-kill-word)
	      ("C-x C-t"       . sp-transpose-hybrid-sexp)
	      ("C-c ("         . wrap-with-parens)
	      ("C-c ["         . wrap-with-brackets)
	      ("C-c {"         . wrap-with-braces)
	      ("C-c '"         . wrap-with-single-quotes)
	      ("C-c \""        . wrap-with-double-quotes)
	      ("C-c `"         . wrap-with-back-quotes)))
