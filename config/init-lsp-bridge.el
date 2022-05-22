(add-to-list 'load-path "~/Repos/lsp-bridge")
(setq lsp-bridge-python-command "/usr/bin/python3")

(require 'lsp-bridge)             ;; 加载lsp-bridge
(require 'lsp-bridge-ui)
(require 'lsp-bridge-ui-history)
(require 'lsp-bridge-orderless)   ;; make lsp-bridge support fuzzy match, optional

(dolist (hook (list
	       'rust-mode-hook
	       'c-mode-hook
	       'c++-mode-hook
	       'python-mode-hook))
  (add-hook hook 'fei-lsp-bridge-hook))

(defun fei-lsp-bridge-hook ()
  (lsp-bridge-mode 1)
  (company-mode -1)
  (lsp-bridge-ui-history-mode t)
  (lsp-bridge-ui-mode)
  )

(define-key lsp-bridge-mode-map (kbd "<f2>") 'lsp-bridge-rename)
(define-key lsp-bridge-mode-map (kbd "C-M-.") 'lsp-bridge-find-references)

;; Xref 配置：
(add-hook 'lsp-bridge-mode-hook (lambda ()
  (add-hook 'xref-backend-functions #'lsp-bridge-xref-backend nil t)))

(provide 'init-lsp-bridge)
