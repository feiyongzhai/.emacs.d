;;; init-vc.el --- configs for vc

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
;;; Funcs

(defun fei-vc-dired-jump (arg)
  (interactive "P")
  (let ((target-dir (or (vc-root-dir)
                        default-directory)))
    (vc-dir target-dir))
  )

(provide 'init-vc)
