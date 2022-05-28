;; The tweak for default minibuffer completion ui

(define-key minibuffer-local-map (kbd "C-M-i") 'switch-to-completions)
(define-key completion-list-mode-map (kbd "C-M-i") 'switch-to-minibuffer)
(define-key minibuffer-local-map (kbd "M-i") 'switch-to-completions)
(define-key completion-list-mode-map (kbd "M-i") 'switch-to-minibuffer)

;; powered by emacs29
(setq minibuffer-completion-auto-choose nil)
(setq completions-format 'horizontal)	  ;horizontal
(setq completion-flex-nospace nil)	  ;nil
(setq completions-detailed nil)		  ;nil
(setq completion-auto-help t)		  ;t
(setq completion-auto-select t)		  ;nil，这个设置搭配上面的快捷键效果还不错

(define-key minibuffer-local-map (kbd "C-p") 'minibuffer-previous-completion)
(define-key minibuffer-local-map (kbd "C-n") 'minibuffer-next-completion)
(define-key minibuffer-local-completion-map (kbd "<C-return>") 'minibuffer-choose-completion)
(define-key completion-list-mode-map (kbd "n") 'next-line)
(define-key completion-list-mode-map (kbd "j") 'next-line)
(define-key completion-list-mode-map (kbd "p") 'previous-line)
(define-key completion-list-mode-map (kbd "k") 'previous-line)
(define-key completion-list-mode-map (kbd "f") 'next-completion)
(define-key completion-list-mode-map (kbd "l") 'next-completion)
(define-key completion-list-mode-map (kbd "b") 'previous-completion)
(define-key completion-list-mode-map (kbd "h") 'previous-completion)
(define-key completion-list-mode-map (kbd "s") 'isearch-forward)
(define-key completion-list-mode-map (kbd "S") 'swiper-isearch)
(define-key completion-list-mode-map (kbd "r") 'isearch-backward)
(define-key completion-list-mode-map (kbd "R") 'swiper-isearch-backward)
;; (define-key minibuffer-local-must-match-map (kbd "RET") 'minibuffer-choose-completion)
;; (define-key minibuffer-local-map (kbd "<return>") 'minibuffer-choose-completion)
;; (define-key minibuffer-local-map (kbd "C-M-j") 'minibuffer-complete-and-exit)

(provide 'init-minibuffer)
