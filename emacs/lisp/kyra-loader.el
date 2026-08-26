;;; kyra-loader.el --- Custom module loader macro -*- lexical-binding: t; -*-

(eval-and-compile
  ;; Fallback for standalone Flycheck checking passes
  (unless (boundp 'user-config-directory)
    (defvar user-config-directory user-emacs-directory
      "Directory for user configuration files."))
  
  (defvar kyra-module-dir (expand-file-name "modules" user-config-directory)
    "Directory where flat module files are located.")

  (defun kyra--parse-module-spec (spec)
    "Parse SPEC into feature flag variables and a file load form.
SPEC can be a symbol (`tabs`) or a list with flags (`(vertico +childframe)`)."
    (let* ((module-sym (if (listp spec) (car spec) spec))
           (flags (when (listp spec) (cdr spec)))
           (mod-str (symbol-name module-sym))
           (file-path (expand-file-name (format "%s.el" mod-str) kyra-module-dir))
           ;; Generates setq forms like: (setq kyra-vertico-+childframe-p t)
           (flag-set-forms
            (mapcar (lambda (flag)
                      (let ((var-name (intern (format "kyra-%s-%s-p" mod-str flag))))
			`(setq ,var-name t)))
                    flags)))
      `(progn
	 ,@flag-set-forms
	 (if (file-exists-p ,file-path)
             (load ,file-path nil t)
           (message "Warning: Module %s not found at %s" ',module-sym ,file-path))))))

(defmacro use! (&rest args)
  "Declaratively load modules from a directory with flag support.
ARGS can be a list of symbols (`tabs`) or a list with flags"
  (let ((expanded-calls '())
        (modules (if (eq (car args) :modules) (cdr args) args)))
    (dolist (spec modules)
      (push (kyra--parse-module-spec spec) expanded-calls))
    `(progn ,@(nreverse expanded-calls))))

(provide 'kyra-loader)
;;; kyra-loader.el ends here
