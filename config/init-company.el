;;; init-company.el --- configs for company

(require 'init-func)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (company-mode t)
	    (yas-minor-mode t)
	    (menu-bar--display-line-numbers-mode-absolute)))

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
      ("M-/" . company-other-backend)
      ("C-w" . nil)
      ))

  (fei-define-key-with-map company-search-map
    '(("M-n" . company-select-next)
      ("M-p" . company-select-previous)))
  
  (setq company-show-numbers t)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1
	company-tooltip-limit 10
	company-echo-delay (if (display-graphic-p) nil 0))
  ;;; 避免补全中文的一个workaround
  (setq company-dabbrev-char-regexp "[-_a-zA-Z0-9]")
  )

;;; {{ config copied from centuar emacs
(setq company-tooltip-align-annotations t
      company-require-match nil
      company-dabbrev-ignore-case nil
      company-dabbrev-downcase nil
      company-global-modes '(not erc-mode message-mode help-mode
                                 gud-mode eshell-mode shell-mode)
      ;; company-backends '(company-keywords company-files (company-capf :with company-yasnippet) company-dabbrev)
      )
;;; }}

;; Add yasnippet support for all company backends.
;; @REF: lazycat init-company-mode.el
(with-eval-after-load 'company

  (add-to-list 'company-transformers 'delete-dups)

  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")

  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  )

(defun yasnippet-snippets--fixed-indent ()
  "Set `yas-indent-line' to `fixed'."
  (set (make-local-variable 'yas-indent-line) 'fixed))

(defun yasnippet-snippets--no-indent ()
  "Set `yas-indent-line' to nil."
  (set (make-local-variable 'yas-indent-line) nil))

(with-eval-after-load 'yasnippet
  (yas-load-directory (expand-file-name "~/.emacs.d/snippets") t))


(provide 'init-company)
;;; init-company.el ends here.
