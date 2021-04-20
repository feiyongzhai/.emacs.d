;;; init-misc.el --- misc configs

;;; Code:

;;; Add to list `user/package-ensure-installed'
(add-to-list 'user/package-ensure-installed 'treemacs-all-the-icons)

;;; treemacs 按键
(global-set-key (kbd "C-c SPC") 'treemacs)

;;; autoload the changes
(global-auto-revert-mode t)

;;; no bells
;; 问题：这个配置的确可以避免没有声音，但是会用任务栏的图标变亮来代替
;; （最主要的是这个图标会一直亮，更加打扰了。。）
;; (setq visible-bell 0)
;; 这个配置现在工作符合预期
;; 参考链接：https://www.newsmth.net/nForum/#!article/Emacs/97642
(setq ring-bell-function 'ignore)

;;; replace y-or-n frome yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)
;; 回车代替输入y
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

;;; 选中文本后输入会覆盖
(delete-selection-mode t)

;; no backup-file
;; (setq make-backup-files nil)
;;; redirect the backup file path
(setq backup-directory-alist (quote (("."."~/.emacs.d/.backup"))))

;;; personal configs
(if *is-windows*
    ;; 启动 emacs 后的默认文件夹是桌面文件夹
    (cd "D:/桌面"))

;;; quick set key and unset key
(global-set-key (kbd "<f9>") (defun global-set-or-unset-key (arg)
			       (interactive "P")
			       (if arg
				   (call-interactively 'global-unset-key)
				 (call-interactively 'global-set-key))))

;;; cd-to-emacs
(global-set-key (kbd "C-c M-e") 
		(defun user/cd-to-emacs ()
		  (interactive)
		  (cd "~/.emacs.d/")
		  (pwd)))

;;; cd-to-desktop
(global-set-key (kbd "C-c M-d") 
		(defun user/cd-to-desktop ()
		  (interactive)
		  (if *is-windows*
		      (progn
			(cd "D:/桌面")
			(pwd))
		    (if *is-linux*
			(progn
			  (cd "~/桌面")
			  (pwd))))))

;;; cd-to-org
(global-set-key (kbd "C-c M-o") 
		(defun user/cd-to-org ()
		  (interactive)
		  (cd "~/Nutstore Files/org")
		  (pwd)))

(defun open-my-init-file()
  "打开我的 init.el 文件"
  (interactive)
  (find-file "~/.emacs.d/init.el"))
;; (global-set-key (kbd "<f12>") 'open-my-init-file)

;;; 一些常用键位优化
(define-key global-map (kbd "M-z") 'switch-to-buffer)
(global-set-key (kbd "C-c b") 'list-bookmarks)

;;; 避免自己手贱动不动就关闭 emacs
;; (emacs-lock-mode)

;;; 快速切换上一个 buffer --- code copied from meow-mode
(defun user/meow-last-buffer (arg)
  "Switch to last buffer.
Argument ARG if not nil, switching in a new window."
  (interactive "P")
  (cond
   ((minibufferp)
    (keyboard-escape-quit))
   ((not arg)
    (mode-line-other-buffer))
   (t
    (split-window)
    (mode-line-other-buffer))))
;; 按键
(define-key global-map (kbd "C--") #'user/meow-last-buffer)

(provide 'init-misc)
;;; init-misc.el ends here.
