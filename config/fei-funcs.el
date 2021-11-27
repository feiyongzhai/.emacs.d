;;; 一些单独工作的小函数

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

(defun fei-google-search (&rest search-string)
  "Googles a query or region if any.

参考链接：https://liujiacai.net/blog/2020/11/25/why-emacs/"
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if search-string
	(eshell-flatten-and-stringify search-string)	
      (if mark-active
          (buffer-substring (region-beginning) (region-end))
	(read-string "Google: "))))))

(defun fei-kill-current-buffer (arg)
  "智能关闭 windows 和 buffer"
  (interactive "P")
  (cond
   ((minibufferp)
    (keyboard-escape-quit))
   ((or arg (one-window-p))
    (kill-buffer))
   (t (kill-buffer-and-window))))

(provide 'fei-funcs)
