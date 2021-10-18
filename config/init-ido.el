;;; init-ido --- configs for ido and smex

;;; Mode

(ido-mode 1)

;;; Keys
(define-key minibuffer-local-map (kbd "M-j") (kbd "RET"))
(define-key minibuffer-local-map (kbd "M-h") (kbd "RET"))
;;;TODO：ido-mode 下的 minibuffer-complete 对应的是 ido-complete，所以下面的命令需要重新写一下
(define-key minibuffer-local-map (kbd "M-i") 'minibuffer-complete)
;;;TODO：下面的 with-eval-after-load 不奏效，目前还没有找到具体的原因
(with-eval-after-load 'ido-mode
  (define-key ido-completion-map (kbd "M-v") 'ido-switch-to-completions)
  (define-key ido-file-completion-map (kbd "M-v") 'ido-switch-to-completions)
  (define-key ido-buffer-completion-map (kbd "M-v") 'ido-switch-to-completions))

;;; Vars

(setq ido-enable-flex-matching t)
;; (setq ido-max-window-height 1)
(setq ido-use-virtual-buffers nil)
;; Disable auto merge work directories behavior, But you can merge
;; manually by M-s, undo merge by C-z manually
(setq ido-auto-merge-work-directories-length -1)


(provide 'init-ido)
