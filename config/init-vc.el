;;; init-vc.el --- configs for vc

;;; Code:

(defun fei-vc-dired-jump (arg)
  (interactive "P")
  (let ((target-dir (vc-root-dir)))
    (if target-dir
	(vc-dir target-dir)
      (message "no git repo"))))
(define-key global-map (kbd "C-x v j") #'fei-vc-dired-jump)

(provide 'init-vc)
