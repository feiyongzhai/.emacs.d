;;; init-shell.el  --- configs for eshell/shell/terminal

;;; Keys

(fei-define-key-with-map global-map
  `(
    ("<s-return>" . fei-terminal-here)
    ("<f12>" . fei-ansi-term)
    ("<f8>" . next-eshell-buffer)
    ("<C-f8>" . fei-eshell-cd-here)
    ("<s-f8>" . ,(li (split-window-below) (other-window 1) (call-interactively 'fei-eshell-cd-here)))
    ("<M-f8>" . shell)
    ))

;;; Funcs

;;; {{ ansi-term related

(defun fei-ansi-term ()
  (interactive)
  (unless (goto-term)
      (ansi-term (getenv "SHELL"))))

(defun goto-term ()
  (interactive)
  (catch 'done
    (dolist (buf (buffer-list))
      (with-current-buffer buf
	(when (eq major-mode 'term-mode)
	  (throw 'done (switch-to-buffer buf)))))))
;;; }}

;;; @ref https://github.com/manateelazycat/lazycat-emacs/blob/master/site-lisp/extensions/lazycat/basic-toolkit.el line 492
(defvar num-of-eshell 0)
(defun next-eshell-buffer (&optional want-to-create)
  "dwim create or switch eshell buffer"
  (interactive "P")
  (cond ((eq want-to-create '-)
	 (fei-eshell-cd-here))
	(want-to-create
	 (call-interactively 'eshell)
	 (setq num-of-eshell (1+ num-of-eshell)))
	((<= num-of-eshell 0)
	 (call-interactively 'eshell)
	 (setq num-of-eshell (1+ num-of-eshell)))
	(t
	 (catch 'done
	   (dolist (buf (cdr (buffer-list)))
	     (with-current-buffer buf
	       (when (eq major-mode 'eshell-mode)
		 (throw 'done (switch-to-buffer buf)))))))
	))

(add-hook 'kill-buffer-query-functions #'sync-num-of-eshell 90)	;90 保证 `sync-num-of-eshell' 在列表的最后面

(defun sync-num-of-eshell ()
  (if (eq major-mode 'eshell-mode)
      (setq num-of-eshell (- num-of-eshell 1))
    t))

(defun fei-eshell-cd-here ()
  (interactive)
  (if (eq major-mode 'eshell-mode)
      (message "You are already in eshell buffer!")
    (let ((dir default-directory)
	  (buf (next-eshell-buffer)))
      (set-buffer buf)
      (eshell/cd dir)
      (eshell-reset))))

;;; Make eshell don't always scroll to bottom
;; @ref https://emacs.stackexchange.com/questions/28819/eshell-goes-to-the-bottom-of-the-page-after-executing-a-command
;; There are two solution
;; (setq eshell-scroll-show-maximum-output nil)
(add-hook 'eshell-mode-hook
          (defun chunyang-eshell-mode-setup ()
            (remove-hook 'eshell-output-filter-functions
                         'eshell-postoutput-scroll-to-bottom)))
(add-hook 'eshell-mode-hook (lambda ()
			      (toggle-truncate-lines 0)))

(with-eval-after-load 'shell
  ;; 实际使用中发现下面这个设置会和 matlab-shell 的补全冲突
  ;; 问题描述：有了下面的配置之后，matlab-shell 中按两次 tab 键无法显示 company 的界面，并会输出一些错误信息
  ;; update: 2021-07-22T23:54:23+08:00
  ;; 问题没有完全解决，当我用emacsclient的方式启动的时候，还会存在高亮不消失的情况。
  ;; (setq comint-prompt-read-only t)
  (remove-hook 'comint-output-filter-functions
	       'comint-postoutput-scroll-to-bottom))

;; Open terminal here
(defun fei-terminal-here ()
  (interactive)
  (if *is-linux*
      (shell-command "gnome-terminal")
    (if (fboundp 'terminal-here)
	(terminal-here)
      (message "can't open terminal here"))))

;;; Eshell commands and alias

(defalias 'open 'find-file-other-window)
(defalias 'eshell/e 'eshell/edit)

(with-eval-after-load 'eshell
  (require 'eshell-up)
  (defalias 'eshell/u 'eshell-up)
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

(defalias 'eshell/s 'eshell/eaf-search)
(defun eshell/eaf-search (&rest strings)
  (interactive)
  (if (null strings)
      (call-interactively 'eaf-search-it)
    (fei-google-search strings)))

(provide 'init-shell)
;;; init-shell.el ends here.
