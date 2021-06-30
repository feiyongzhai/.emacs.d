;;; init-eshell.el  --- configs for eshell, shell terminal

;;; Code:

;;; Keys
(global-set-key (kbd "<M-s-return>") 'fei-terminal-here) ; 这个按键保留是为了用户习惯的过渡
(global-set-key (kbd "<s-return>") 'fei-terminal-here)
(global-set-key (kbd "<f8>") 'next-eshell-buffer)

;;; Vars

;;; Funcs

;;; @ref https://emacs-china.org/t/productivity-scratch-major-mode-buffer/2918
(defun next-eshell-buffer ()
  (interactive)
  (let ((same-major-mode 'eshell-mode)
        (i 0))
    (next-buffer)
    (while (< i 50)
      (let ((cur-major-mode major-mode))
        (if (eq same-major-mode cur-major-mode)
            (setq i 100)
	  (next-buffer)
          (setq i (1+ i)))))))

;;; Make eshell don't always scroll to bottom
;; @ref https://emacs.stackexchange.com/questions/28819/eshell-goes-to-the-bottom-of-the-page-after-executing-a-command
;; There are two solution
;; (setq eshell-scroll-show-maximum-output nil)
(add-hook 'eshell-mode-hook
          (defun chunyang-eshell-mode-setup ()
            (remove-hook 'eshell-output-filter-functions
                         'eshell-postoutput-scroll-to-bottom)))
(add-hook 'eshell-mode-hook (lambda ()
			      (toggle-truncate-lines 1)))

;; Open terminal here
(defun fei-terminal-here (arg)
  (interactive "P")
  (if (eq arg '-)
      (if *is-linux*
	  (shell-command "gnome-terminal")
	(if (fboundp 'terminal-here)
	    (terminal-here)
	  (message "can't open terminal here")))
    (call-interactively 'eshell)))

;;; Eshell commands and alias

(defalias 'open 'find-file-other-window)
(defalias 'eshell/e 'eshell/edit)

(with-eval-after-load 'eshell
  (require 'eshell-up)
  (defalias 'eshell/up 'eshell-up))

;;; @ref https://github.com/manateelazycat/aweshell/blob/master/aweshell.el
;;; `aweshell-emacs' function
(defun eshell/edit (&rest args)
  "Open a file in Emacs with ARGS, Some habits die hard."
  (cond
   ((null args)
    (dired "."))
   ((eq (length args) 1)
    (eval `(find-file ,@args)))
   (t
    (mapc (lambda (x) 
	    (find-file-other-tab x))
	  (mapcar #'expand-file-name (eshell-flatten-list (reverse args)))))))

;; @ref https://www.emacswiki.org/emacs/EshellAutojump
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
