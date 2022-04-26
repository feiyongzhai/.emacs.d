;; ==== vertico / marginalia / embark /  ====

(vertico-mode 1)
(vertico-mouse-mode 1)
(marginalia-mode -1)

;; Embark
;; (setq prefix-help-command 'embark-prefix-help-command)

;; Vertico + Orderless
(define-key vertico-map (kbd "C-M-j") 'vertico-exit-input)
(define-key vertico-map (kbd "C-'") 'vertico-quick-exit)

(provide 'init-vertico)
