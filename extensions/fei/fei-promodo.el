(defvar fei-timer-for-promodo nil)
(defvar fei-continue-times 0)

(defun fei-promodo-set-timer (time)
  (setq fei-timer-for-promodo
	(run-with-timer
	 (org-timer-hms-to-secs (org-timer-fix-incomplete time))
	 t 'fei-promodo-notify))
  (message "Fei Promodo 开始"))

(defun fei-promodo-notify ()
  (raise-frame)
  (frameset-to-register ?p)
  (with-current-buffer (pop-to-buffer "*FEI-NOTIFY*")

    ;; 删除其他窗口
    (let ((ignore-window-parameters t))
      ;; set `ignore-window-parameters' to t to delete side windows
      (delete-other-windows))

    ;; 插入一些内容
    (read-only-mode -1)
    (erase-buffer)
    (insert (format "%s" (propertize "时间到了！" 'display '(height 10))))
    (when (> fei-continue-times 0)
      (message "已经连续工作 %d 次" fei-continue-times))

    (read-only-mode)
    ;; 设置快捷键 
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map (current-local-map))
      (define-key map "q" #'fei-promodo-quit-buffer)
      (define-key map "c" #'fei-promodo-continue)
      (define-key map (kbd "C-x k") (li (message "不要关闭我！")))
      (define-key map (kbd "M-k") (li (message "不要关闭我！")))
      (use-local-map map))

    (fit-frame-to-buffer)

    ))

(defun fei-pomodoro-timer ()
  (interactive)
  ;; `org-timer-set-timer' 会调用 `org-timer--get-timer-title' 来获取
  ;; `org-timer-countdown-timer-title'。故暂无法自定义 notify 消息。而
  ;; 且 org-timer-countdown-timer-title 是用 defvar 声明的，说明也没有
  ;; 想让我们自定义，不折腾为妙。
  (org-timer-set-timer "30")
  (message "开始倒计时")
  ;; (alarm-clock-set "2 seconds" "20分钟时间到了")
  )

(defun fei-remove-kill-emacs-promodo-query ()
  (setq kill-emacs-query-functions
	(remove 'fei-promodo-kill-emacs-query-function kill-emacs-query-functions)))

(defun fei-add-kill-emacs-promodo-query ()
  (add-to-list 'kill-emacs-query-functions 'fei-promodo-kill-emacs-query-function))

(add-hook 'org-timer-set-hook 'fei-add-kill-emacs-promodo-query)
(add-hook 'org-timer-done-hook 'fei-remove-kill-emacs-promodo-query)
(add-hook 'org-timer-done-hook 'fei-promodo-notify)

(defun fei-promodo-kill-emacs-query-function ()
  (yes-or-no-p "有运行的番茄时钟！确定退出吗？")
  )

(defun fei-promodo-continue ()
  (interactive)
  (org-timer-set-timer "30")
  (jump-to-register ?p)
  (setq fei-continue-times (1+ fei-continue-times))
  (message "Fei Promodo 继续... %d 次" fei-continue-times))

(defun fei-promodo-quit-buffer ()
  (interactive)
  ;; fei-timer-for-promodo 是一个不重复的 timer，运行完之后就没结束了，所以不需要 cancel-timer
  ;; (cancel-timer 'fei-timer-for-promodo)
  (setq fei-continue-times 0)
  (jump-to-register ?p))

(provide 'fei-promodo)
