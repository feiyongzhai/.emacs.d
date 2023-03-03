(defvar fei-timer-for-promodo nil)

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
    (erase-buffer)
    (insert (format "%s" (propertize "时间到了！" 'display '(height 10))))

    ;; 设置快捷键 
    (let ((map (make-sparse-keymap)))
      (set-keymap-parent map (current-local-map))
      (define-key map "q" #'fei-promodo-quit-buffer)
      (use-local-map map))

    (fit-frame-to-buffer)

    ))

(defun fei-promodo-quit-buffer ()
  (interactive)
  ;; fei-timer-for-promodo 是一个不重复的 timer，运行完之后就没结束了，所以不需要 cancel-timer
  ;; (cancel-timer 'fei-timer-for-promodo)
  (jump-to-register ?p))

(provide 'fei-promodo)
