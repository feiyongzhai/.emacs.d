(defvar fei-timer-for-pomodoro nil)
(defvar fei-continue-times 0)

(defcustom fei-pomodoro-message
  '(
    "去做 10 个俯卧撑!"
    "去做 10 个深蹲!"
    "去看看风景吧!"
    "上个厕所吧!"
    "用冷水洗洗脸"
    "干点别的吧！"
    "起来走走吧!"
    )
  "用于番茄时钟时间到了的时候随机显示的文本素材"
  :type '(repeat string)
  )

(defvar fei-pomodoro-todo-message nil)

(defun fei-pomodoro-set-todo-message ()
  (interactive)
  (setq fei-pomodoro-todo-message (read-string "你下次要记录的: ")))

(defun fei-pomodoro-set-timer (time)
  (setq fei-timer-for-pomodoro
	(run-with-timer
	 (org-timer-hms-to-secs (org-timer-fix-incomplete time))
	 t 'fei-pomodoro-notify))
  (message "Fei Pomodoro 开始"))

(defun fei-pomodoro-notify ()
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
    (if fei-pomodoro-todo-message
	(progn (insert fei-pomodoro-todo-message)
	       (setq fei-pomodoro-todo-message nil))
	(insert (format "%s" (propertize
			      (seq-random-elt fei-pomodoro-message)
			      'display '(height 5)))))
    
    (when (> fei-continue-times 0)
      (message "已经连续工作 %d 次" fei-continue-times))

    (read-only-mode)
    ;; 设置快捷键 
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map (current-local-map))
      (define-key map "q" #'fei-pomodoro-quit-buffer)
      (define-key map "c" #'fei-pomodoro-continue)
      (define-key map "s" #'fei-org-timer-set-timer)
      (define-key map (kbd "C-x k") (li (message "不要关闭我！")))
      (define-key map (kbd "M-k") (li (message "不要关闭我！")))
      (use-local-map map))

    ;; (set-frame-parameter nil 'fullscreen 'nil) ;取消最大化和全屏，REF `toggle-frame-maximized'
    (fit-frame-to-buffer)
    ;; (my/frame-recenter)

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

(defun fei-org-timer-set-timer ()
  (interactive)
  (jump-to-register ?p)
  (call-interactively 'org-timer-set-timer)
  )

(defun fei-remove-kill-emacs-pomodoro-query ()
  (setq kill-emacs-query-functions
	(remove 'fei-pomodoro-kill-emacs-query-function kill-emacs-query-functions)))

(defun fei-add-kill-emacs-pomodoro-query ()
  (add-to-list 'kill-emacs-query-functions 'fei-pomodoro-kill-emacs-query-function))

(add-hook 'org-timer-set-hook 'fei-add-kill-emacs-pomodoro-query)
(add-hook 'org-timer-done-hook 'fei-remove-kill-emacs-pomodoro-query)
(add-hook 'org-timer-stop-hook 'fei-remove-kill-emacs-pomodoro-query)
(add-hook 'org-timer-done-hook 'fei-pomodoro-notify)

(defun fei-pomodoro-kill-emacs-query-function ()
  (yes-or-no-p "有运行的番茄时钟！确定退出吗？")
  )

(defun fei-pomodoro-continue ()
  (interactive)
  (org-timer-set-timer "30")
  (jump-to-register ?p)
  (setq fei-continue-times (1+ fei-continue-times))
  (message "Fei Pomodoro 继续... %d 次" fei-continue-times))

(defun fei-pomodoro-quit-buffer ()
  (interactive)
  ;; fei-timer-for-pomodoro 是一个不重复的 timer，运行完之后就没结束了，所以不需要 cancel-timer
  ;; (cancel-timer 'fei-timer-for-pomodoro)
  (setq fei-continue-times 0)
  (jump-to-register ?p))

;; @REF: https://christiantietze.de/posts/2021/06/emacs-center-window-single-function/
(defun my/frame-recenter (&optional frame)
  "Center FRAME on the screen.
FRAME can be a frame name, a terminal name, or a frame.
If FRAME is omitted or nil, use currently selected frame."
  (interactive)
  (unless (eq 'maximised (frame-parameter nil 'fullscreen))
    (let* ((frame (or (and (boundp 'frame)
			    frame)
		      (selected-frame)))
	   (frame-w (frame-pixel-width frame))
	   (frame-h (frame-pixel-height frame))
	   ;; frame-monitor-workarea returns (x y width height) for the monitor
	   (monitor-w (nth 2 (frame-monitor-workarea frame)))
	   (monitor-h (nth 3 (frame-monitor-workarea frame)))
	   (center (list (/ (- monitor-w frame-w) 2)
			 (/ (- monitor-h frame-h 34) 2)))) ;34 是考虑 win10 任务栏的高度
      (apply 'set-frame-position (flatten-list (list frame center))))))

(provide 'fei-pomodoro)
