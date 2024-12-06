;; Native compilation
;(when (native-comp-available-p)
;  (startup-redirect-eln-cache "~/.cache/emacs/eln/")
;  (setq-default native-comp-jit-compilation nil))

;; Optimize startup
(customize-set-value 'gc-cons-threshold most-positive-fixnum)
(setq-default read-process-output-max (* 1024 1024))

(customize-set-value 'package-user-dir "~/.local/share/emacs/packages"
		     "For `package-vc'")

(provide 'early-init)
