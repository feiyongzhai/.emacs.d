;;; init-ivy.el  --- configs for counsel/swiper/ivy

;; (ivy-mode 1)

(setq counsel-search-engine 'google)
(setq ivy-use-virtual-buffers t)

(setq ivy-height-alist
      '(
	(swiper-isearch . 1) ; make swiper-isearch behave like isearch
	))

;; Keys
(when *is-linux*
  (global-set-key (kbd "C-c w") 'counsel-wmctrl)
  (global-set-key (kbd "C-c m") 'counsel-linux-app)
  (global-set-key (kbd "C-c p") 'proced)
  
  )

(global-set-key (kbd "M-s l") 'counsel-load-theme)

(fei-define-key-with-map global-map
  '(
    ("C-h f" . counsel-describe-function)
    ("C-h o" . counsel-describe-symbol)
    ("C-h v" . counsel-describe-variable)
    ("C-h C-l" . counsel-find-library)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c j" . fei-counsel-recentf-pinyin)
    ("C-x f" . counsel-find-file)
    ("M-x" . counsel-M-x)
    ("M-s y" . counsel-yank-pop)
    ))

(defun fei-counsel-recentf-pinyin ()
  (interactive)
  (require 'pyim-cregexp-utils)
  (let ((ivy-re-builders-alist
	 '((t . pyim-cregexp-ivy))))
    (call-interactively 'counsel-recentf)
    ))

(cond
 (*is-windows*
  (global-set-key (kbd "C-c l") 'counsel-locate))
 (t
  (global-set-key (kbd "C-c l") 'locate)
  (global-set-key (kbd "C-c L") 'counsel-locate)
  ))
  
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
   '(("t" (lambda (file) (find-file-other-tab file)) "other tab")))
  )

(global-set-key (kbd "M-s n") 'fei-swiper-isearch)
(global-set-key (kbd "M-s p") 'fei-swiper-isearch-backward)

(defun fei-swiper-isearch ()
  (interactive)
  (require 'pyim-cregexp-utils)
  (let ((ivy-re-builders-alist
	 '((t . pyim-cregexp-ivy))))
    (call-interactively 'swiper-isearch)
    ))

(defun fei-swiper-isearch-backward ()
  (interactive)
  (require 'pyim-cregexp-utils)
  (let ((ivy-re-builders-alist
	 '((t . pyim-cregexp-ivy))))
    (call-interactively 'swiper-isearch-backward)
    ))

(global-set-key (kbd "C-M-z") 'fei-compile)
(defun fei-compile ()
  (interactive)
  (condition-case err
      ;; condition-case 是用来处理 error 的
      ;; see also (info "(elisp) Error Symbols")
      (call-interactively 'counsel-compile)
    (error (call-interactively 'compile))))

(provide 'init-ivy)
