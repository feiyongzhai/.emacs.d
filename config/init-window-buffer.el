;;; init-window-buffer.el  --- configs for Window/Buffer

(require 'init-func)
(autoload 'zygospore-toggle-delete-other-windows "zygospore" t nil)

;;; Mode

;; 用 tab-bar-history-mode 代替
;; (winner-mode 1)

;; ace-window
(setq aw-ignore-current nil)
(setq aw-dispatch-when-more-than 2)
(setq aw-scope 'frame)
(setq aw-keys '(?j ?k ?l ?h ?g ?f ?d ?s ?a))
(setq aw-char-position 'top-left)
(custom-set-faces '(aw-leading-char-face ((t (:foreground "red" :height 1.5)))))


;;; undo kill buffer

;; @REF https://emacs.stackexchange.com/questions/3330/how-to-reopen-just-killed-buffer-like-c-s-t-in-firefox-browser
(defvar killed-file-list nil
  "List of recently killed files.")

(defun add-file-to-killed-file-list ()
  "If buffer is associated with a file name, add that file to the
`killed-file-list' when killing the buffer."
  (when buffer-file-name
    (push buffer-file-name killed-file-list)))

(add-hook 'kill-buffer-hook #'add-file-to-killed-file-list)

(defun reopen-killed-file ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (when killed-file-list
    (find-file (pop killed-file-list))))


(defun fei/scroll-down-push-mark ()
  (interactive)
  ;; (push-mark)
  (window-configuration-to-register ?s)
  (scroll-down-command))

(defun fei/scroll-up-push-mark ()
  (interactive)
  ;; (push-mark)
  (window-configuration-to-register ?s)
  (scroll-up-command))


;; mark stack 栈式存储 mark，比自带的 ring 数据结构来的更简单理解一些。
;; 下面的代码自然不能应付所有场景，但是可以应付大部分场景
;; @REF: https://github.com/manateelazycat/lazycat-emacs/blob/master/site-lisp/extensions/lazycat/basic-toolkit.el

(defvar marker-stack nil)
(defvar marker-stack-max 100)

(defun marker-stack-push (&optional location nomsg activate)
  "Push current point in stack. 如果要作为 advice function，注意参数要和原函数一致"
  (interactive)
  ;; 下面两行，REF: `push-mark'
  ;; (set-marker (mark-marker) (point) (current-buffer))
  ;; 如果放到 advice 中，上面的这个会多建立一个 mark ，直接导致 mark-sexp 无法正常工作
  (when (= marker-stack-max (length marker-stack))
    (setq marker-stack (butlast marker-stack 1)))
  (unless (or (eq major-mode 'minibuffer-mode) ;不记录 minibuffer 中的 marker
	      (eq major-mode 'treemacs-mode))  ;不记录 treemacs 中的 marker
    (message "Location marked.")
    (setq marker-stack (cons (copy-marker (mark-marker)) marker-stack)))
  )

(defun marker-stack-pop ()
  "Pop point from stack."
  (interactive)
  (if (null marker-stack)
      (message "Stack is empty.")
    (if-let* ((marker (car marker-stack))
	      (buffer (marker-buffer marker))
	      (position (marker-position marker)))
	;; 下面三行，REF: `pop-global-mark'
	(progn
	  (switch-to-buffer buffer)
	  (goto-char position))
      (message "buffer has been killed."))
    (setq marker-stack (cdr marker-stack)))
  )

(advice-add 'push-mark :after #'marker-stack-push)
;; If something go wrong, remove this advice function
;; (advice-remove 'push-mark #'marker-stack-push)

(provide 'init-window-buffer)
