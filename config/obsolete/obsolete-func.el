;; 放一些没有用，很少会用到的函数

(defun fei-sdcv ()
  (interactive)
  (let* ((current-word (word-at-point t))
	 (word (read-string
		(format "Word (%s): " (or current-word ""))
		nil t current-word)))
    (shell-command (concat "sdcv " word) "*SDCV-OUTPUT*")))

(defun catfish ()
  (interactive)
  (start-process "catfish" nil "catfish" "--start" (read-string "catfish: ")))

(defun fei-golden-dict (&rest search-string)
  (interactive)
  (call-process "goldendict" nil nil nil
   (concat
    (if search-string
	(eshell-flatten-and-stringify search-string)
      (if mark-active
          (buffer-substring-no-properties (region-beginning) (region-end))
	(read-string "GoldenDict: "))))))

