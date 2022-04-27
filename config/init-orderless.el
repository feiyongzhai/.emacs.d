(define-key minibuffer-local-map (kbd "C-M-i") 'switch-to-completions)
(define-key completion-list-mode-map (kbd "C-M-i") 'switch-to-minibuffer)

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
;; (define-key minibuffer-local-must-match-map (kbd "RET") 'minibuffer-choose-completion)
;; (define-key minibuffer-local-map (kbd "<return>") 'minibuffer-choose-completion)
;; (define-key minibuffer-local-map (kbd "C-M-j") 'minibuffer-complete-and-exit)

(require 'orderless)
(add-hook 'minibuffer-setup-hook '+orderless-init-minibuffer)

(defun +orderless-init-minibuffer ()
  (setq-local completion-styles '(basic orderless)))

;; Orderless 添加拼音支持，因为 orderless 的作用范围是所有 minibufer 补全
;; @REF https://elpa.gnu.org/packages/pyim.html#org787edf5
(require 'pyim)
(defun my-orderless-regexp (orig_func component)
  (let ((result (funcall orig_func component)))
    (pyim-cregexp-build result)))

(advice-add 'orderless-regexp :around #'my-orderless-regexp)

(provide 'init-orderless)
