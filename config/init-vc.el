;;; init-vc.el --- configs for vc

;;; Code:

;;; Keys
(define-key global-map (kbd "C-x v j") #'fei-vc-dired-jump)

;;; Funcs

(defun fei-vc-dired-jump (arg)
  (interactive "P")
  (if-let ((target-dir (vc-root-dir)))
      (vc-dir target-dir)
    (message "no git repo")))

(provide 'init-vc)
