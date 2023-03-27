;; (package-initialize)
;; (evil-mode)
(setq viper-mode t)
(require 'viper)
(ido-mode t)
(setq ido-everywhere t)

(setq tab-always-indent 'complete)
(define-key minibuffer-local-map (kbd "C-M-i") 'switch-to-completions)
