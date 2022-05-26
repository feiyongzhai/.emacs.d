(setq tab-bar-format
      '(
	tab-bar-format-menu-bar
	tab-bar-format-tabs
	tab-bar-separator
	tab-bar-format-add-tab
	tab-bar-separator
	;; tab-bar-format-align-right
	;; tab-bar-format-history
	;; tab-bar-format-global ;在 emacsclient gui/tui 混用情况下有问题
	))

(setq tab-bar-show t)
(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice 'fei-eshell-cd-here) ;default is duplicate
(setq tab-bar-close-last-tab-choice nil)
(setq tab-bar-tab-name-function 'tab-bar-tab-name-truncated)
;; (setq tab-bar-new-tab-choice 'eshell)

(setq tab-bar-new-tab-to 'rightmost)
(defun fei-tab-duplicate-advisor (orig-fun &rest args)
  (let ((tab-bar-new-tab-to 'right))
    (apply orig-fun args)))
(advice-add 'tab-bar-duplicate-tab :around 'fei-tab-duplicate-advisor)

(define-key tab-switcher-mode-map (kbd "q") 'tab-close)

(add-hook 'term-mode-hook '+fei-term-mode-hook)

(defun +fei-term-mode-hook ()
  (define-key term-mode-map (kbd "M-s") 'nil)
  (define-key term-mode-map (kbd "M-0") 'nil)
  (define-key term-mode-map (kbd "M-1") 'nil)
  (define-key term-mode-map (kbd "M-2") 'nil)
  (define-key term-mode-map (kbd "M-3") 'nil)
  (define-key term-mode-map (kbd "M-4") 'nil)
  (define-key term-mode-map (kbd "M-5") 'nil)
  (define-key term-mode-map (kbd "M-6") 'nil)
  (define-key term-mode-map (kbd "M-7") 'nil)
  (define-key term-mode-map (kbd "M-8") 'nil)
  (define-key term-mode-map (kbd "M-9") 'nil)
  (define-key term-mode-map (kbd "M-`") 'nil)
  )

(defun fei-tab-switch (name)
  "这个代码从 emacs-29 的仓库中取出来的，当 emacs29 发布之后，这个函数就过时了"
  (interactive
   (let* ((recent-tabs (mapcar (lambda (tab)
                                 (alist-get 'name tab))
                               (tab-bar--tabs-recent))))
     (list (completing-read (format-prompt "Switch to tab by name"
                                           (car recent-tabs))
                            recent-tabs nil nil nil nil recent-tabs))))
  (let ((tab-index (tab-bar--tab-index-by-name name)))
    (if tab-index
        (tab-bar-select-tab (1+ tab-index))
      (tab-bar-new-tab)
      (tab-bar-rename-tab name))))

(defun fei-select-tab (&optional tab-number)
  "抄的 `tab-bar-select-tab'"
  (interactive "P")
  (unless (integerp tab-number)
    (let ((key (event-basic-type last-command-event)))
      (setq tab-number (if (and (characterp key) (>= key ?1) (<= key ?9))
                           (- key ?0)
                         0))))
  (let* ((tabs (funcall tab-bar-tabs-function))
	 (from-index (tab-bar--current-tab-index tabs)))
    (if (> tab-number (length tabs))
	(tab-new)
      (tab-bar-select-tab tab-number))))

(global-set-key [remap tab-bar-select-tab] 'fei-select-tab)
(global-set-key (kbd "M-0") 'tab-close)
(global-set-key (kbd "M--") 'tab-undo)
(global-set-key (kbd "M-`") 'tab-recent)

(provide 'init-tab-bar)
