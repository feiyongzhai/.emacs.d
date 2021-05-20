;;; init-misc.el --- misc configs

;;; Code:

;;; recentf-mode
;; (recentf-mode 1)
;; (setq recentf-max-menu-item 10)

;;; autoload the changes
(global-auto-revert-mode t)

;;; no bells
;; 问题：这个配置的确可以避免没有声音，但是会用任务栏的图标变亮来代替
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

(save-place-mode t)
;;; 此配置配合`auto-save'避免写在*scratch*中的内容未保存导致的数据丢失
(add-hook 'after-init-hook
	  (lambda ()
	    (find-file "~/.emacs.d/@scratch@")
	    ;; (setq initial-buffer-choice "~/.emacs.d/@scratch@")
	    (kill-buffer "*scratch*")
	    ))

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

(global-set-key (kbd "C-x u") #'transient-undo)
(defun transient-undo ()
  (interactive)
  (let ((echo-keystrokes nil))
    (undo)
    (set-transient-map
     (let ((map (make-sparse-keymap)))
       (define-key map "u" #'undo)
       map)
     t)))

(defun open-my-init-file()
  "打开我的 init.el 文件"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(define-key global-map (kbd "M-0") 'fei-google-search)

;;; 参考链接：https://liujiacai.net/blog/2020/11/25/why-emacs/
(defun fei-google-search ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))

;;; 避免自己手贱动不动就关闭 emacs
;; (emacs-lock-mode)

;;; 快速切换上一个 buffer --- code copied from meow-mode
(defun fei-meow-last-buffer (arg)
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
(define-key global-map (kbd "C--") #'fei-meow-last-buffer)

(provide 'init-misc)
;;; init-misc.el ends here.
