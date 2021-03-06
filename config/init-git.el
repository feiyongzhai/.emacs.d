;;; init-git.el --- configs for git related

(require 'fei-funcs)
(setenv "EDITOR" "emacsclient")

;;; Var
(setq log-edit-hook
      '(log-edit-insert-message-template
	log-edit-insert-cvs-template
	log-edit-insert-changelog
	;; log-edit-insert-filenames-without-changelog
	auto-fill-mode
	display-fill-column-indicator-mode
        (lambda () (activate-input-method fei-ime))
	))

;;; Key
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x v j") 'fei-vc-dired-jump)
(with-eval-after-load 'vc-dir
  (define-key vc-dir-mode-map (kbd "h") 'magit-dispatch)
  (define-key vc-dir-mode-map (kbd "e") 'fei-eshell-cd-here) ;default is `vc-find-file'
  (define-key vc-dir-mode-map (kbd "j") 'project-find-file)
  (define-key vc-dir-mode-map (kbd "H") 'magit-status)
  (define-key vc-dir-mode-map (kbd "s") 'magit-stage)
  (define-key vc-dir-mode-map (kbd "!") 'shell-command)
  (define-key vc-dir-mode-map (kbd "&") 'async-shell-command)
  )

;;; Cmd
(defun fei-vc-dired-jump (arg)
  (interactive "P")
  (let ((target-dir (or (vc-root-dir)
                        default-directory)))
    (vc-dir target-dir)))

(provide 'init-git)
