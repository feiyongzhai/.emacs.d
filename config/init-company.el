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
      ("M-i" . yas-expand)
      ("M-/" . company-other-backend)))
  
  (setq company-show-numbers t)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))


;;; Func

(with-eval-after-load 'yasnippet
  (with-eval-after-load 'company
    (defun company-yasnippet/yas-expand ()
      (interactive)
      (call-interactively 'company-yasnippet)
      (when (eq 1 company-candidates-length)
	(call-interactively 'yas-expand))
      )
    ))


(provide 'init-company)
;;; init-company.el ends here.
