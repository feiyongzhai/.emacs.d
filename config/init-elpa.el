;;; init-elpa.el --- configs for package
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(package-initialize)

(defvar fei-package-ensure-installed nil
  "List of package names to install ,if missing.")

(defun fei-package-install-ensured ()
  "Install all `fei-package-ensure-installed' packages,if needed."
  (interactive)
  (package-refresh-contents)
  (mapcar (lambda (pck)
	    (unless (package-installed-p pck)
	      (package-install pck)))
	  fei-package-ensure-installed)
  (message "ensured package installed successfully!"))

;;; 需要安装的 packages
(setq fei-package-ensure-installed
      '(evil
	company
	paredit
	smex
	counsel ivy swiper ctrlf anzu avy
	pyim rime
	youdao-dictionary
	auctex cdlatex
	neotree
	))

(provide 'init-elpa)
;;; init-elpa.el ends here.
