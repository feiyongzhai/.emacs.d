(add-to-list 'load-path "~/Repos/lsp-bridge")

;; corfu 配置:
(setq lsp-bridge-completion-provider 'corfu)
(require 'corfu)
(require 'corfu-info)
(require 'corfu-history)

(require 'lsp-bridge)             ;; 加载lsp-bridge
(require 'lsp-bridge-orderless)   ;; 支持代码补全时模糊搜索，可选
(require 'lsp-bridge-icon)        ;; 补全菜单显示类型图标，可选

(dolist (hook (list
	       'rust-mode-hook
	       'c-mode-hook
	       'c++-mode-hook
	       'python-mode-hook))
  (add-hook hook 'fei-lsp-bridge-hook))

(defun fei-lsp-bridge-hook ()
  (lsp-bridge-mode 1)
  (company-mode -1)
  (corfu-mode)
  )

(define-key lsp-bridge-mode-map (kbd "<f2>") 'lsp-bridge-rename)
(define-key lsp-bridge-mode-map (kbd "C-M-.") 'lsp-bridge-find-references)

;; Xref 配置：
(add-hook 'lsp-bridge-mode-hook (lambda ()
  (add-hook 'xref-backend-functions #'lsp-bridge-xref-backend nil t)))

(provide 'init-lsp-bridge)
