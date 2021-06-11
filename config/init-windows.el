;;; init-windows.el  --- configs for windows

(require 'init-func)

;;; Code:

;;;TODO
;; [ ] 1. 给transient类函数添加message提示
;; [x] 2. 可以尝试写一个宏，优化一下代码，因为这些transient类的函数都差不多

;;; shortkeys
(fei-define-key-with-map global-map
  '(("C-x w u" . transient-winner-undo)
    ("C-x w U" . transient-winner-redo)
    ("C-x w e" . balance-windows)
    ("C-x w H" . windmove-swap-states-left)
    ("C-x w J" . windmove-swap-states-down)
    ("C-x w K" . windmove-swap-states-up)
    ("C-x w L" . windmove-swap-states-right)
    ("C-x w M" . maximize-window)
    ("C-x w m" . fei-minimize-window)
    ("C-x o" . transient-other-window)
    ("C-x O" . transient-other-window-backward)
    ("C-x {" . transient-shrink-window)
    ("C-x }" . transient-enlage-window)
    ("M-k" . fei-kill-current-buffer)
    ))

;;; winner-mode
(winner-mode 1)

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


;;; 关闭 buffer 自定义函数
(defun fei-kill-current-buffer()
  "智能关闭 windows 和 buffer"
  (interactive)
  (cond
   ((minibufferp)  (keyboard-escape-quit))
   ((one-window-p) (kill-buffer))
   (t              (kill-buffer-and-window))))



(provide 'init-windows)
;;; init-windows.el ends here.
