;; 屏保小程序

(defun fei-clock-quit ()
  (interactive)
  (cancel-timer fei-timer)
  (jump-to-register ?1))

(defun fei-clock-start ()
  (interactive)
  (setq fei-timer
       (run-with-timer 1 1 'fei-clock-update-time))
  (window-configuration-to-register ?0)
  (frameset-to-register ?1)
  (pop-to-buffer "*FEI-CLOCK*")
  (fei-clock-update-time)

  (let ((ignore-window-parameters t))
    ;; set `ignore-window-parameters' to t to delete side windows
    (delete-other-windows))

  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map (current-local-map))
    (define-key map "q" #'fei-clock-quit)
    (use-local-map map))

  (fit-frame-to-buffer)
  )

(defun fei-clock-update-time ()
  (let ((buf (get-buffer-create "*FEI-CLOCK*")))
    (with-current-buffer buf
      (erase-buffer)
      (insert (format "%s"
		      (propertize (substring (current-time-string) 11 19)
				  'display '(height 10)))))))

(defun fei-clock-count-down ()
  "每次空闲 arg seconds 显示时钟"
  (interactive)
  (setq fei-clock-deamon
	(run-with-idle-timer
	 (read-number "空闲多久显示时钟屏保(秒): " 60)
	 t 'fei-clock-start)))

(defun fei-clock-deamon-quit ()
  (interactive)
  (cancel-timer fei-clock-deamon))

(provide 'fei-clock)
