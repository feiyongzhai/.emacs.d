(pdf-loader-install)			;这个更快一些
;; (pdf-tools-install)

(defun fei-pdf-view-open-pdf-external ()
  (interactive)
  (when (and (eq major-mode 'pdf-view-mode))
    (start-process "evince" nil
		   "evince" "-i" (number-to-string (pdf-view-current-page)) (buffer-file-name))))

(provide 'init-pdf-tools)
