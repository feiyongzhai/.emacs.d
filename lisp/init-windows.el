;;; init-windows.el  --- configs for windows

;;; Code:

;;; Burly: bookmark windows and frame.
(add-to-list 'user/package-ensure-installed 'burly)
(add-to-list 'user/package-ensure-installed 'ace-window)

;;; winner-mode
(winner-mode 1)
(global-set-key (kbd "C-x w u") #'transient-winner-undo)
(global-set-key (kbd "C-x w U") #'transient-winner-redo)

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

;;; Ace-windows
;; (global-set-key [remap other-window] 'ace-window)
(custom-set-faces
 '(aw-leading-char-face ((t (:inherit ace-jump-face-forehround :height 3.0)))))
;; 按键
;; (global-set-key (kbd "<C-tab>") 'ace-window)
(global-set-key (kbd "<C-tab>") 'tab-next)

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
       (define-key map "{" #'shrink-window-horizontally)
       (define-key map "}" #'enlarge-window-horizontally)
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
       (define-key map "=" #'balance-windows)
       (define-key map "|" #'maximize-window)
       (define-key map "\\" #'minimize-window)
       map)
     t)))
;; 按键
(global-set-key (kbd "C-x {") #'transient-shrink-window)

;;; 自定义按键
(global-set-key (kbd "C-1") 'delete-other-windows)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(define-key global-map  (kbd "M-0") #'delete-window)

;;; window resize
(let ((map global-map))
  (define-key map (kbd "C-x |") 'maximize-window)
  (define-key map (kbd "C-x \\") 'minimize-window))

;;; 关闭 buffer 自定义函数
(defun user/kill-current-buffer()
"智能关闭 windows 和 buffer"
  (interactive)
  ;; 现在有一个工作逻辑不符合我的预期，只有一个windows的时候我希望关闭
  ;; buffer得到我的确认。现在完成了前半个需求，在一个window的时候，不会
  ;; 之间关，但是现在无法实现得到我的确认的需求
  (if (not (one-window-p))
      (progn
	(kill-current-buffer)
	(delete-window))
    (kill-current-buffer)
    ;; (kill-buffer-and-window)
    ;; (kill-buffer)
    ))
;; 按键
(global-set-key (kbd "M-k") 'user/kill-current-buffer)

(provide 'init-windows)
;;; init-windows.el ends here.
