;;; init-windows.el  --- configs for windows

;;; Code:

;;;TODO
;; 1. 给transient类函数添加message提示
;; 2. 可以尝试写一个宏，优化一下代码，因为这些transient类的函数都差不多

;;; Burly: bookmark windows and frame.
(add-to-list 'user/package-ensure-installed 'burly)

;;; winner-mode
(winner-mode 1)
(global-set-key (kbd "C-x w u") #'transient-winner-undo)
(global-set-key (kbd "C-x w U") #'transient-winner-redo)
(global-set-key (kbd "C-x w e") #'balance-windows)
(global-set-key (kbd "C-x w h") #'windmove-left)
(global-set-key (kbd "C-x w j") #'windmove-down)
(global-set-key (kbd "C-x w k") #'windmove-up)
(global-set-key (kbd "C-x w l") #'windmove-right)
(global-set-key (kbd "C-x w H") #'windmove-swap-states-left)
(global-set-key (kbd "C-x w J") #'windmove-swap-states-down)
(global-set-key (kbd "C-x w K") #'windmove-swap-states-up)
(global-set-key (kbd "C-x w L") #'windmove-swap-states-right)
(global-set-key (kbd "C-x w m") #'maximize-window)
(global-set-key (kbd "C-x w M") #'minimize-window)
(global-set-key (kbd "C-1") 'delete-other-windows)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(define-key global-map  (kbd "M-0") #'delete-window)

(defun transient-winner-undo ()
  (interactive)
  (let ((echo-keystrokes nil))
    (winner-undo)
    (set-transient-map
     (let ((map (make-sparse-keymap)))
       (define-key map "u" #'winner-undo)
       (define-key map "U" #'winner-redo)
       map)
     t)))

(defun transient-winner-redo ()
  (interactive)
  (let ((echo-keystrokes nil))
    (winner-redo)
    (set-transient-map
     (let ((map (make-sparse-keymap)))
       (define-key map "u" #'winner-undo)
       (define-key map "U" #'winner-redo)
       map)
     t)))

;;; Alternative windows switch scheme
(defun other-window-backward ()
  (interactive)
  (other-window -1))

(defun transient-other-window ()
  (interactive)
  (let ((echo-keystrokes nil))
    (other-window 1)
    (set-transient-map
     (let ((map (make-sparse-keymap)))
       (define-key map "o" #'other-window)
       (define-key map "O" #'other-window-backward)
       map)
     t)))
;; 按键
(global-set-key (kbd "C-x o") #'transient-other-window)

;;; transient版本的扩大窗口
(defun transient-enlage-window ()
  (interactive)
  (let ((echo-keystrokes nil))
    (call-interactively 'enlarge-window-horizontally)
    (set-transient-map
     (let ((map (make-sparse-keymap)))
       (define-key map "}" #'enlarge-window-horizontally)
       (define-key map "{" #'shrink-window-horizontally)
       (define-key map "]" #'enlarge-window-horizontally)
       (define-key map "[" #'shrink-window-horizontally)
       (define-key map "=" #'balance-windows)
       (define-key map "|" #'maximize-window)
       (define-key map "\\" #'minimize-window)
       map)
     t)))
;; 按键
(global-set-key (kbd "C-x }") #'transient-enlage-window)

;;; transient版本的缩小窗口
(defun transient-shrink-window ()
  (interactive)
  (let ((echo-keystrokes nil))
    (call-interactively 'shrink-window-horizontally)
    (set-transient-map
     (let ((map (make-sparse-keymap)))
       (define-key map "}" #'enlarge-window-horizontally)
       (define-key map "{" #'shrink-window-horizontally)
       (define-key map "]" #'enlarge-window-horizontally)
       (define-key map "[" #'shrink-window-horizontally)
       (define-key map "=" #'balance-windows)
       (define-key map "|" #'maximize-window)
       (define-key map "\\" #'minimize-window)
       map)
     t)))
;; 按键
(global-set-key (kbd "C-x {") #'transient-shrink-window)

;;; 关闭 buffer 自定义函数
(defun user/kill-current-buffer()
"智能关闭 windows 和 buffer"
  (interactive)
  (if (not (one-window-p))
      (delete-window)
    (previous-buffer)
    ;; (kill-buffer-and-window)
    ;; (kill-buffer)
    ))
;; 按键
(global-set-key (kbd "M-k") 'user/kill-current-buffer)

(provide 'init-windows)
;;; init-windows.el ends here.
