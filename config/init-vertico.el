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
      '((consult-line (:not flat))
	(yank-pop)			;nil means use vertical
	(cua-paste-pop)
	(execute-extended-command flat)
	(embark-act grid)
	(fei-consult-ripgrep-my-org)
        (rime-select-schema flat)
	(fei-switch-to-buffer-from-bs flat)
	(switch-to-locked-buffer flat)
	(t flat)			; 不匹配的命令所使用的样式
        ))

;; (setq vertico-multiform-categories
;;       '((file flat)
;; 	(buffer unobtrusive)))

(custom-set-faces
 '(embark-target ((t (:inherit menu)))))
(setq embark-indicators '(embark-minimal-indicator embark-highlight-indicator)) ; embark adction buffer is verbose
(setq prefix-help-command 'embark-prefix-help-command)
;; (setq embark-prompter 'embark-completing-read-prompter)


;;; ==== [Consult] ====

;; (setq register-preview-function 'consult-register-format)
;; consult-register-format 不可以正确处理 register name 是字符串的情况，如 `zygospore-spore-formation-register-name'

(setq register-preview-delay .1)
(setq register-preview-function 'register-preview-default)

(defun fei-consult-ripgrep-my-org ()
  (interactive)
  (consult-ripgrep "~/Nutstore Files/org" nil))

(provide 'init-vertico)
