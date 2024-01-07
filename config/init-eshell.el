(require 'fei-funcs)

;;;;;;;;;;;; Eshell ;;;;;;;;;;;;

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
    (delete-region start-pos end-pos)
    (insert command)
    ;; 在 emacs29 版本中，下面会报警告：obsolete generalized variable.
    ;; (setf (buffer-substring start-pos end-pos) command)
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



;;;;;;;;;;;; Shell ;;;;;;;;;;;;

(with-eval-after-load 'shell
  ;; 实际使用中发现下面这个设置会和 matlab-shell 的补全冲突
  ;; 问题描述：有了下面的配置之后，matlab-shell 中按两次 tab 键无法显示 company 的界面，并会输出一些错误信息
  ;; update: 2021-07-22T23:54:23+08:00
  ;; 问题没有完全解决，当我用emacsclient的方式启动的时候，还会存在高亮不消失的情况。
  ;; (setq comint-prompt-read-only t)
  (remove-hook 'comint-output-filter-functions
	       'comint-postoutput-scroll-to-bottom)
  (when *is-linux*
    (require 'bash-completion)
    (bash-completion-setup)))


;; Alias
(with-eval-after-load 'eshell
  (require 'eshell-up)
  (defalias 'eshell/u 'eshell-up))
(defun eshell/jo () (eshell/cd "~/Nutstore Files/org"))
(defun eshell/je () (eshell/cd "~/.emacs.d"))
(defun eshell/a () (org-agenda nil "a"))
(defun eshell/desktop () (eshell/cd fei-desktop-dir))
(defun eshell/de () (eshell/cd fei-desktop-dir))
(defalias 'eshell/of 'browse-url-default-browser)
(defalias 'eshell/e 'eshell/edit)
(defalias 'eshell/q 'bury-buffer)
(defalias 'eshell/j 'fei-counsel-recentf-pinyin)
(defalias 'eshell/J 'fei/counsel-recentf-dir)
(defalias 'eshell/ec 'find-file-other-frame)
(defalias 'eshell/k 'fei-org-capture-TODO)
(defalias 'eshell/todo 'fei-org-capture-TODO)
(defalias 'eshell/kw 'fei-org-capture-WANT)
(defalias 'eshell/kd 'fei-org-capture-diary)

;; 不推荐用 `eshll/alias' 设置 alias，因为会在每次启动的时候重置 eshell/alias 文件

;; (with-eval-after-load 'em-alias
;;   (eshell/alias "tig" "magit")
;;   (eshell/alias "of" "browse-url-default-browser $1")
;;   )


(provide 'init-eshell)
