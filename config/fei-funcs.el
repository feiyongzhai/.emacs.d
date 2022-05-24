;;; fei-funcs.el === 一些单独工作的小函数

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

(defun fei-golden-dict (&rest search-string)
  (interactive)
  (call-process "goldendict" nil nil nil
   (concat
    (if search-string
	(eshell-flatten-and-stringify search-string)
      (if mark-active
          (buffer-substring-no-properties (region-beginning) (region-end))
	(read-string "GoldenDict: "))))))

(defun eshell/s (&rest search-string)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (eshell-flatten-and-stringify search-string))))

(defun fei-google-search (&optional search-string)
  "Googles a query or region if any.

参考链接：https://liujiacai.net/blog/2020/11/25/why-emacs/"
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (or search-string
	(if mark-active
            (buffer-substring-no-properties (region-beginning) (region-end))
	  (read-string "Google: "))))))

(defun fei-search (&optional arg)
  "A wrapper for `fei-google-search', powered by `engine-mode'"
  (interactive "P")
  (if arg
      (progn
	(message
	 (concat "[b/B] B站/Bing [w/h] Wikipedia/Github [c] 词典 [y] YouTube \n"
		 "[s/S/M-s] 学术/搜狗/StackOverFlow [d/D] DuckDuckGo/百度 [g/i] 谷歌/图片"))
	(set-transient-map 'engine-mode-prefixed-map))
    (call-interactively 'fei-google-search)))

(defun fei-search-1 ()
  (interactive)
  (fei-search 1))

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

;; @REF: https://oremacs.com/page32/
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
       (format "cd %s\n" (shell-quote-wildcard-pattern current-dir))))
    (term-send-left)
    (term-send-right)))

(defun fei-ansi-term ()
  (interactive)
  (if (and (get-buffer "*ansi-term*")
	   (term-check-proc "*ansi-term*"))
      (switch-to-buffer "*ansi-term*")
    (ansi-term (getenv "SHELL")))
  ;; Workaround: 避免在 term 中用 back 之后，再在 eshell 中用
  ;; bash(fei-term-cd-here) 会出现光标位置出现在不期望的地方的情况
  (term-send-left)
  (term-send-right)
  nil)

;;; Org related

(defun fei-org-time ()
  (interactive)
  (if (not (boundp 'org-timer-start-time))
      (org-timer-start)
    (if (not org-timer-start-time)
	(org-timer-start)
      (call-interactively 'org-timer-pause-or-continue))))

;;; Org-capture
(autoload 'org-capture-goto-target "org-capture")

(defun fei-org-capture ()
  (interactive)
  ;; 这个写法可以传递prefix number，之前的不行
  (call-interactively 'org-capture)
  (activate-input-method 'rime))

(defun fei-org-capture-goto-Research ()
  (interactive)
  (org-capture-goto-target "K"))

(defun fei-org-capture-Research ()
  (interactive)
  (org-capture nil "K")
  (activate-input-method 'rime))

(defun fei-org-capture-goto-SAR ()
  (interactive)
  (org-capture-goto-target "S"))

(defun fei-org-capture-SAR ()
  (interactive)
  (org-capture nil "S")
  (activate-input-method 'rime))

(defun fei-org-capture-goto-WANT ()
  (interactive)
  (org-capture-goto-target "s"))

(defun fei-org-capture-TODO ()
  (interactive)
  (org-capture nil "t")
  (activate-input-method 'rime))

(defun fei-org-capture-WANT ()
  (interactive)
  (org-capture nil "s")
  (activate-input-method 'rime))

(defun fei-org-capture-note (&rest strings)
  (interactive)
  ;; (setq strings (eshell-flatten-and-stringify strings)) ;FIXME: 如果语句在这，strings 将总是会为 t
  (if strings
      (progn
	(setq strings (eshell-flatten-and-stringify strings))
        (org-capture-string strings "P") nil)
    (org-capture nil "i")
    (when (bound-and-true-p evil-mode)
      (evil-insert 0))
    (activate-input-method 'rime)))

(defun fei-org-capture-goto-note ()
  (interactive)
  (org-capture-goto-target "i"))

(defun fei-org-capture-goto-private ()
  (interactive)
  (org-capture-goto-target "p"))

(defun fei-org-capture-private ()
  (interactive)
  (org-capture nil "p")
  (when (bound-and-true-p evil-mode)
    (evil-insert 0))
  (activate-input-method 'rime))

(defun fei-org-capture-diary ()
  (interactive)
  (org-capture nil "d")
  (when (bound-and-true-p evil-mode)
    (evil-insert 0))
  (activate-input-method 'rime))

(defun fei-org-agenda ()
  (interactive)
  (org-agenda nil "a")
  (delete-other-windows))

;; @REF: https://emacs-china.org/t/leader-vscode/19166/29?u=yongfeizhai
(defun open-current-file-with-vscode ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	(column (number-to-string (current-column))))
    (start-process "vscode" nil "code" "--goto"
		   (concat (or (buffer-file-name)
			       default-directory)
			   ":" line ":" column))))

(defun open-current-file-with-gvim ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	(column (number-to-string (current-column))))
    (start-process "gvim" nil "gvim" (or (buffer-file-name)
					 default-directory)
		   (concat "+call cursor("
			   line "," column ")"))))

(defun open-current-file-with-emacsq ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	;; emacs 中的 column 是从 0 开始计数的
	(column (number-to-string (1+ (current-column)))))
    (start-process "emacsq" nil "emacs" "-Q"
		   (concat "+" line ":" column)
		   (or (buffer-file-name)
		       default-directory))))

(defun open-current-file-with-gedit ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	;; emacs 中的 column 是从 0 开始计数的
	(column (number-to-string (1+ (current-column)))))
    (start-process "gedit" nil "gedit"
		   (concat "+" line ":" column)
		   (or (buffer-file-name)
		       default-directory))))

(defun open-current-file-with-emacs ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	;; emacs 中的 column 是从 0 开始计数的
	(column (number-to-string (1+ (current-column)))))
    (start-process "emacs" nil "emacs"
		   (concat "+" line ":" column)
		   (or (buffer-file-name)
		       default-directory))))

(defun open-current-file-with-emacsv ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	;; emacs 中的 column 是从 0 开始计数的
	(column (number-to-string (1+ (current-column)))))
    (start-process "emacsq" nil "emacs" "-Q" "-l" "~/.emacs.d/etc/mini-vi.el"
		   (concat "+" line ":" column)
		   (or (buffer-file-name)
		       default-directory))))

;;; Misc
(defun fei-ff-find-other-file-pdf-org ()
  (interactive)
  (let* ((name (or (buffer-file-name)
		   (buffer-name)))
	 (current-ext (file-name-extension name))
	 (current-name (file-name-sans-extension name)))
    (cond ((string= current-ext "org")
	   (find-file (concat current-name ".pdf")))
	  ((string= current-ext "md")
	   (find-file (concat current-name ".pdf")))
	  ((string= current-ext "pdf")
	   (find-file (concat current-name ".org")))
	  (t (message "当前不支持这个文件")))))

(defun fei-sdcv ()
  (interactive)
  (let* ((current-word (word-at-point t))
	 (word (read-string
		(format "Word (%s): " (or current-word ""))
		nil t current-word)))
    (shell-command (concat "sdcv " word) "*SDCV-OUTPUT*")))

(defun catfish ()
  (interactive)
  (start-process "catfish" nil "catfish" "--start" (read-string "catfish: ")))

(defun file-manager-here()
  "Open an external Windows cmd in the current directory"
  (interactive)
  (cond (*is-windows*
	 (call-process-shell-command "start explorer ."))
	(*is-linux*
	 (call-process-shell-command "xdg-open ."))))

(defun fei-toggle-ui ()
  (interactive)
  (if menu-bar-mode (menu-bar-mode -1) (menu-bar-mode t))
  (if tool-bar-mode (tool-bar-mode -1) (tool-bar-mode t))
  (if scroll-bar-mode (scroll-bar-mode -1) (scroll-bar-mode t)))

(defun fei-emacs ()
  (interactive)
  (start-process "emacs" nil "emacs"))

(defun fei-occur-for-mouse ()
  (interactive)
  (if-let ((window (get-buffer-window "*Occur*")))
      (delete-window window)
    (fei-occur-at-point)))

(defun fei-occur-at-point ()
  (interactive)
  (let (case-fold-search)
    (occur (concat "\\_<" (thing-at-point 'symbol) "\\_>"))))

;;; Dired

(add-to-list 'load-path "~/.emacs.d/extensions/dired-hacks")
(require 'dired-ranger)

(defun fei-dired-paste/move (arg)
  (interactive "P")
  (if arg
      (call-interactively 'dired-ranger-move)
    (call-interactively 'dired-ranger-paste)))

(defun fei-dired-mouse-find-file-externally (event)
  (interactive "e")
  (mouse-set-point event)
  (call-interactively 'browse-url-of-dired-file))

;;; Evil

(defun evil-mode-with-cursor ()
  "设置 message 就是为了终端下面有一个提示"
  (interactive)
  (unless (boundp 'evil-mode)
    (evil-mode -1)
    (message "Now is EMACS")) ;; unless part is for initialization
  (if evil-mode
      (progn
	(evil-mode -1)
	(dolist (buf (buffer-list))
	  (set-buffer buf)
	  (setq cursor-type 'bar))
	(add-hook 'post-command-hook 'fei-change-cursor-when-readonly)
	(message "Now is EMACS 🤠"))
    (evil-mode 1)
    (remove-hook 'post-command-hook 'fei-change-cursor-when-readonly)
    (message "Now is EVIL 👽")))

(defun emacs ()
  (interactive)
  (evil-mode -1)
  (dolist (buf (buffer-list))
    (set-buffer buf)
    (setq cursor-type 'bar))
  (add-hook 'post-command-hook 'fei-change-cursor-when-readonly)
  (message "Now is EMACS 🤠"))

(defun vim ()
  (interactive)
  (evil-mode 1)
  (remove-hook 'post-command-hook 'fei-change-cursor-when-readonly)
  (message "Now is EVIL 👽"))

;;; Edit
(defun fei-display-line-numbers-cycle ()
  (interactive)
  (if (eq display-line-numbers-type 'visual)
      (menu-bar--display-line-numbers-mode-absolute)
    ;; I find visual style is more useful than relative
    (menu-bar--display-line-numbers-mode-visual)))

(require 'duplicate-line)
(defun fei-duplicate-line-or-region (&optional arg)
  (interactive "P")
  (if arg
      (call-interactively 'duplicate-line-below-comment)
    (call-interactively 'duplicate-line-or-region-below)))


;; require `pulse' library
(defun fei-pulse-current-line ()
  (interactive)
  (require 'hl-line)
  (pulse-momentary-highlight-one-line (point) 'hl-line))

;;; youdao-dictionary
(defun fei-youdao-at-point ()
  (interactive)
  (if (display-graphic-p)
      (call-interactively 'youdao-dictionary-search-at-point-tooltip)
    (call-interactively 'youdao-dictionary-search-at-point+)))

;;; multi-occur-in-this-mode

;; @REF: https://www.masteringemacs.org/article/searching-buffers-occur-mode
(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (eq mode major-mode)
          (push buf buffer-mode-matches))))
    buffer-mode-matches))

(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))

(defun fei-multi-occur-for-mouse ()
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (concat "\\_<" (thing-at-point 'symbol) "\\_>")))


;;; Counsel
(defun fei-counsel-rg-my-org ()
  (interactive)
  (counsel-rg nil "~/Nutstore Files/org"))

;; @REF: counsel-fd.el :: `counsel-fd-file-jump'
(defun fei-counsel-fd-file-jump (&optional initial-input initial-directory)
  "Jump to a file below the current directory.
List all files within the current directory or any of its subdirectories.
INITIAL-INPUT can be given as the initial minibuffer input.
INITIAL-DIRECTORY, if non-nil, is used as the root directory for search."
  (interactive
   (list nil
         (when current-prefix-arg
           (read-directory-name "From directory: "))))
  (counsel-require-program "fd")
  (let* ((default-directory (or initial-directory default-directory)))
    (ivy-read "File: "
              (split-string
               (shell-command-to-string
                (concat "fd --hidden --color never " "--exclude '*.git'"))
               "\n" t)
              :initial-input initial-input
              :action (lambda (d) (find-file (expand-file-name d)))
              :caller 'fei-counsel-fd-file-jump)))

(provide 'fei-funcs)
