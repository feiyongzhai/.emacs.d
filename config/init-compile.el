(with-eval-after-load 'compile
  (define-key compilation-mode-map (kbd "d") 'fei-cmp-change-dire-recompile)
  (define-key compilation-mode-map (kbd "e") 'compile))

(defun fei-cmp-change-dire-recompile ()
  (interactive)
  (setq target-dir (read-file-name "recompile at: " default-directory nil t))
  (let ((default-directory target-dir))
    (message "%s" default-directory)
    (compile compile-command)))

(provide 'init-compile)
