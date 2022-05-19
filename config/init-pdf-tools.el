(pdf-tools-install)
(define-key pdf-view-mode-map (kbd "j") 'pdf-view-next-line-or-next-page)
(define-key pdf-view-mode-map (kbd "k") 'pdf-view-previous-line-or-previous-page)
(define-key pdf-view-mode-map (kbd "e") 'fei-pdf-view-open-pdf-external)

(defun fei-pdf-view-open-pdf-external ()
  (interactive)
  (when (and (eq major-mode 'pdf-view-mode))
    (start-process "evince" nil
		   "evince" "-i" (number-to-string (pdf-view-current-page)) (buffer-file-name))))

(provide 'init-pdf-tools)
