;;; init-misc.el --- misc configs

(require 'init-func)

;;; mode enable or disable
(global-auto-revert-mode t) ;; autoload the file changes on disk
(delete-selection-mode t)   ;; 选中文本后输入会覆盖
(column-number-mode t)
(save-place-mode t)
(desktop-save-mode t)
(savehist-mode t)

;;; replace y-or-n frome yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

;;; Vars

(setq desktop-restore-frames nil)    ; don't restore any frame

(add-hook 'prog-mode-hook
	  (lambda ()
	    (company-mode t)
	    (yas-minor-mode t)
	    (menu-bar--display-line-numbers-mode-absolute)))

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

;;; enable disabled command
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;; Funcs

(defvar display-line-numbers-relative-p nil)

(defun display-line-numbers-cycle ()
  (interactive)
  (if display-line-numbers-relative-p
      (progn (menu-bar--display-line-numbers-mode-absolute)
	     (setq display-line-numbers-relative-p nil))
    (menu-bar--display-line-numbers-mode-relative)
    (setq display-line-numbers-relative-p t)))

(transient-command undo
  (undo)
  '(("u" . undo)))

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

(defun sudo-find-this-file ()
  (interactive)
  (if (buffer-file-name)
      ;; 不清楚 sudo:root@localhost: 表示的含义，但是现在这个命令能用
      (find-file (concat "/sudo:root@localhost:" buffer-file-name))
    (message "buffer without file can't deal with sudo")))

(provide 'init-misc)
;;; init-misc.el ends here.
