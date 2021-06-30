;;; init-ibuffer.el  --- configs for ibuffer

;;; Code:

;;; Keys
(global-set-key (kbd "C-x C-b") (lambda () (interactive) (ibuffer-jump) (ibuffer-update nil t)))
(global-set-key (kbd "C-x 4 C-b") (lambda () (interactive) (ibuffer-jump t) (ibuffer-update nil t)))

;;; Vars

(setq ibuffer-show-empty-filter-groups nil) ;; 不显示空组
(setq ibuffer-movement-cycle nil)

(add-hook 'ibuffer-mode-hook #'hl-line-mode)
;;; ibuffer-auto-mode 和 hl-line-mode 一起使用的时候有个烦人的小毛病使
;;; 用快捷键进入 ibuffer 并不能高亮当前行，必须要移动一下光标才能高亮
;;; 当前行，就目前的使用情况来看，我更需要hl-line-mode正常工作，而反观
;;; ibuffer-auto-mode我用的很少，所以我现在把ibuffer-auto-mode关了，现
;;; 在暂时鱼和熊掌不可兼得。我现在只是在进入ibuffer的时候自动更新一下
;;; （见第6行的配置）
;; (add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode) 

;;; ibuffer group
(setq ibuffer-saved-filter-groups
      '(("default"
	 ("C/C++" (or (name . "^.*\\.c$")
		      (name . "^.*\\.cpp$")))
	 ("Matlab" (name . "^.*\\.m$"))
	 ("Lisp" (or (name . "^.*\\.el$")
		     (mode . emacs-lisp-mode)))
	 ("EAF" (mode . eaf-mode))
	 ("Org" (or (mode . org-mode)
		    (mode . org-agenda-mode)))
	 ("Dired" (mode . dired-mode))
	 ("Emacs" (or (mode . eshell-mode)
		      (name . "^\\*ielm\\*$")))
	 ("PDF" (name . "^.*\\.pdf$"))
	 ;; 下面这个是贪婪匹配，就是匹配 * 开头和结尾所有句子（包括空格）
	 ("Files" (not (name . "^\\*.*\\*$")))
	 )))

(provide 'init-ibuffer)
;;; init-ibuffer.el ends here.
