(setq tab-bar-show nil)
(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice nil)	;duplicate
(setq tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
;; (setq tab-bar-new-tab-choice 'eshell)
(define-key tab-switcher-mode-map (kbd "q") 'tab-close)
(global-set-key (kbd "M-`") 'tab-recent)

(provide 'init-tab-bar)
