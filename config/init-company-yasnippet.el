;;; init-company-yasnippet.el --- configs for company

(require 'init-func)

(defun +complete ()
  (interactive)
  (or (yas/expand)
      (company-indent-or-complete-common nil)))

(with-eval-after-load 'company
  (define-key company-mode-map (kbd "C-M-i") #'company-complete)
  (define-key company-mode-map (kbd "TAB") '+complete)
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

  (define-key company-search-map (kbd "M-n") 'company-select-next)
  (define-key company-search-map (kbd "M-n") 'company-select-previous)
  
  (setq company-show-numbers t)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1
	company-tooltip-limit 10
	company-echo-delay (if (display-graphic-p) nil 0))
  ;;; 避免补全中文的一个workaround
  (setq company-dabbrev-char-regexp "[-_a-zA-Z0-9]")

  ;; Add yasnippet support for all company backends.
  ;; @REF: lazycat init-company-mode.el
  (add-to-list 'company-transformers 'delete-dups)
  (defun company-mode/backend-with-yas (backend)
    (if (and (listp backend) (member 'company-yasnippet backend))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  )

;; @REF: Centuar Emacs
(setq company-tooltip-align-annotations t
      company-require-match nil
      company-dabbrev-ignore-case nil
      company-dabbrev-downcase nil
      company-global-modes '(not erc-mode message-mode help-mode
                                 gud-mode eshell-mode shell-mode)
      ;; company-backends '(company-keywords company-files (company-capf :with company-yasnippet) company-dabbrev)
      )

;; ==== yasnippet ====

(with-eval-after-load 'yasnippet
  (define-key yas-keymap [escape] nil)
  (define-key yas-keymap [tab] nil)
  (define-key yas-keymap (kbd "S-<tab>") nil)
  (define-key yas-keymap (kbd "TAB") nil)
  (define-key yas-keymap [return] 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "RET") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "S-<return>") 'yas-prev-field)
  (define-key yas-keymap (kbd "<backtab>") 'yas-prev-field))

(defun yasnippet-snippets--fixed-indent ()
  "Set `yas-indent-line' to `fixed'."
  (set (make-local-variable 'yas-indent-line) 'fixed))

(defun yasnippet-snippets--no-indent ()
  "Set `yas-indent-line' to nil."
  (set (make-local-variable 'yas-indent-line) nil))

(with-eval-after-load 'yasnippet
  (yas-load-directory (expand-file-name "~/.emacs.d/snippets") t))


(provide 'init-company-yasnippet)
;;; init-company-yasnippet.el ends here.
