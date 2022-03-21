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
      ("C-h" . company-show-doc-buffer)	;当前编译的 emacs-28 按 C-h 会卡死。暂时关闭，不知道什么情况，现在又可以正常工作了
      ("M-i" . yas-next-field-or-maybe-expand)
      ("TAB" . company-complete-selection)
      ("M-h" . company-complete-selection)
      ("M-H" . company-complete-common)
      ("M-w" . company-show-location)
      ("M-s" . company-filter-candidates)
      ("M-/" . company-other-backend)
      ("M-g" . company-abort)
      ("C-w" . nil)
      ))

  (define-key company-search-map (kbd "M-n") 'company-select-next)
  (define-key company-search-map (kbd "M-p") 'company-select-previous)
  
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

;; ==== Yasnippet ====
(global-set-key (kbd "C-x y") 'yas-insert-snippet)
(global-set-key (kbd "C-M-y") 'company-yasnippet)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-M-y") 'fei-company-yasnippet) ;这个设计的不是很完美，不过也不经常用，不管了
  (defun fei-company-yasnippet ()
    "Hide the current completeions and show snippets."
    (interactive)
    (company-cancel)
    (call-interactively 'company-yasnippet)))
(with-eval-after-load 'yasnippet
  (define-key yas-keymap (kbd "M-n") 'company/yas-next)
  (define-key yas-keymap (kbd "M-p") 'company/yas-prev)

  ;; experiment
  ;; (define-key yas-minor-mode-map (kbd "SPC") yas-maybe-expand)
  ;; (define-key yas-minor-mode-map (kbd "RET") yas-maybe-expand)
  )

(defun company/yas-next ()
  (interactive)
  (or (when (company--active-p)
	(company-select-next))
      (yas-next-field)))

(defun company/yas-prev ()
  (interactive)
  (or (when (company--active-p)
	(company-select-previous))
      (yas-prev-field)))

(with-eval-after-load 'yasnippet
  (yas-load-directory (expand-file-name "~/.emacs.d/snippets") t))

(provide 'init-company-yasnippet)
