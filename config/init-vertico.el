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
      '((consult-line buffer (:not flat))
	(yank-pop (:not flat))
	(cua-paste-pop (:not flat))
	(execute-extended-command flat)
	(embark-act grid)
        (consult-imenu reverse buffer)
	(fei-consult-ripgrep-my-org (:not flat))
	(rime-select-schema flat)
	(fei-switch-to-buffer-from-bs flat)
	(switch-to-locked-buffer flat)
	(t flat)			; 不匹配的命令所使用的样式
        ))

;; 回归默认样式
;; (setq vertico-multiform-categories
;;       '((file flat)
;; 	(buffer unobtrusive)))

(setq embark-indicators '(embark-minimal-indicator)) ; embark adction buffer is verbose
(setq prefix-help-command 'embark-prefix-help-command)
;; (setq embark-prompter 'embark-completing-read-prompter)

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
