;;; init-company.el --- configs for company

(require 'init-func)

;;; Keys

(with-eval-after-load 'company
  (define-key company-mode-map (kbd "C-M-i") #'company-complete)
  (fei-define-key-with-map company-active-map
    '(("M-n" . company-select-next)
      ("M-p" . company-select-previous)
      ("M-i" . yas-next-field-or-maybe-expand)
      ("TAB" . company-complete-selection)
      ("M-h" . company-complete-selection)
      ("M-H" . company-complete-common)
      ("M-w" . company-show-location)
      ("M-s" . company-filter-candidates)
      ))
  
  (setq company-show-numbers t)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1
	company-tooltip-limit 10
	company-echo-delay (if (display-graphic-p) nil 0))
  ;;; 避免补全中文的一个workaround
  (setq company-dabbrev-char-regexp "[-_a-zA-Z0-9]")
  )

;;; {{ company related config copied from centuar emacs
(setq company-tooltip-align-annotations t
      company-require-match nil
      company-dabbrev-ignore-case nil
      company-dabbrev-downcase nil
      company-global-modes '(not erc-mode message-mode help-mode
                                 gud-mode eshell-mode shell-mode)
      company-backends '(company-keywords company-files (company-capf :with company-yasnippet) company-dabbrev))
;;; }}


(provide 'init-company)
;;; init-company.el ends here.
