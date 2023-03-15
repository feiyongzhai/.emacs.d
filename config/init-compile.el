(defun fei-cmp-change-dire-recompile ()
  (interactive)
  (setq target-dir (read-file-name "recompile at: " default-directory nil t))
  (let ((default-directory target-dir))
    (message "%s" default-directory)
    (compile compile-command)))

(provide 'init-compile)
