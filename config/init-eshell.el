(require 'init-func)
(require 'fei-funcs)

(setenv "PAGER" "cat")
;; (setq eshell-banner-message "")
(setq eshell-list-files-after-cd nil)
(setq eshell-history-size 500)
(setq eshell-cmpl-ignore-case t)
(setq eshell-visual-commands nil)	;避免自己不小心启用
(setq eshell-history-size 2000)

;;; Make eshell don't always scroll to bottom
;; @REF: https://emacs.stackexchange.com/questions/28819/eshell-goes-to-the-bottom-of-the-page-after-executing-a-command
;; There are two solutions
(setq eshell-scroll-show-maximum-output nil)
;; (add-hook 'eshell-mode-hook
;;           (defun chunyang-eshell-mode-setup ()
;;             (remove-hook 'eshell-output-filter-functions
;;                          'eshell-postoutput-scroll-to-bottom)))

(add-hook 'eshell-mode-hook 'fei-eshell-mode-hook)
(defun fei-eshell-mode-hook ()
  ;; `substring' style is very useful for eshell completion
  (setq-local completion-styles '(basic partial-completion substring emacs22))
  (toggle-truncate-lines 0))

(defun fei-eshell-cd-here ()
  (interactive)
  (if (eq major-mode 'eshell-mode)
      (message "You are already in eshell buffer!")
    (let ((dir default-directory)
	  (buf (eshell))
	  eshell-list-files-after-cd)
      (set-buffer buf)
      ;; bind `eshell-list-files-after-cd' with `t' will cause error
      ;; when run `eshell/cd' in lisp code. as shown below. but it
      ;; won't cause any problem when use `cd' in eshell buffer. so I
      ;; use let-bind `eshell-list-files-after-cd' with nil
      ;; (message "eshell previous at: %s" default-directory)
      (unless (string= default-directory dir)
	;; (message "fei debug message")
	(eshell/cd dir)
	(eshell-reset))
      )))


(defun fei/eshell-bash-commit ()
  (interactive)
  (eshell-bol)
  (save-excursion
    (insert "bash -c '")
    (goto-char (line-end-position))
    (insert "'"))
  (eshell-send-input))

;; @REF: https://github.com/manateelazycat/aweshell/blob/master/aweshell.el
(defun eshell/edit (&rest args)
  "Open a file in Emacs with ARGS, Some habits die hard."
  (cond
   ((null args)
    (dired "."))
   ((eq (length args) 1)
    (eval `(find-file ,@args)))
   (t
    (mapc (lambda (x) (find-file-other-tab x))
	  (mapcar #'expand-file-name (eshell-flatten-list (reverse args)))))))

;; @REF: https://emacs-china.org/t/topic/5362?u=yongfeizhai
(defun fei-my/ivy-eshell-history ()
  (interactive)
  (require 'em-hist)
  (let* ((start-pos (save-excursion (eshell-bol) (point)))
         (end-pos (point))
         (input (buffer-substring-no-properties start-pos end-pos))
         (command (ivy-read "Command: "
                            (delete-dups
                             (when (> (ring-size eshell-history-ring) 0)
                               (ring-elements eshell-history-ring)))
                            :initial-input input)))
    (setf (buffer-substring start-pos end-pos) command)
    (end-of-line)))

;; @REF: https://emacs-china.org/t/topic/5362?u=yongfeizhai
(defun +eshell/quit-or-delete-char (arg)
  (interactive "p")
  (if (and (eolp) (looking-back eshell-prompt-regexp nil))
      (eshell-life-is-too-much)
    (delete-char arg)))

;; @REF: https://github.com/ramsayleung/emacs.d/blob/6b85374180e0a622301df0d0ab8ff08cbab46c4a/lisp/init-eshell.el#L14
(defun eshell/unpack (file &rest args)
  "Unpack FILE with ARGS using default command."
  (let ((command (cl-some (lambda (x)
                            (if (string-match-p (car x) file)
				(cadr x)))
			  '((".*\.tar.bz2" "tar xjf")
                            (".*\.tar.gz" "tar xzf")
                            (".*\.bz2" "bunzip2")
                            (".*\.rar" "unrar x")
                            (".*\.gz" "gunzip")
                            (".*\.tar" "tar xf")
                            (".*\.tbz2" "tar xjf")
                            (".*\.tgz" "tar xzf")
                            (".*\.zip" "unzip")
                            (".*\.Z" "uncompress")
                            (".*" "echo 'Could not unpack the file:'")))))
    (let ((unpack-command (concat command " " file " " (mapconcat 'identity args " "))))
      (eshell/printnl "Unpack command: " unpack-command)
      (eshell-command-result unpack-command))
    ))

;; @REF https://0x709394.me/Fasd%E4%B8%8E-Eshell%E7%9A%84%E4%B8%8D%E6%9C%9F%E8%80%8C%E9%81%87
(defun samray/eshell-zoxide-z (&rest args)
  "Use zoxide to change directory more effectively by passing ARGS."
  (setq args (eshell-flatten-and-stringify args))
  (let* ((zoxide (concat "zoxide query " args))
	 (zoxide-result (shell-command-to-string zoxide))
	 (path (replace-regexp-in-string "\n$" "" zoxide-result)))
    (and *is-windows*
	 ;; 因为 windows 下有的时候可以正确解释为 utf-8 ，有的时候不可以，为 gbk
	 ;; 思路：为 gbk 编码的时候，转换成 utf-8，为 utf-8 则不操作
	 (text-property-any 0 (1- (length path)) 'charset 'chinese-gbk path)
	 (setq path (decode-coding-string
		     (encode-coding-string path 'gbk) 'utf-8)))
    (if (eq 0 (length args))
	(eshell/cd "-")
      (eshell/cd path)
      ;; (eshell/echo path)
      )))

(provide 'init-eshell)
