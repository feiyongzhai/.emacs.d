;; 没用的，过时的函数


(defun open-current-file-with-emacsv ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	;; emacs 中的 column 是从 0 开始计数的
	(column (number-to-string (1+ (current-column)))))
    (start-process "emacsq" nil "emacs" "-Q" "-l" "~/.emacs.d/etc/mini-vi.el"
		   (concat "+" line ":" column)
		   (or (buffer-file-name)
		       default-directory))))


(defun my/select-current-line-and-forward-line (arg)
  "Select the current line and move the cursor by ARG lines IF
no region is selected.

If a region is already selected when calling this command, only move
the cursor by ARG lines."
  (interactive "p")
  (when (not (use-region-p))
    (forward-line 0)
    (set-mark-command nil))
  (forward-line arg))


;; Rime 相关配置

(defvar rime-cycle-zhengma-luna "zmbig")

(defun rime-cycle-zhengma-luna ()
  (interactive)
  (if (string= rime-cycle-zhengma-luna "double_pinyin_flypy")
      (progn
	(rime-lib-select-schema "luna_pinyin")
	(setq rime-cycle-zhengma-luna "luna_pinyin")
	(rime--clear-state)
	(setq rime-show-candidate 'posframe)
	(message "拼音")
	)
    (rime-lib-select-schema "double_pinyin_flypy")
    (setq rime-cycle-zhengma-luna "double_pinyin_flypy")
    (rime--clear-state)
    (setq rime-show-candidate 'minibuffer)
    (message "小鹤双拼")
    ))

;; 为了防止快捷键冲突带来的问题，用了这个不太好的快捷键，有优化的空间，
;; 但是现在没有优化的必要，但是我发现这个快捷键有一个奇怪的表现：当我
;; 按这个快捷键的时候，它确实可以完成切换，但是不会清空已存在的 posframe
;; （我的 rime 的候选项是用 posframe 显示的）
(define-key rime-mode-map (kbd "C-l") 'rime-cycle-zhengma-luna)


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
