;;; init-windows.el  --- configs for windows

(require 'init-func)

;;; Keys
(global-set-key (kbd "s-u") 'winner-undo)
(global-set-key (kbd "s-0") 'delete-window)
(global-set-key (kbd "s-1") 'delete-other-windows)
(global-set-key (kbd "s-2") (lambda () (interactive) (split-window-below) (other-window 1)))
(global-set-key (kbd "s-3") (lambda () (interactive) (split-window-right) (other-window 1)))
(fei-define-key-with-map global-map
  '(
    ("C-x w u" . transient-winner-undo)
    ("C-x w M" . maximize-window)
    ("C-S-m" . maximize-window)		; matlab like keybinding
    ("C-x w m" . minimize-window)
    ("C-x o" . transient-other-window)
    ("C-x O" . transient-other-window-backward)
    ))

;;; Mode

(winner-mode 1)

;;; Funcs

(transient-command winner-undo
  (winner-undo)
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
