;; -*- lexical-binding: t; -*-
;;
;; ███████╗███╗   ███╗ █████╗  ██████╗███████╗
;; ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝
;; █████╗  ██╔████╔██║███████║██║     ███████╗
;; ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║
;; ███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║
;; ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
;; A cross-platform, extensible & free text editor.
;; https://www.gnu.org/software/emacs

;; Make native compilation silent.
(use-package comp
  :ensure nil
  :when (native-comp-available-p)
  :custom
  (native-comp-async-report-warnings-errors 'silent))
;; (when (native-comp-available-p)
;;   (setq native-comp-async-report-warnings-errors 'silent))

;; Don't use customizations
(use-package cus-edit
  :defer t
  :custom
  ;; See https://lists.gnu.org/archive/html/bug-gnu-emacs/2025-08/msg01420.html
  ;;(custom-file null-device "Don't store customizations")
  (custom-file (expand-file-name "custom.el" user-config-directory)))

;; Explicit hook naming
(use-package use-package
  :demand t
  :custom
  (use-package-hook-name-suffix nil))

;; Use MELPA for packages
(use-package package
  :demand t
  :config
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/")))

;; Define here, so Flycheck plays nicely with this
;; https://github.com/emacscollective/no-littering/issues/143
(eval-and-compile
  (setq no-littering-etc-directory (expand-file-name "~/.cache/emacs/etc/")
        no-littering-var-directory (expand-file-name "~/.cache/emacs/var/")))

;; Don't litter Emacs directory
(use-package no-littering
  :ensure t
  :demand t)

;; Use PATH from shell
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (setq exec-path-from-shell-variables '("PATH" "ODIN_ROOT"))
  (exec-path-from-shell-initialize))

;; Delight
(use-package delight
  :ensure t)

;; Ensure load-path includes custom lisp dir during compilation/Flycheck
(eval-and-compile
  ;; Fallback for standalone Flycheck checking passes
  (unless (boundp 'user-config-directory)
    (defvar user-config-directory user-emacs-directory
      "Directory for user configuration files."))
  (add-to-list 'load-path (expand-file-name "lisp" user-config-directory))
  (require 'kyra-loader))

(use! :modules
      essentials         ;; Emacs UI, keybinds etc.
      leader             ;; Leader key config via General
      desktop            ;; Mainly frame size/pos saving, no buffers
      theme              ;; Main theme
      modeline           ;; Custom modeline
      tabs               ;; Editor tabs
      dashboard          ;; Dashboard on startup
      which-key
      help
      keycast            ;; Key broadcasting
      tree-sitter        ;; Built-in tree-sitter support
      lsp                ;; Eglot LSP config
      parens             ;; Parentheses highlighting
      snippets
      completion         ;; Completion (corfu+orderless,vertico,marginalia)
      dired              ;; Dired
      search             ;; Searching and grepping
      window             ;; Everything windows
      frame              ;; Where there are windows there's a frame
      vterm              ;; Terminal support
      compile            ;; Compilation buffer customizations
      multiple-cursors
      embark
      navigation         ;; Navigation (avy,consult)
      region             ;; Actions on active regions
      undo               ;; Everything undo
      elisp              ;; Elisp, check-parens and rainbow delimiters
      cc                 ;; C/C++
      c3                 ;; C3 language
      odin               ;; Odin
      vlang              ;; V programming language
      lua                ;; Lua support
      fish               ;; Fish shell
      yaml               ;; YAML
      markdown           ;; Markdown mode
      just               ;; Justfile
      )
