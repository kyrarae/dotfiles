;; -*- lexical-binding: t; -*-

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind-keymap ("C-r"     . mc/keymap)
  :bind (:map mc/keymap
	      ("<up>"     . mc/mark-previous-like-this)
              ("<down>"   . mc/mark-next-like-this)
              ("C-<up>"   . mc/mark-previous-like-this-word)
              ("C-<down>" . mc/mark-next-like-this-word)
              ("M-<up>"   . mc/mark-previous-like-this-symbol)
              ("M-<down>" . mc/mark-next-like-this-symbol)
              ("C-S-h"    . mc/mark-all-like-this)
              ("C-h"      . mc/mark-all-words-like-this)
              ("M-h"      . mc/mark-all-symbols-like-this)
              ("C-e"      . mc/mark-more-like-this-extended)
              ("C-r"      . mc/edit-lines)
              ("M-n"      . mc/insert-letters)
              ("C-n"      . mc/insert-numbers)
              ("C-s"      . mc/sort-regions)
              ("M-s"      . mc/reverse-regions)
	      ("<escape>" . mc/keyboard-quit)))
