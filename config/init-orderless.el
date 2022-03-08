;; ==== vertico / marginalia / embark / orderless ====

(vertico-mode 1)
(marginalia-mode)

;; consult
(setq consult-preview-key nil)		;不自动预览

;; Embark
(setq prefix-help-command 'embark-prefix-help-command)

;; Vertico + Orderless
(defun +vertico-init-minibuffer ()
  (setq-local completion-styles '(basic orderless)))

(with-eval-after-load 'vertico
  (require 'orderless)
  (add-hook 'minibuffer-setup-hook '+vertico-init-minibuffer))

;; Orderless 添加拼音支持
;; @REF https://elpa.gnu.org/packages/pyim.html#org787edf5
(require 'pyim)
(defun my-orderless-regexp (orig_func component)
  (let ((result (funcall orig_func component)))
    (pyim-cregexp-build result)))

(advice-add 'orderless-regexp :around #'my-orderless-regexp)

(provide 'init-orderless)
