(setq tab-bar-format
      '(tab-bar-format-history
	tab-bar-format-tabs
	tab-bar-separator
	tab-bar-format-add-tab
	tab-bar-format-align-right
	tab-bar-format-global ;在 emacsclient gui/tui 混用情况下有问题
	))

(setq tab-bar-show t)
(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice 'ibuffer)	;default is duplicate
(setq tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
(setq tab-bar-tab-name-function 'tab-bar-tab-name-truncated)
;; (setq tab-bar-new-tab-choice 'eshell)

(define-key tab-switcher-mode-map (kbd "q") 'tab-close)
(global-set-key (kbd "<C-tab>") 'tab-next)
(global-set-key (kbd "M-`") 'tab-recent) ;这个按键总是会被系统占用
(global-set-key (kbd "M-s C-l") 'tab-recent)
(global-set-key (kbd "M-s C-n") 'tab-new)
(global-set-key (kbd "M-s M-n") 'tab-next)
(global-set-key (kbd "M-s M-p") 'tab-previous)
(global-set-key (kbd "M-s C-w") 'tab-close)
(global-set-key (kbd "M-s C-m") 'fei-tab-switch)
(global-set-key (kbd "M-s C-i") 'tab-bar-echo-area-print-tab-names)

(add-hook 'term-mode-hook '+fei-term-mode-hook)

(defun +fei-term-mode-hook ()
  (define-key term-raw-map (kbd "M-`") 'tab-recent)
  (define-key term-mode-map (kbd "M-s") 'nil)
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

(provide 'init-tab-bar)
