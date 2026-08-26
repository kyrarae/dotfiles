;; -*- lexical-binding: t; -*-

(defun treesit-ensure-grammar (recipe)
  "Register RECIPE in `treesit-language-source-alist` and compile if missing."
  (add-to-list 'treesit-language-source-alist recipe)
  (unless (treesit-language-available-p (car recipe))
    (treesit-install-language-grammar (car recipe))))

;; Treesitter
(use-package treesit
  :init
  (setq treesit-extra-load-path
        (list (no-littering-expand-var-file-name "treesit/")))
  :config
  (advice-add 'treesit-install-language-grammar :around
              (lambda (orig-fun lang &optional _out-dir)
                (let ((target-dir (no-littering-expand-var-file-name "treesit/")))
                  (make-directory target-dir t)
                  (funcall orig-fun lang target-dir)))))

;; Configure built-in Tree-sitter mode remappings
(use-package emacs
  :init
  (setq major-mode-remap-alist
        '((yaml-mode . yaml-ts-mode)
          (lua-mode  . lua-ts-mode)
          (c-mode    . c-ts-mode)
          (c++-mode  . c++-ts-mode))))
