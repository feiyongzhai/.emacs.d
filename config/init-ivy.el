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
  
  ;; Fasd
  (add-to-list 'load-path "~/.emacs.d/extensions/fasd")
  (autoload 'fasd-ivy-find-file "fasd" nil t)
  (global-set-key (kbd "C-c j") 'fasd-ivy-find-file)
  (setq fasd-add-file-to-db-when-eshell t)
  (setq fasd-enable-initial-prompt nil)

  (with-eval-after-load 'ivy
    ;; 因为 fasd 的原因，需要在 ivy 之后加载
    (require 'fasd)
    (global-fasd-mode t)
    ))

(fei-define-key-with-map global-map
  '(
    ("C-h f" . counsel-describe-function)
    ("C-h o" . counsel-describe-symbol)
    ("C-h v" . counsel-describe-variable)
    ("C-h C-l" . counsel-find-library)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c K" . fei-counsel-rg-my-org)
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

(provide 'init-ivy)
