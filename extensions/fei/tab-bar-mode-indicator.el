;; 在 mode-line 上显示 tab-bar

;; TODO: 更好的 mode-line 显示，其实我觉得现在的就挺好
;; TODO: 目前必须在 (minions-mode) 之后加载，要不然 (minions-mode) 就无法奏效
;; BUG: calendar 下会出现 error 因为 calendar 的 mode-line-format 比较特殊

(require 'tab-bar)

(defvar current-tab-index)

(setq current-tab-index (1+ (tab-bar--current-tab-index)))

(setq mode-line-format `(,(number-to-string current-tab-index) . ,(cdr mode-line-format)))

(add-hook 'window-configuration-change-hook 'update-mode-line-tab-bar-indicator)

(defun update-mode-line-tab-bar-indicator ()
  (setq current-tab-index (1+ (tab-bar--current-tab-index)))
  (walk-windows
   (lambda (w)
     (with-selected-window w
       (setq mode-line-format
	     (cons (number-to-string current-tab-index)
		   (cdr mode-line-format)))))))

(provide 'tab-bar-mode-indicator)
