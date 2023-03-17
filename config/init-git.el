;;; init-git.el --- configs for git related

(require 'fei-funcs)
(require 'git-commit)
(setenv "EDITOR" "emacsclient")

;;; Var
(setq log-edit-hook
      '(log-edit-insert-message-template
	log-edit-insert-cvs-template
	log-edit-insert-changelog
	;; log-edit-insert-filenames-without-changelog
	auto-fill-mode
	display-fill-column-indicator-mode
	(lambda () (activate-input-method default-input-method))
	))

;;; Cmd
(defun fei-vc-dired-jump (arg)
  (interactive "P")
  (let ((target-dir (or (vc-root-dir)
                        default-directory)))
    (vc-dir target-dir)))

(provide 'init-git)
