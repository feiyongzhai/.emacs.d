;;; init-ido --- configs for ido and smex

;;; Code:

;;; Add to `fei-package-ensure-installed'
(add-to-list 'fei-package-ensure-installed 'smex)

(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-max-window-height 1)
(setq ido-use-virtual-buffers t)
(setq smex-prompt-string "^_^ ")
(global-set-key (kbd "M-x") 'smex)

(provide 'init-ido)
