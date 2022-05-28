(require 'orderless)
(add-hook 'minibuffer-setup-hook '+orderless-init-minibuffer)

(defun +orderless-init-minibuffer ()
  (setq-local completion-styles '(basic partial-completion orderless flex)))

;; Orderless 添加拼音支持，因为 orderless 的作用范围是所有 minibufer 补全
;; @REF https://elpa.gnu.org/packages/pyim.html#org787edf5
(require 'pyim)
(defun my-orderless-regexp (orig_func component)
  (let ((result (funcall orig_func component)))
    (pyim-cregexp-build result)))

(advice-add 'orderless-regexp :around #'my-orderless-regexp)

(provide 'init-orderless)
