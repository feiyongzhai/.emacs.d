;;; 一些单独工作的小函数

(defun fei-meow-last-buffer (arg)
  "Switch to last buffer.
Argument ARG if not nil, switching in a new window."
  (interactive "P")
  (cond
   ((minibufferp)
    (keyboard-escape-quit))
   ((not arg)
    (mode-line-other-buffer))
   (t
    (split-window)
    (mode-line-other-buffer))))

(defun sudo-find-this-file ()
  (interactive)
  (if (buffer-file-name)
      ;; 不清楚 sudo:root@localhost: 表示的含义，但是现在这个命令能用
      (find-file (concat "/sudo:root@localhost:" buffer-file-name))
    (message "buffer without file can't deal with sudo")))

(defun fei-google-search (&rest search-string)
  "Googles a query or region if any.

参考链接：https://liujiacai.net/blog/2020/11/25/why-emacs/"
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if search-string
	(eshell-flatten-and-stringify search-string)
      (if mark-active
          (buffer-substring-no-properties (region-beginning) (region-end))
	(read-string "Google: "))))))

(defun fei-kill-current-buffer (arg)
  "智能关闭 windows 和 buffer"
  (interactive "P")
  (cond
   ((minibufferp)
    (keyboard-escape-quit))
   ((or arg (one-window-p))
    (kill-buffer))
   (t (kill-buffer-and-window))))

(defun backward-kill-word-or-region (&optional arg)
  "Kill word backwards unless region is active,
kill region instead"
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning)
		   (region-end))
    (backward-kill-word (or arg 1))))

(defun fei-newline ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

;;; @REF: https://oremacs.com/page32/
(defun dired-open-term ()
  "Open an `ansi-term' that corresponds to current directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (if (get-buffer "*ansi-term*")
	(switch-to-buffer "*ansi-term*")
      (ansi-term "/bin/bash"))
    (term-send-string
     (get-buffer-process "*ansi-term*")
     (if (file-remote-p current-dir)
         (let ((v (tramp-dissect-file-name current-dir t)))
           (format "ssh %s@%s\n"
                   (aref v 1) (aref v 2)))
       (format "cd '%s'\n" current-dir)))))

(defun fei-term-cd-here ()
  "Open an `ansi-term' that corresponds to current directory."
  (interactive)
  (let ((current-dir default-directory))
    (if (get-buffer "*ansi-term*")
	(switch-to-buffer "*ansi-term*")
      (ansi-term "/bin/bash"))
    (term-send-string
     (get-buffer-process "*ansi-term*")
     (if (file-remote-p current-dir)
         (let ((v (tramp-dissect-file-name current-dir t)))
           (format "ssh %s@%s\n"
                   (aref v 1) (aref v 2)))
       (format "cd '%s'\n" current-dir)))))

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


;; Eshell Related
;; {{ `next-eshell-buffer'

;; @ref https://github.com/manateelazycat/lazycat-emacs/blob/master/site-lisp/extensions/lazycat/basic-toolkit.el line 492
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

;; }}

(defun fei-terminal-here ()
  (interactive)
  (if *is-linux*
      (shell-command "gnome-terminal")
    (if (fboundp 'terminal-here)
	(terminal-here)
      (message "can't open terminal here"))))

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

(defun eshell/eaf-search (&rest strings)
  (interactive)
  (if (null strings)
      (call-interactively 'eaf-search-it)
    (fei-google-search strings)))

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

(defun +eshell/quit-or-delete-char (arg)
  (interactive "p")
  (if (and (eolp) (looking-back eshell-prompt-regexp nil))
      (eshell-life-is-too-much)
    (delete-char arg)))

(defun eshell/bash ()
  (interactive)
  (ansi-term (executable-find "bash")))

(defun eshell/fish ()
  (interactive)
  (ansi-term (executable-find "fish"))
  (toggle-truncate-lines))

;; @REF: https://github.com/ramsayleung/emacs.d/blob/6b85374180e0a622301df0d0ab8ff08cbab46c4a/lisp/init-eshell.el#L14
(defun eshell/unpack (file &rest args)
  "Unpack FILE with ARGS using default command."
  (let ((command (some (lambda (x)
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

;; Eshell Related End


;; IME related

(defun fei-rime-force-enable ()
  (interactive)
  (activate-input-method "rime")
  (call-interactively 'rime-force-enable)
  )

;;; {{ a switch between xhup & flypy

(defvar rime--flypy-p nil
  "输入法默认的状态是小鹤双拼+posframe的显示格式")

(defun fei-toggle-xhup-flypy ()
  (interactive)
  (if (fboundp 'rime-lib-select-schema)
      (if rime--flypy-p
	  (progn (rime-lib-select-schema "double_pinyin_flypy")
		 (setq rime-show-candidate 'posframe)
		 (setq rime-show-preedit t)
		 (setq rime--flypy-p nil))
	(rime-lib-select-schema "flypy")
	(setq rime-show-candidate 'minibuffer)
	(setq rime-show-preedit 'inline)
	(setq rime--flypy-p t))
    (message "Rime has not been required")))

;;; }}



;; org related

(defun fei-org-capture ()
  (interactive)
  ;; 这个写法可以传递prefix number，之前的不行
  (call-interactively 'org-capture)
  (require 'rime)
  (activate-input-method 'rime)
  (auto-fill-mode)
  (message "RIME输入法已经激活！"))

(defun fei-org-time ()
  (interactive)
  (if (not (boundp 'org-timer-start-time))
      (org-timer-start)
    (if (not org-timer-start-time)
	(org-timer-start)
      (call-interactively 'org-timer-pause-or-continue))))

(defalias 'eshell/ks 'fei-org-capture-SAR)
(defun fei-org-capture-SAR ()
  (interactive)
  (org-capture nil "S")
  (auto-fill-mode)
  (require 'rime)
  (activate-input-method 'rime))

(defalias 'eshell/kw 'fei-org-capture-WANT)
(defun fei-org-capture-WANT ()
  (interactive)
  (org-capture nil "s")
  (auto-fill-mode)
  (require 'rime)
  (activate-input-method 'rime))

(defalias 'eshell/k 'fei-org-capture-note)
(defun fei-org-capture-note ()
  (interactive)
  (org-capture nil "i")
  (auto-fill-mode)
  (require 'rime)
  (activate-input-method 'rime))

(defalias 'eshell/kd 'fei-org-capture-diary)
(defun fei-org-capture-diary ()
  (interactive)
  (org-capture nil "d")
  (auto-fill-mode)
  (require 'rime)
  (activate-input-method 'rime))

(defun eshell/a ()
  (org-agenda nil "a"))

(defun fei-org-store-link ()
  (interactive)
  (require 'org)
  (call-interactively 'org-store-link))

(defun fei-simple-compile ()
  (interactive)
  (save-buffer)
  (let (compilation-read-command)
    (call-interactively 'compile)))

(defvar fei-dired-toggle-hidden nil
  "t means on, nil means off")

(defun fei-dired-toggle-hidden ()
  (interactive)
  (if fei-dired-toggle-hidden
      (progn (dired-sort-other "-Bhl  --group-directories-first")
	     (setq fei-dired-toggle-hidden nil))
    (dired-sort-other (concat dired-listing-switches " -a"))
    (setq fei-dired-toggle-hidden t)))

;; @REF: https://emacs-china.org/t/leader-vscode/19166/29?u=yongfeizhai
(defun open-current-file-with-vscode ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	(column (number-to-string (current-column))))
    (start-process "vscode" nil "code" "--goto"
		   (concat (buffer-file-name)
			   ":" line ":" column))))

(defun open-current-file-with-gvim ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	(column (number-to-string (current-column))))
    (start-process "gvim" nil "gvim" (buffer-file-name)
		   (concat "+call cursor("
			   line "," column ")"))))



;; EAF related

(defun fei-eaf-open-browser (url &optional _new-window)
  "根据 `browse-url-chromium' 这个函数改的"
  (interactive (browse-url-interactive-arg "URL: "))
  (setq url (browse-url-encode-url url))
  (if (and (display-graphic-p)
	   (not (or (eq major-mode 'eshell-mode)
		    (eq major-mode 'shell-mode)
		    (getenv "TERM"))))
      (eaf-open-browser url _new-window)
    (browse-url-chrome url _new-window)))

(defun fei-eaf-file-share-current-dir ()
  (interactive)
  (require 'eaf)
  (eaf-file-browser-qrcode (substring (pwd) 10)))



;; isearch related

(defun prot-search-isearch-other-end ()
  "End current search in the opposite side of the match.
Particularly useful when the match does not fall within the
confines of word boundaries (e.g. multiple words)."
  (interactive)
  (isearch-done)
  (when isearch-other-end
    (goto-char isearch-other-end)))

(defun fei-isearch-copy-region ()
  (interactive)
  (isearch-exit)
  (call-interactively 'copy-region-as-kill))

(provide 'fei-funcs)
