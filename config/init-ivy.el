;;; init-ivy.el  --- configs for counsel/swiper/ivy

;; (ivy-mode 1)

;; Keys
(when *is-linux*
  (global-set-key (kbd "C-c w") 'counsel-wmctrl)
  (global-set-key (kbd "C-c m") 'counsel-linux-app)
  (global-set-key (kbd "C-c p") 'proced)
  )

(fei-define-key-with-map global-map
  '(
    ("C-h f" . counsel-describe-function)
    ("C-h v" . counsel-describe-variable)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c K" . fei-counsel-rg-my-org)
    ("C-c v p" . ivy-push-view)
    ("C-c v P" . ivy-pop-view)
    ("C-c v s" . ivy-switch-view)
    ("C-x f" . counsel-find-file)
    ("C-S-s" . swiper-isearch)
    ("M-x" . counsel-M-x)
    ("C-x C-f" . counsel-find-file)
    ("M-s y" . counsel-yank-pop)
    ))

(global-set-key (kbd "C-c l") 'locate)
(global-set-key (kbd "C-c L") 'counsel-locate)

;; (global-set-key (kbd "C-x 8 e") 'ivy-emoji)
;; (global-set-key (kbd "C-c r") 'counsel-register)
(with-eval-after-load 'ivy
  (define-key ivy-minibuffer-map (kbd "M-h") (kbd "RET"))
  (define-key ivy-minibuffer-map (kbd "M-j") 'fei-activate-pyim)
  )

(with-eval-after-load 'counsel
  ;; For my laptop: Linux Mint 20
  (add-to-list 'counsel-wmctrl-ignore "桌面")
  (setq-default ivy-initial-inputs-alist nil)

  (ivy-add-actions
   'counsel-find-file
   '(("t" (lambda (file) (find-file-other-tab file)) "other tab")))
  )

(setq counsel-search-engine 'google)
(setq ivy-use-virtual-buffers t)

(setq ivy-height-alist
      '(
	(swiper-isearch . 1)		; 让 swiper-isearch 更像 isearch
	))

;; (setq search-default-mode #'char-fold-to-regexp)

(provide 'init-ivy)

