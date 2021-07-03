;;; init-vc.el --- configs for vc

;;; Code:

;;; Keys
(define-key global-map (kbd "C-x v j") #'fei-vc-dired-jump)

;;; Vars

(setq log-edit-hook
      '(log-edit-insert-message-template
	log-edit-insert-cvs-template
	log-edit-insert-changelog
	;; log-edit-insert-filenames-without-changelog
	auto-fill-mode
	display-fill-column-indicator-mode
	))
;;; Funcs

(defun fei-vc-dired-jump (arg)
  (interactive "P")
  (if-let ((target-dir (vc-root-dir)))
      (vc-dir target-dir)
    (message "no git repo")))

(provide 'init-vc)
