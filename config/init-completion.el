;;; init-completion.el  --- configs for counsel/swiper/ivy/ido

;;; Mode

;;; 默认不启用 `ivy-mode'
(ivy-mode 1)
;; (ivy-posframe-mode 1)

;;; Keys
(when *is-linux*
  (global-set-key (kbd "C-c w") 'counsel-wmctrl)
  (global-set-key (kbd "C-c m") 'counsel-linux-app)
  (global-set-key (kbd "C-x p") 'proced)
  )
(fei-define-key-with-map global-map
  '(
    ("<f1> f" . counsel-describe-function)
    ("<f1> v" . counsel-describe-variable)
    ("C-c b" . counsel-bookmark)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c v" . ivy-push-view)
    ("C-c V" . ivy-pop-view)
    ("C-x b" . counsel-switch-buffer)
    ("C-x f" . counsel-find-file)
    ("C-x C-f" . counsel-find-file)
    ("C-x d" . counsel-dired)
    ("C-x C-d" . counsel-dired)
    ("M-x" . counsel-M-x)
    ))
(global-set-key (kbd "C-c l") 'counsel-locate)
(define-key ivy-minibuffer-map (kbd "M-j") (kbd "RET"))
(define-key ivy-minibuffer-map (kbd "M-h") (kbd "RET"))
(define-key minibuffer-local-map (kbd "M-j") (kbd "RET"))
(define-key minibuffer-local-map (kbd "M-h") (kbd "RET"))

;;; Vars

;;; ido {{
(setq ido-enable-flex-matching t)
;; (setq ido-max-window-height 1)
(setq ido-use-virtual-buffers nil)
;; Disable auto merge work directories behavior, But you can merge
;; manually by M-s, undo merge by C-z manually
(setq ido-auto-merge-work-directories-length -1)
;;; ido }}

(with-eval-after-load 'counsel
  ;; For my laptop: Linux Mint 20
  (add-to-list 'counsel-wmctrl-ignore "桌面")
  (setq-default ivy-initial-inputs-alist nil))

(setq ivy-posframe-display-functions-alist
    '((t . ivy-posframe-display-at-frame-top-center)
      ))

;; (setq ivy-posframe-display-functions-alist
;;     '((swiper . ivy-posframe-display-at-frame-bottom-window-center)
;;       (complete-symbol . ivy-posframe-display-at-point)
;;       (counsel-M-x . ivy-posframe-display-at-frame-center)
;;       (counsel-find-file . ivy-posframe-display-at-frame-center)
;;       (ivy-switch-buffer . ivy-posframe-display-at-frame-center)))

(setq counsel-search-engine 'google)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

;; (setq search-default-mode #'char-fold-to-regexp)


(provide 'init-completion)
;;; init-completion.el ends here.

