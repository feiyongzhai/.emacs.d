;; (vertico-posframe-mode)
;; (setq vertico-posframe-border-width 4)
;; (setq vertico-posframe-min-height 20)
;; (setq vertico-posframe-min-width 150)

(vertico-mode)
(vertico-mouse-mode)
;; (vertico-grid-mode)
;; (vertico-buffer-mode)
(vertico-multiform-mode)		;I really like this feature

(setq vertico-multiform-commands
      '((consult-line buffer)
	(execute-extended-command flat)
        (consult-imenu reverse buffer)
	(fei-consult-ripgrep-my-org buffer)
	(rime-select-schema flat)
	(fei-switch-to-buffer-from-bs flat)
        ))

;; 回归默认样式
;; (setq vertico-multiform-categories
;;       '((file flat)
;; 	(buffer unobtrusive)))

(setq prefix-help-command 'embark-prefix-help-command)

;; Temporary toggling between the different display modes is
;; possible. Bind the following commands:


;;; Some enhanced feature

;; (marginalia-mode -1)


;; ==== [consult] ====

;; (setq register-preview-function 'consult-register-format)
;; consult-register-format 不可以正确处理 register name 是字符串的情况，如 `zygospore-spore-formation-register-name'

(setq register-preview-delay .1)
(setq register-preview-function 'register-preview-default)

(defun fei-consult-ripgrep-my-org ()
  (interactive)
  (consult-ripgrep "~/Nutstore Files/org" nil))

(provide 'init-vertico)
