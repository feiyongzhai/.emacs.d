(vertico-mode)
(vertico-mouse-mode)
;; (vertico-grid-mode)
;; (vertico-buffer-mode)
(vertico-multiform-mode)		;I really like this feature

(setq vertico-multiform-commands
      '((consult-line buffer)
        (consult-imenu reverse buffer)
	(rime-select-schema flat)
        (execute-extended-command flat)))

(setq vertico-multiform-categories
      '((file buffer grid)
	(buffer unobtrusive)))

(define-key vertico-map (kbd "C-M-j") 'vertico-exit-input)
(define-key vertico-map (kbd "C-'") 'vertico-quick-exit)
(define-key vertico-map (kbd "M-o") 'embark-act)
;; embark-act 这个东西还是在 minibuffer 中好用，在别的场景中使用有点水土不服

;; Temporary toggling between the different display modes is
;; possible. Bind the following commands:

(define-key vertico-map "\M-V" #'vertico-multiform-vertical)
(define-key vertico-map "\M-G" #'vertico-multiform-grid)
(define-key vertico-map "\M-F" #'vertico-multiform-flat)
(define-key vertico-map "\M-R" #'vertico-multiform-reverse)
(define-key vertico-map "\M-U" #'vertico-multiform-unobtrusive)


;;; Some enhanced feature

;; (marginalia-mode -1)

;; (vertico-posframe-mode)
;; (setq vertico-posframe-border-width 4)
;; (setq vertico-posframe-min-height 20)
;; (setq vertico-posframe-min-width 150)


(provide 'init-vertico)
