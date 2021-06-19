;;; init-eshell.el  --- configs for eshell, shell terminal

;;; Code:

;;; Keys
(global-set-key (kbd "<C-return>") 'eshell)
(global-set-key (kbd "C-c <C-return>") #'fei-terminal-here)

;;; Vars

;;; *e?shell* buffer display rule
(add-to-list 'display-buffer-alist
	     '("\\*e?shell\\*"
	       (display-buffer-in-side-window)
	       (window-height . 0.25)
	       (side . bottom)
	       (slot . 0)))

;;; Funcs

;; open terminal here
(defun fei-terminal-here ()
  (interactive)
  (if *is-linux*
      (if (fboundp 'eaf-open-terminal)
	  (eaf-open-terminal)
	(shell-command "gnome-terminal"))
    (if (fboundp 'terminal-here)
	(terminal-here)
      (message "can't open terminal here"))))

;; Ref url: https://www.emacswiki.org/emacs/EshellAutojump
(defun eshell/j (&rest args)
  "Jump to a directory you often cd to.
This compares the argument with the list of directories you usually jump to.
Without an argument, list the ten most common directories.
With a positive integer argument, list the n most common directories.
Otherwise, call `eshell/cd' with the result."
  (setq args (eshell-flatten-list args))
  (let ((arg (or (car args) 10))
	(map (make-hash-table :test 'equal))
	(case-fold-search (eshell-under-windows-p))
	candidates
	result)
    ;; count paths in the ring and produce a map
    (dolist (dir (ring-elements eshell-last-dir-ring))
      (if (gethash dir map)
	  (puthash dir (1+ (gethash dir map)) map)
	(puthash dir 1 map)))
    ;; use the map to build a sorted list of candidates
    (maphash (lambda (key value)
	       (setq candidates (cons key candidates)))
	     map)
    (setq candidates (sort candidates
			   (lambda (a b)
			     (> (gethash a map)
				(gethash b map)))))
    ;; list n candidates or jump to most popular candidate
    (if (and (integerp arg) (> arg 0))
	(progn
	  (let ((n (nthcdr (1- arg) candidates)))
	    (when n
	      (setcdr n nil)))
	  (eshell-lisp-command
	   (mapconcat (lambda (s)
			(format "%4d %s" (gethash s map) s))
		      candidates "\n")))
      (while (and candidates (not result))
	(if (string-match arg (car candidates))
	    (setq result (car candidates))
	  (setq candidates (cdr candidates))))
      (eshell/cd result))))

;;; eshell 定制
(defun fei-eshell ()
  "这个函数已经过时

如果 *eshell* buffer 存在就跳转到这个 buffer，没有就新建一个，
如果处于 *eshell* 就跳转到上一个 buffer"
  (interactive)
  (let ((buf (buffer-name)))
    (cond ((string-equal buf "*eshell*")
	   (mode-line-other-buffer))
	  ((get-buffer "*eshell*")
	   (switch-to-buffer "*eshell*"))
	  (t
	   (eshell)))))

(provide 'init-shell)
;;; init-shell.el ends here.
