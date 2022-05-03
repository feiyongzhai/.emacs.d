;;; init-ivy.el  --- configs for counsel/swiper/ivy

;; (ivy-mode 1)

(setq counsel-search-engine 'google)
(setq ivy-use-virtual-buffers t)

(setq ivy-height-alist
      '(
	(swiper-isearch . 1)		; 让 swiper-isearch 更像 isearch
	))

;; Keys
(when *is-linux*
  (global-set-key (kbd "C-c w") 'counsel-wmctrl)
  (global-set-key (kbd "C-c m") 'counsel-linux-app)
  (global-set-key (kbd "C-c p") 'proced)
  )

(fei-define-key-with-map global-map
  '(
    ("C-h f" . counsel-describe-function)
    ("C-h o" . counsel-describe-symbol)
    ("C-h v" . counsel-describe-variable)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c K" . fei-counsel-rg-my-org)
    ("C-x f" . counsel-find-file)
    ("M-x" . counsel-M-x)
    ("M-s y" . counsel-yank-pop)
    ))

(global-set-key (kbd "C-c l") 'locate)
(global-set-key (kbd "C-c L") 'counsel-locate)

(with-eval-after-load 'ivy
  (define-key ivy-minibuffer-map (kbd "M-j") 'fei-rime-force-enable)
  )

(with-eval-after-load 'counsel
  ;; For my laptop: Linux Mint 20
  (add-to-list 'counsel-wmctrl-ignore "桌面")
  (add-to-list 'counsel-wmctrl-ignore "xfce4-panel")
  (setq-default ivy-initial-inputs-alist nil)

  (ivy-add-actions
   'counsel-find-file
   '(("t" (lambda (file) (find-file-other-tab file)) "other tab")
     ;; ("e" fei-counsel-find-file-eshell-here-action "eshell here") ;工作不符合预期，应该是 counsel-find-file 封装了比较复杂的机制
     ))
  )

(with-eval-after-load 'fasd
  (ivy-add-actions
   'fasd-ivy-find-file
   '(("e" fei-counsel-find-file-eshell-here-action "eshell here"))))

(defun fei-counsel-find-file-eshell-here-action (file)
  (let ((dir (if (file-directory-p file)
		 file
	       (file-name-directory file)))
	(buf (eshell))
	eshell-list-files-after-cd)
    (set-buffer buf)
    ;; (message "eshell previous at: %s" default-directory)
    ;; bind `eshell-list-files-after-cd' with `t' will cause error
    ;; when run `eshell/cd' in lisp code. as shown below. but it
    ;; won't cause any problem when use `cd' in eshell buffer. so I
    ;; use let-bind `eshell-list-files-after-cd' with nil
    (unless (string= default-directory dir)
      ;; (message "eshell jump to: %s" dir)
      (eshell/cd dir)
      (eshell-reset))))

(provide 'init-ivy)

