(defmacro transient-command (fun-name command &rest keymaps)
  "一个方便定义瞬时命令的宏"
  (declare (indent 1))
  (let ((command-name (intern (format "transient-%s" (symbol-name fun-name)))))
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

(defun load-path-add (dir)
  (add-to-list 'load-path dir))

(provide 'init-func)
