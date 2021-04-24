;;; init-ibuffer.el  --- configs for ibuffer

;;; Code:

;;; ibuffer
(setq ibuffer-saved-filter-groups
	  '(("default"
		 ("C/C++" (or (name . "^.*\\.c$")
			      (name . "^.*\\.cpp$")))
		 ("Matlab" (name . "^.*\\.m$"))
		 ("Lisp" (or (name . "^.*\\.el$")
			     (mode . emacs-lisp-mode)))
		 ("Org" (or (mode . org-mode)
			    (mode . org-agenda-mode)))
		 ("Dired" (mode . dired-mode))
		 ("Emacs" (or (mode . eshell-mode)
			      (name . "^\\*ielm\\*$")))
		 ("Startup" (or (name . "^\\*scratch\\*$")
				(name . "^\\*Messages\\*$")))
		 ("PDF" (name . "^.*\\.pdf$"))
		 ;; 下面这个是贪婪匹配，就是匹配 * 开头和结尾所有句子（包括空格）
		 ("Files" (not (name . "^\\*.*\\*$")))
		 )))
;;; 不显示空组
(setq ibuffer-show-empty-filter-groups nil)

;; 我也不知道为什么，反正没有下面这句话就不奏效
;; (add-hook 'ibuffer-mode-hook
;; 	  (lambda ()
;; 	    (ibuffer-auto-mode 1)
;; 	    (ibuffer-switch-to-saved-filter-groups "default")
;; 	    ))
;; 不在 ibuffer 列表上面显示相关内容
;; (add-to-list 'ibuffer-never-show-predicates "zowie")
;;; 自动打开高亮行
(add-hook 'ibuffer-mode-hook #'hl-line-mode)

;; shortkeys
;; (global-set-key (kbd "C-x b") 'ibuffer)
(global-set-key (kbd "M-o") 'ibuffer)

(provide 'init-ibuffer)
;;; init-ibuffer.el ends here.
