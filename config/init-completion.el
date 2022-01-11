;;; init-completion.el  --- configs for counsel/swiper/ivy/ido

(ivy-mode 1)

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
    ("C-c b" . counsel-bookmark)
    ("C-c g" . counsel-git)
    ("C-c r" . counsel-rg)
    ("C-c k" . counsel-rg)
    ("M-s r" . counsel-rg)
    ("C-c v" . ivy-push-view)
    ("C-c V" . ivy-pop-view)
    ("C-x f" . counsel-find-file)
    ("C-x d" . counsel-dired)
    ("C-S-s" . swiper)    
    ("M-x" . counsel-M-x)
    ("C-x C-f" . counsel-find-file)
    ))
(global-set-key (kbd "C-c l") 'counsel-locate)
(define-key ivy-minibuffer-map (kbd "M-h") (kbd "RET"))

(with-eval-after-load 'counsel
  ;; For my laptop: Linux Mint 20
  (add-to-list 'counsel-wmctrl-ignore "桌面")
  (setq-default ivy-initial-inputs-alist nil)
  )

(setq counsel-search-engine 'google)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

;; (setq search-default-mode #'char-fold-to-regexp)

;; ido
(setq ido-enable-flex-matching t)
;; (setq ido-max-window-height 1)
(setq ido-use-virtual-buffers nil)
;; Disable auto merge work directories behavior, But you can merge
;; manually by M-s, undo merge by C-z manually
(setq ido-auto-merge-work-directories-length -1)

(provide 'init-completion)
;;; init-completion.el ends here.
