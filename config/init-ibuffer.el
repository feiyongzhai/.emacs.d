;;; init-ibuffer.el  --- configs for ibuffer

;;; Code:

;;; Keys
(global-set-key (kbd "C-x C-b") (lambda () (interactive) (ibuffer-jump) (ibuffer-auto-mode 1)))
(global-set-key (kbd "C-x 4 C-b") (lambda () (interactive) (ibuffer-jump t) (ibuffer-auto-mode 1)))

;;; Vars

(setq ibuffer-show-empty-filter-groups nil) ;; 不显示空组
(setq ibuffer-movement-cycle nil)

(add-hook 'ibuffer-mode-hook #'hl-line-mode)
;;; 2021-07-02: 小毛病终于解决了，见第6行的配置
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
