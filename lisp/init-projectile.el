;;; init-projectile.el --- configs for projectile

;;; Code:

;;; Add to `fei-package-ensure-installed'
(add-to-list 'fei-package-ensure-installed 'projectile)

;;; 按键
(define-key global-map (kbd "C-x M-f") 'project-find-file)

(provide 'init-projectile)
;;; init-projectile.el ends here.
