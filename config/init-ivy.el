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

(fei-define-key-with-map global-map
  '(
    ("C-h f" . counsel-describe-function)
    ("C-h o" . counsel-describe-symbol)
    ("C-h v" . counsel-describe-variable)
    ("C-h C-l" . counsel-find-library)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c j" . counsel-recentf)
    ("C-x f" . counsel-find-file)
    ("M-x" . counsel-M-x)
    ("M-s y" . counsel-yank-pop)
    ))

(cond
 (*is-windows*
  (global-set-key (kbd "C-c l") 'counsel-locate))
 (t
  (global-set-key (kbd "C-c l") 'locate)
  (global-set-key (kbd "C-c L") 'counsel-locate)
  ))
  
(with-eval-after-load 'ivy
  (define-key ivy-minibuffer-map (kbd "M-j") 'fei-ime-force-enable)
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


(provide 'init-ivy)
