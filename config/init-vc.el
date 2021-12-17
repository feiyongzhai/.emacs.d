;;; init-vc.el --- configs for vc

(require 'fei-funcs)

;;; Keys

(global-set-key (kbd "C-x v j") #'fei-vc-dired-jump)

;;; Vars

(setq log-edit-hook
      '(log-edit-insert-message-template
	log-edit-insert-cvs-template
	log-edit-insert-changelog
	;; log-edit-insert-filenames-without-changelog
	auto-fill-mode
	display-fill-column-indicator-mode
        (lambda () (require 'rime) (activate-input-method 'rime))
	))

(provide 'init-vc)
