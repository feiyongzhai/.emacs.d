;;; init-company.el --- configs for company

;;; Code:

;;; Add to `user/package-ensure-installed'
(add-to-list 'user/package-ensure-installed 'company)

;;; Keys tweaks
(with-eval-after-load 'company

  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)

  (setq company-idle-delay .1
      company-minimum-prefix-length 1)
  )

(provide 'init-company)
;;; init-company.el ends here.
