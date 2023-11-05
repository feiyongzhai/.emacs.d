;; 零撒配置集合


;; icomplete 相关配置
(fido-mode)
(fido-vertical-mode)
(setq icomplete-compute-delay 0.01)

(define-key icomplete-fido-mode-map (kbd "C-M-j") 'icomplete-fido-exit)


;; ido 配置
(setq ido-enable-flex-matching t)
(setq ido-use-virtual-buffers nil)
;; (setq ido-max-window-height 1)
;; Disable auto merge work directories behavior, But you can merge
;; manually by M-s, undo merge by C-z manually
(setq ido-auto-merge-work-directories-length -1)
(define-key ido-common-completion-map (kbd "C-M-j") 'ido-select-text)


;; minibuffer 配置
(define-key minibuffer-local-map (kbd "C-M-i") 'switch-to-completions)
(define-key completion-list-mode-map (kbd "C-M-i") 'switch-to-minibuffer)
(define-key completion-list-mode-map (kbd "M-e") 'switch-to-minibuffer) ;参照 isearch 快捷键
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


;;; Org
;; 设置各个标题的大小，不使用配色来区分 headline 层级

;; 受观点（REF1）的影响和促动，决定还是把 org-mode 搞得简单一点，朴素一点，不太在意 org-mode 长什么样，而是在意我要干什么。
;; 把重点从 EMACS 的身上转移到我真正要做的事情身上
;; @REF1: https://emacs-china.org/t/emacs/23849/94?u=yongfeizhai

(custom-set-faces
 '(org-level-1 ((t (:weight extra-bold :height 1.25))))
 '(org-level-2 ((t (:weight bold :height 1.15))))
 '(org-level-3 ((t (:weight bold :height 1.12))))
 '(org-level-4 ((t (:weight semi-bold :height 1.09))))
 '(org-level-5 ((t (:weight semi-bold :height 1.06))))
 '(org-level-6 ((t (:weight semi-bold :height 1.03))))
 '(org-level-8 ((t (:weight semi-bold)))))
