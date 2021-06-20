;;; init-windows.el  --- configs for windows

(require 'init-func)

;;; Code:

;;;TODO
;; [ ] 1. 给transient类函数添加message提示

;;; mode
(winner-mode 1)

;;; Keys

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

;;; Funcs

(defun fei-minimize-window ()
  (interactive)
  (minimize-window)
  (call-interactively #'other-window))

(transient-command winner-undo
  (winner-undo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

(transient-command winner-redo
  (winner-redo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

(defun other-window-backward ()
  (interactive)
  (other-window -1))

(transient-command other-window
  (other-window 1)
  '(("o" . other-window)
    ("O" . other-window-backward)))

(transient-command other-window-backward
  (other-window-backward)
  '(("o" . other-window)
    ("O" . other-window-backward)))

;;; transient版本的扩大窗口
(transient-command enlage-window
  (call-interactively 'enlarge-window-horizontally)
  '(("}" . enlarge-window-horizontally)
    ("{" . shrink-window-horizontally)
    ("]" . enlarge-window-horizontally)
    ("[" . shrink-window-horizontally)
    ("=" . balance-windows)
    ("|" . maximize-window)
    ("\\" . minimize-window)))

;;; transient版本的缩小窗口
(transient-command shrink-window
  (call-interactively 'shrink-window-horizontally)
  '(("}" . enlarge-window-horizontally)
    ("{" . shrink-window-horizontally)
    ("]" . enlarge-window-horizontally)
    ("[" . shrink-window-horizontally)
    ("=" . balance-windows)
    ("|" . maximize-window)
    ("\\" . minimize-window)))


(defun fei-kill-current-buffer (arg)
  "智能关闭 windows 和 buffer"
  (interactive "P")
  (cond
   ((minibufferp)
    (keyboard-escape-quit))
   ((or arg (one-window-p))
    (kill-buffer))
   (t (kill-buffer-and-window))))


(provide 'init-windows)
;;; init-windows.el ends here.