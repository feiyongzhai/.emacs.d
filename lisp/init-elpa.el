;;; init-elpa.el --- configs for package
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(package-initialize)

(defvar user/package-ensure-installed nil
  "List of package names to install ,if missing.")

(defun user/package-install-ensured ()
  "Install all `user/package-ensure-installed' packages,if needed."
  (interactive)
  (package-refresh-contents)
  (mapcar (lambda (pck)
	    (unless (package-installed-p pck)
	      (package-install pck)))
	  user/package-ensure-installed)
  (message "ensured package installed successfully!"))

(provide 'init-elpa)
;;; init-elpa.el ends here.
