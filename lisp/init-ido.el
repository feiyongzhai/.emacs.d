;;; init-ido --- configs for ido and smex

;;; Code:

;;; Add to `user/package-ensure-installed'
(add-to-list 'user/package-ensure-installed 'smex)

(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-max-window-height 1)
(global-set-key (kbd "M-x") 'smex)

(provide 'init-ido)
