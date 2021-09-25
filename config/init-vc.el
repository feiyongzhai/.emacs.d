;;; init-vc.el --- configs for vc

;;; Keys

(global-set-key (kbd "s-v") 'vc-prefix-map)
(global-set-key (kbd "s-v s-v") 'vc-next-action)

(global-set-key (kbd "C-x v j") #'fei-vc-dired-jump)
(with-eval-after-load 'vc-git
  (define-key vc-git-log-edit-mode-map (kbd "M-A") 'vc-git-log-edit-toggle-amend)
  (define-key vc-git-log-edit-mode-map (kbd "M-C") 'log-edit-done)
  (define-key vc-git-log-edit-mode-map (kbd "M-D") 'log-edit-show-diff))

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
