;;; init-completion.el  --- configs for counsel/swiper/ivy/ido

(ivy-mode 1)
;; (vertico-mode 1)

(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

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
    ("C-c v p" . ivy-push-view)
    ("C-c v P" . ivy-pop-view)
    ("C-c v s" . ivy-switch-view)
    ("C-x f" . counsel-find-file)
    ("C-S-s" . swiper-isearch)
    ("M-x" . counsel-M-x)
    ("C-c l" . counsel-locate)
    ("C-x C-f" . counsel-find-file)
    ))

(global-set-key (kbd "C-c r") 'counsel-register)
(global-set-key (kbd "C-c K") 'counsel-kmacro)
(define-key ivy-minibuffer-map (kbd "M-h") (kbd "RET"))
(define-key ivy-minibuffer-map (kbd "M-j") 'fei-rime-force-enable)

(with-eval-after-load 'counsel
  ;; For my laptop: Linux Mint 20
  (add-to-list 'counsel-wmctrl-ignore "桌面")
  (setq-default ivy-initial-inputs-alist nil)
  )

(setq counsel-search-engine 'google)
(setq ivy-use-virtual-buffers t)

(setq ivy-height-alist
      '(
	(swiper-isearch . 1)		; 让 swiper-isearch 更像 isearch
	))

;; (setq search-default-mode #'char-fold-to-regexp)

;; Ido
(setq ido-enable-flex-matching t)
(setq ido-use-virtual-buffers nil)
;; (setq ido-max-window-height 1)
;; Disable auto merge work directories behavior, But you can merge
;; manually by M-s, undo merge by C-z manually
(setq ido-auto-merge-work-directories-length -1)

;; ==== vertico / marginalia / embark / orderless ====

;; Embark
(setq prefix-help-command 'embark-prefix-help-command)

;; Vertico + Orderless
(defun +vertico-init-minibuffer ()
  (setq-local completion-styles '(basic orderless)))

(with-eval-after-load 'vertico
  (require 'orderless)
  (add-hook 'minibuffer-setup-hook '+vertico-init-minibuffer))

;; Orderless 添加拼音支持
;; @REF https://elpa.gnu.org/packages/pyim.html#org787edf5
(require 'pyim)
(defun my-orderless-regexp (orig_func component)
  (let ((result (funcall orig_func component)))
    (pyim-cregexp-build result)))

(advice-add 'orderless-regexp :around #'my-orderless-regexp)


(provide 'init-completion)
;;; init-completion.el ends here.
