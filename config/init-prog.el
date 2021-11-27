(setq ahk-indentation 4)
(add-hook 'c-mode-hook 'electric-pair-local-mode)
(add-hook 'c++-mode-hook 'electric-pair-local-mode)
(add-hook 'python-mode-hook 'electric-pair-local-mode)

(provide 'init-prog)
