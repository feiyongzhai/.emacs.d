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

(defvar fei-search-prompt)

(defun fei-search (&optional arg)
  "A wrapper for `fei-google-search', powered by `engine-mode'"
  (interactive "P")
  (if arg
      (progn
	(message fei-search-prompt)
	(set-transient-map 'engine-mode-prefixed-map))
    (call-interactively 'fei-google-search)))

(defun fei-search-1 ()
  (interactive)
  (fei-search 1))

(defun backward-kill-word-or-region (&optional arg)
  "Kill word backwards unless region is active,
kill region instead"
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning)
		   (region-end))
    (backward-kill-word (or arg 1))))


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
  (counsel-rg "找不到的话，到你的闪念胶囊里看看|" "~/Nutstore Files/org"))

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
