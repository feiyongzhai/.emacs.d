;;; ext-ivy.el.el  --- configs for counsel/swiper/ivy

;; (ivy-mode 1)

;; (ivy-posframe-mode)
(setq ivy-posframe-display-functions-alist
      '((swiper-isearch  . ivy-display-function-fallback)
	(counsel-compile . ivy-display-function-fallback)
        (t               . ivy-posframe-display)))

(setq counsel-search-engine 'google)
(setq ivy-use-virtual-buffers t)

(setq ivy-height-alist
      '(
	(swiper-isearch . 1) ; make swiper-isearch behave like isearch
	))

(defun fei-counsel-recentf-pinyin ()
  (interactive)
  (require 'pyim-cregexp-utils)
  (let ((ivy-re-builders-alist
	 '((t . pyim-cregexp-ivy))))
    (call-interactively 'counsel-recentf)))

(defun fei-counsel-switch-buffer ()
  (interactive)
  (require 'pyim-cregexp-utils)
  (let ((ivy-re-builders-alist
	 '((t . pyim-cregexp-ivy))))
    (call-interactively 'counsel-switch-buffer)))

(with-eval-after-load 'counsel
  ;; For my laptop: Linux Mint 20
  (add-to-list 'counsel-wmctrl-ignore "桌面")
  (add-to-list 'counsel-wmctrl-ignore "xfce4-panel")
  (setq-default ivy-initial-inputs-alist nil)

  (ivy-add-actions
   'counsel-find-file
   '(("t" (lambda (file) (find-file-other-tab file)) "other tab")))
  )

(defun fei/swiper ()
  (interactive)
  (require 'pyim-cregexp-utils)
  (let ((ivy-re-builders-alist
	 '((t . pyim-cregexp-ivy))))
    (call-interactively 'swiper)))

(defun fei-swiper-isearch2 ()
  (interactive)
  (move-to-window-line 0)
  (fei-swiper-isearch))

(defun fei-swiper-isearch ()
  (interactive)
  (require 'pyim-cregexp-utils)
  (let ((ivy-re-builders-alist
	 '((t . pyim-cregexp-ivy))))
    (call-interactively 'swiper-isearch)))

(defun fei-swiper-isearch-backward ()
  (interactive)
  (require 'pyim-cregexp-utils)
  (let ((ivy-re-builders-alist
	 '((t . pyim-cregexp-ivy))))
    (call-interactively 'swiper-isearch-backward)))

(defun fei-compile ()
  (interactive)
  (condition-case err
      ;; condition-case 是用来处理 error 的
      ;; see also (info "(elisp) Error Symbols")
      (call-interactively 'counsel-compile)
    (error (call-interactively 'compile))))

(provide 'ext-ivy.el)
