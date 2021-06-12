;;; init-vc.el --- configs for vc

;;; Code:

;;; Keys
(define-key global-map (kbd "C-x v j") #'fei-vc-dired-jump)

;;; Funcs

(defun fei-vc-dired-jump (arg)
  (interactive "P")
  (let ((target-dir (vc-root-dir)))
    (if target-dir
	(vc-dir target-dir)
      (message "no git repo"))))


(provide 'init-vc)
