(global-set-key (kbd "C-x M-b") 'switch-to-same-major-mode-buffer)

(defun switch-to-same-major-mode-buffer ()
  "切换到和当前 buffer 相同 major-mode 的 buffer"
  (interactive)
  (let (filtered-buf
	(cur-major-mode major-mode))
    (dolist (buf (cdr (buffer-list)))
      ;; 不显示当前 buffer
      (with-current-buffer buf
	(when (eq major-mode cur-major-mode)
	  (push buf filtered-buf))))
    (switch-to-buffer
     (completing-read
      "Switch to buffer with same major-mode: "
      (mapcar (lambda (buf) (buffer-name buf)) filtered-buf)))))


(provide 'fei)
