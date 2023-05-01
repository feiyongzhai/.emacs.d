(defun fei-kill-compilation ()
  (interactive)
  (ignore-errors (kill-compilation) (message "hh"))
  (compilation-mode))

(defun fei-cmp-change-run ()
  (interactive)
  (kill-compilation)
  (compile compile-command t))

(defun fei-cmp-change-dire-recompile ()
  (interactive)
  (setq target-dir (read-file-name "recompile at: " default-directory nil t))
  (let ((default-directory target-dir))
    (message "%s" default-directory)
    (compile compile-command)))

(defun my/apply-ansi-color-to-compilation-buffer-h ()
  "Applies ansi codes to the compilation buffers. Meant for
  `compilation-filter-hook'."
  (with-silent-modifications
    (ansi-color-apply-on-region compilation-filter-start (point))))

(add-hook 'compilation-filter-hook #'my/apply-ansi-color-to-compilation-buffer-h)

(provide 'init-compile)
