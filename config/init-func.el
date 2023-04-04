(defmacro win10 (&rest body)
  `(when *is-windows*
     ,@body))

(defmacro linux (&rest body)
  `(when *is-linux*
     ,@body))

(defmacro fei-repeat (fun-name command &rest keymaps)
  "一个方便定义瞬时命令的宏"
  (declare (indent 1))
  (let ((command-name (intern (format "%s" (symbol-name fun-name)))))
    `(defun ,command-name ()
       (interactive)
       (let ((echo-keystrokes nil))
	 ,command
	 (set-transient-map
	  (let ((map (make-sparse-keymap)))
	    (mapcar (lambda (x)
		      (define-key map (kbd (car x)) (cdr x)))
		    ,@keymaps)
	    map)
	  t)))))

(defmacro fei-define-key-with-map (map keymaps &optional filename)
  (declare (indent 1))
  `(mapcar (lambda (x)
	     (define-key ,map (kbd (car x)) (cdr x))
	     (when ,filename
	       (autoload (cdr x) ,filename nil t)))
	   ,keymaps))

(defmacro li (&rest body)
  `(lambda () (interactive) ,@body))

(provide 'init-func)
