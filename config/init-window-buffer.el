;;; init-window-buffer.el  --- configs for Window/Buffer

(require 'init-func)
(autoload 'zygospore-toggle-delete-other-windows "zygospore" t nil)

;;; Mode

(winner-mode 1)

;; ace-window
(setq aw-ignore-current nil)
(setq aw-dispatch-when-more-than 2)
(setq aw-scope 'frame)
(setq aw-keys '(?j ?k ?l ?h ?g ?f ?d ?s ?a))
(setq aw-char-position 'top-left)
(custom-set-faces '(aw-leading-char-face ((t (:foreground "red" :height 1.5)))))

(transient-command winner-undo (winner-undo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))


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


;; mark stack 栈式存储 mark，比自带的 ring 数据结构来的更简单理解一些。
;; 下面的代码自然不能应付所有场景，但是可以应付大部分场景
;; @REF: https://github.com/manateelazycat/lazycat-emacs/blob/master/site-lisp/extensions/lazycat/basic-toolkit.el

(defvar marker-stack nil)

(defun marker-stack-push ()
  "Push current point in stack."
  (interactive)
  (message "Location marked.")
  ;; 下面两行，REF: `push-mark'
  (set-marker (mark-marker) (point) (current-buffer))
  (setq marker-stack (cons (copy-marker (mark-marker)) marker-stack))
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

(provide 'init-window-buffer)

