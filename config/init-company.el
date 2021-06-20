;;; init-company.el --- configs for company

(require 'init-func)

;;; Code:

;;; Keys

(with-eval-after-load 'company

  (define-key company-mode-map (kbd "M-/") #'company-complete)
  (define-key company-mode-map (kbd "C-M-i") #'company-complete)
  (fei-define-key-with-map company-active-map
    '(("M-n" . nil)
      ("M-p" . nil)
      ("M-/" . #'company-other-backend)))
  
  (setq company-idle-delay .1
	company-minimum-prefix-length 1))

(provide 'init-company)
;;; init-company.el ends here.