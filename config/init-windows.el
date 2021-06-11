;;; init-windows.el  --- configs for windows

;;; Code:

;;;TODO
;; [ ] 1. 给transient类函数添加message提示
;; [x] 2. 可以尝试写一个宏，优化一下代码，因为这些transient类的函数都差不多


;;; winner-mode
(winner-mode 1)
(global-set-key (kbd "C-x w u") #'transient-winner-undo)
(global-set-key (kbd "C-x w U") #'transient-winner-redo)
(global-set-key (kbd "C-x w e") #'balance-windows)
(global-set-key (kbd "C-x w H") #'windmove-swap-states-left)
(global-set-key (kbd "C-x w J") #'windmove-swap-states-down)
(global-set-key (kbd "C-x w K") #'windmove-swap-states-up)
(global-set-key (kbd "C-x w L") #'windmove-swap-states-right)
(global-set-key (kbd "C-x w M") #'maximize-window)
(global-set-key (kbd "C-x w m") #'fei-minimize-window)



(defun fei-minimize-window ()
  (interactive)
  (minimize-window)
  (call-interactively #'other-window))

(transient-command transient-winner-undo
  (winner-undo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

(transient-command transient-winner-redo
  (winner-redo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

;;; Alternative windows switch scheme
(defun other-window-backward ()
  (interactive)
  (other-window -1))

(transient-command transient-other-window
  (other-window 1)
  '(("o" . other-window)
    ("O" . other-window-backward)))

(transient-command transient-other-window-backward
  (other-window-backward)
  '(("o" . other-window)
    ("O" . other-window-backward)))
;; 按键
(global-set-key (kbd "C-x o") #'transient-other-window)
(global-set-key (kbd "C-x O") #'transient-other-window-backward)

;;; transient版本的扩大窗口
(transient-command transient-enlage-window
  (call-interactively 'enlarge-window-horizontally)
  '(("}" . enlarge-window-horizontally)
    ("{" . shrink-window-horizontally)
    ("]" . enlarge-window-horizontally)
    ("[" . shrink-window-horizontally)
    ("=" . balance-windows)
    ("|" . maximize-window)
    ("\\" . minimize-window)))
;; 按键
(global-set-key (kbd "C-x }") #'transient-enlage-window)

;;; transient版本的缩小窗口
(transient-command transient-shrink-window
  (call-interactively 'shrink-window-horizontally)
  '(("}" . enlarge-window-horizontally)
    ("{" . shrink-window-horizontally)
    ("]" . enlarge-window-horizontally)
    ("[" . shrink-window-horizontally)
    ("=" . balance-windows)
    ("|" . maximize-window)
    ("\\" . minimize-window)))
;; 按键
(global-set-key (kbd "C-x {") #'transient-shrink-window)

;;; 关闭 buffer 自定义函数
(defun fei-kill-current-buffer()
  "智能关闭 windows 和 buffer"
  (interactive)
  (cond
   ((minibufferp)  (keyboard-escape-quit))
   ((one-window-p) (kill-buffer))
   (t              (kill-buffer-and-window))))

;; 按键
(global-set-key (kbd "M-k") 'fei-kill-current-buffer)

(provide 'init-windows)
;;; init-windows.el ends here.
