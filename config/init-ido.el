;;; init-ido --- configs for ido and smex

;;; Code:


(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-max-window-height 1)
(setq ido-use-virtual-buffers t)
;; Disable auto merge work directories behavior, But you can merge
;; manually by M-s undo merge by C-z manually
(setq ido-auto-merge-work-directories-length -1)
(setq smex-prompt-string "^_^ ")
(global-set-key (kbd "M-x") 'smex)

(provide 'init-ido)
