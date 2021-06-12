;;; init-misc.el --- misc configs

(require 'init-func)

;;; Code:

;;; mode enable or disable
(global-auto-revert-mode t) ;; autoload the file changes on disk
(delete-selection-mode t)   ;; 选中文本后输入会覆盖
(save-place-mode t)

;;; Keys

(global-set-key (kbd "C-z") #'undo)
(global-set-key (kbd "C-x u") #'transient-undo)
(global-set-key (kbd "<f9>") #'global-set-or-unset-key)
(global-set-key (kbd "ESC ESC c") #'open-my-init-file)
(global-set-key (kbd "M-0") #'fei-google-search)
(global-set-key (kbd "M--") #'fei-meow-last-buffer)

;;; replace y-or-n frome yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)
;; 回车代替输入y
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

;;; Vars

;;; no bell
;; 参考链接：https://www.newsmth.net/nForum/#!article/Emacs/97642
(setq ring-bell-function 'ignore)

;; no backup-file
;; (setq make-backup-files nil)
;;; redirect the backup file path
(setq backup-directory-alist (quote (("." . "~/.emacs.d/.backup"))))

;;; 此配置配合`auto-save'避免写在*scratch*中的内容未保存导致的数据丢失
(add-hook 'after-init-hook
	  (lambda ()
	    (find-file "~/.emacs.d/@scratch@")
	    ;; (setq initial-buffer-choice "~/.emacs.d/@scratch@")
	    (kill-buffer "*scratch*")))


;;; Funcs

;;; quick set key and unset key
(defun global-set-or-unset-key (arg)
  (interactive "P")
  (if arg
      (call-interactively 'global-unset-key)
    (call-interactively 'global-set-key)))

(transient-command transient-undo
  (undo)
  '(("u" . undo)))

(defun open-my-init-file()
  "打开我的 init.el 文件"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

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

(provide 'init-misc)
;;; init-misc.el ends here.
