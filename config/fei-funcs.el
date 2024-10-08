;;; fei-funcs.el === 一些单独工作的小函数
(defvar fei-find-today-file-before-buffer nil)

(defun fei-find-today-file ()
  (interactive)
  (let ((file (expand-file-name
               (concat "~/Nutstore Files/org/每日碎碎念/"
                       (format-time-string "%Y-%m-%d" (current-time))
                       ".md")))
        (name (or (buffer-file-name)
		  (buffer-name))))
    (unless (file-exists-p file)
      (make-empty-file file 'parents))
    (if (string= file name)
        (switch-to-buffer fei-find-today-file-before-buffer)
      (setq fei-find-today-file-before-buffer (current-buffer))
      (find-file file))
    ))


;; ========= 自己写的插件 ========

(add-to-list 'load-path "~/.emacs.d/extensions/fei")

(require 'fei-clock)			;fei-clock
(require 'searchbox)			;searchbox
(require 'vxref)
;; (require 'tab-bar-mode-indicator)



;; Alias
(defalias 'a 'org-agenda-list)
(defalias 'l 'counsel-load-theme)
(defalias 'ov 'open-current-file-with-vscode)
(defalias 'code 'open-current-file-with-vscode)
(defalias 'oe 'open-current-file-with-emacsq)
(defalias 'of 'file-manager-here)
(defalias 'ot 'terminal-here)
(defalias 'ui 'fei-toggle-ui)
(defalias 'cmp 'compile)

;; 宏
(defmacro win10 (&rest body)
  `(when (or (eq system-type 'ms-dos)
             (eq system-type 'windows-nt))
     ,@body))

(defmacro linux (&rest body)
  `(when (eq system-type 'gnu/linux)
     ,@body))

(defmacro fei-repeat (fun-name command &rest keymaps)
  "一个方便定义瞬时命令的宏"
  (declare (indent 1))
  (let ((command-name (intern (format "%s" (symbol-name fun-name)))))
    `(defun ,command-name ()
       (interactive)
       (let ((echo-keystrokes nil))
	 ,command
	 (set-transient-map
	  (let ((map (make-sparse-keymap)))
	    (mapcar (lambda (x)
		      (define-key map (kbd (car x)) (cdr x)))
		    ,@keymaps)
	    map)
	  t)))))

(defmacro fei-define-key-with-map (map keymaps &optional filename)
  (declare (indent 1))
  `(mapcar (lambda (x)
	     (define-key ,map (kbd (car x)) (cdr x))
	     (when ,filename
	       (autoload (cdr x) ,filename nil t)))
	   ,keymaps))

(defmacro li (&rest body)
  `(lambda () (interactive) ,@body))


(defun emacs-debug-init ()
  "这样打开的 emacs 会继承当前 emacs 进程的环境变量。如果需要调试环
境变量相关的，请从终端或者其他方式启用"
  (interactive)
  (start-process "emacs-debug-init" nil "emacs" "--debug-init"))

(defalias 'time 'echo-current-time)
(defun echo-current-time ()
  (interactive)
  (message (format-time-string "%H:%M")))

(defalias 'date 'echo-current-date)
(defun echo-current-date ()
  (interactive)
  (message (format-time-string "%Y-%m-%d")))

(defun fei/buffer-or-tab-recent (&optional window)
  (interactive)
  (cond ((minibufferp)
	 (keyboard-escape-quit))
	((and tab-bar-mode
              (> (length (funcall tab-bar-tabs-function)) 1))
	 (tab-recent))
	(t
	 (mode-line-other-buffer))
	))

(defun set-selective-display-dwim ()
  (interactive)
  (set-selective-display (1+ (current-column))))

(defun fei/line-spacing-adjust (inc)
  (interactive "p")
  (let ((ev last-command-event)
	(echo-keystrokes nil))
    (let* ((base (event-basic-type ev))
           (step
            (pcase base
              ((or ?+ ?=) inc)
              (?- (- inc))
              (?0 0)
              (_ inc))))
      (fei/line-spacing-increase step)
      ;; (unless (zerop step)
      (message "Use +,-,0 for further adjustment")
      (set-transient-map
       (let ((map (make-sparse-keymap)))
         (dolist (mods '(() (control)))
           (dolist (key '(?- ?+ ?= ?0)) ;; = is often unshifted +.
             (define-key map (vector (append mods (list key)))
                         'fei/line-spacing-adjust)))
         map)))))

(defun fei/line-spacing-increase (inc)
  (interactive "p")
  (cond ((> inc 0)
	 (if line-spacing
	     (setq line-spacing (1+ line-spacing))
	   (setq line-spacing 1)))
	((< inc 0)
         (when line-spacing
	   (setq line-spacing (1- line-spacing))
	   (when (< line-spacing 0) (setq line-spacing 0))))
	((= inc 0)
	 (setq line-spacing 0))))

(defun fei/olivetti-truncate ()
  (interactive)
  (olivetti-mode 'toggle)
  (toggle-truncate-lines 1))

(defun fei/counsel-recentf-dir ()
  (interactive)
  (require 'pyim-cregexp-utils)
  (let ((ivy-re-builders-alist
	 '((t . pyim-cregexp-ivy))))
    (find-file
     (ivy-read "Recent Dir: "
	       (delete-dups
		(mapcar (lambda (x) (file-name-directory x))
			recentf-list))))))

(defun fei/store-frameset ()
  (interactive)
  (frameset-to-register ?f))

(defun fei/load-frameset ()
  (interactive)
  (jump-to-register ?f))

(defun fei/echo-line ()
  "这是一个非常简单的想法：有的时候，一行太长了在 buffer 页面显示不完全但是 echo area 总是很长，利用起来"
  (interactive)
  (message (string-trim (thing-at-point 'line))))

(defun fei/fit-window-to-buffer ()
  (interactive)
  (frameset-to-register ?f)
  (call-interactively 'fit-window-to-buffer))

(defun fei/toggle-comment-line ()
  (interactive)
  (save-excursion (call-interactively 'comment-line)))

(defun new-buffer-same-major-mode ()
  "refer to `evil-buffer-new'"
  (interactive)
  (let ((buffer (generate-new-buffer "*new*"))
        (mode major-mode))
    (with-current-buffer buffer
      (funcall mode)
      (switch-to-buffer-other-window buffer))))

(defun new-buffer ()
  "refer to `evil-buffer-new'"
  (interactive)
  (switch-to-buffer (generate-new-buffer "*new*")))

(defvar new-buffer-jump-from-minibuffer-p nil)
(defvar new-buffer-before-buffer nil
  "运行 `new-buffer-other-window' 之前的 buffer 和位置信息")

(defun new-buffer-other-window ()
  "命令初心：因为有的时候 emacs-rime 的 disable 不够智能。

想着可以通过新建一个 buffer 来输入一段文字然后粘贴过去"
  (interactive)
  (setq new-buffer-before-buffer (cons (current-buffer) (point)))
  (and (minibufferp)
       (setq new-buffer-jump-from-minibuffer-p t))
  (let ((buffer (generate-new-buffer "*new*")))
    (switch-to-buffer-other-window buffer)
    (with-current-buffer buffer
      (activate-input-method "rime")
      (yas-minor-mode) ;好奇为什么这个 buffer 不会自动启用 yas-minor-mode
      (let ((map (make-sparse-keymap)))
	(set-keymap-parent map (current-local-map))
	(define-key map (kbd "C-c C-c") 'new-buffer-quit-and-copy)
	(define-key map (kbd "C-c C-k") 'kill-buffer-and-window)
	(use-local-map map)))))

(defun new-buffer-quit-and-copy ()
  (interactive)
  (kill-new (buffer-string))
  (kill-buffer-and-window)
  (with-selected-window (get-buffer-window (car new-buffer-before-buffer))
    (goto-char (cdr new-buffer-before-buffer))
    (call-interactively 'yank))

  (when new-buffer-jump-from-minibuffer-p
    (switch-to-minibuffer)))

(defun fei/kill-or-bury-buffer ()
  (interactive)
  (if (bound-and-true-p emacs-lock-mode)
      (call-interactively 'bury-buffer)
    (call-interactively 'kill-current-buffer)))

(defun ascii-table ()
  "Display basic ASCII table (0 thru 127)"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (save-excursion (let ((i -1))
                    (insert "ASCII characters 0 thru 127.\n\n")
                    (insert " Hex  Dec  Char|  Hex  Dec  Char|  Hex  Dec  Char|  Hex  Dec  Char\n")
                    (while (< i 31)
                      (insert (format "%4x %4d %4s | %4x %4d %4s | %4x %4d %4s | %4x %4d %4s\n"
                                      (setq i (+ 1  i)) i (single-key-description i)
                                      (setq i (+ 32 i)) i (single-key-description i)
                                      (setq i (+ 32 i)) i (single-key-description i)
                                      (setq i (+ 32 i)) i (single-key-description i)))
                      (setq i (- i 96)))))
  (toggle-read-only 1))


;;;###autoload
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (progn (beginning-of-line-text) (point)))
      (beginning-of-line)))

(defun fei/narrow-one-line ()
  (interactive)
  (narrow-to-region (line-beginning-position) (line-end-position)))


;;;###autoload
(defun store-register-dwim (arg register)
  "Store what I mean in a register.
With an active region, store or append (with \\[universal-argument]) the
contents, optionally deleting the region (with a negative
argument). With a numeric prefix, store the number. With \\[universal-argument]
store the frame configuration. Otherwise, store the point."
  (interactive
   (list current-prefix-arg
         (register-read-with-preview "Store in register: ")))
  (cond
   ((use-region-p)
    (let ((begin (region-beginning))
          (end (region-end))
          (delete-flag (or (equal arg '-)  (equal arg '(-4)))))
      (if (consp arg)
          (append-to-register register begin end delete-flag)
        (copy-to-register register begin end delete-flag t))))
   ((numberp arg) (number-to-register arg register))
   (t (point-to-register register arg))))

;;;###autoload
(defun use-register-dwim (register &optional arg)
  "Do what I mean with a register.
For a window configuration, restore it. For a number or text, insert it.
For a location, jump to it."
  (interactive
   (list (register-read-with-preview "Use register: ")
         current-prefix-arg))
  (condition-case nil
      (jump-to-register register arg)
    (user-error (insert-register register arg))))


(defun sudo-find-this-file ()
  (interactive)
  (if (buffer-file-name)
      ;; 不清楚 sudo:root@localhost: 表示的含义，但是现在这个命令能用
      (find-file (concat "/sudo:root@localhost:" buffer-file-name))
    (message "buffer without file can't deal with sudo")))

(defun backward-kill-word-or-region (&optional arg)
  "Kill word backwards unless region is active,
kill region instead"
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning)
		   (region-end))
    (backward-kill-word (or arg 1))))


;; @REF: https://emacs-china.org/t/leader-vscode/19166/29?u=yongfeizhai
;; @REF: https://emacs-china.org/t/vscode-vscode-emacs/22927/11
(defun open-current-file-with-vscode ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
	;; emacs 中的 column 是从 0 开始计数的，vscode 的 column 是从 1 开始计数的
	(column (number-to-string (1+ (current-column)))))
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
	;; emacs 中的 column 是从 0 开始计数的，命令行是按照列从一开始计数，所以输入的参数会做 -1 处理
	(column (number-to-string (current-column))))
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

(defun file-manager-here()
  "Open an external Windows cmd in the current directory"
  (interactive)
  (cond (*is-windows*
	 (call-process-shell-command "start explorer ."))
	(*is-linux*
	 (call-process-shell-command "xdg-open ."))))

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
                (concat "fd --hidden --color never " "--exclude *.git"))
               "\n" t)
              :initial-input initial-input
              :action (lambda (d) (find-file (expand-file-name d)))
              :caller 'fei-counsel-fd-file-jump)))


;; @REF: https://emacs-china.org/t/topic/18075/3
(defun goto-longest-line ()
  (interactive)
  (let ((current-line 0)
        (current-column 0))
    (save-excursion
      (goto-char (point-min))
      (catch 'end-of-file
        (while t
          (end-of-line)
          (when (< current-column (current-column))
            (setq current-line (line-number-at-pos)
                  current-column (current-column)))
          (unless (zerop (forward-line 1))
            (throw 'end-of-file nil)))))
    (goto-line current-line)))

(defun longest-line-colum ()
  (let ((current-line 0)
        (current-column 0))
    (save-excursion
      (goto-char (point-min))
      (catch 'end-of-file
        (while t
          (end-of-line)
          (when (< current-column (current-column))
            (setq current-line (line-number-at-pos)
                  current-column (current-column)))
          (unless (zerop (forward-line 1))
            (throw 'end-of-file nil)))))
    (save-excursion
      (goto-line current-line)
      (end-of-line)
      (current-column))))

;; `fit-frame-to-buffer' 做了差不多的事情
(defun adjust-frame-by-longest-line ()
  (interactive)
  (set-frame-width nil (+ (if (bound-and-true-p display-line-numbers-mode) 5 0)
			  (longest-line-colum))))


;; require `pulse' library
(defun fei-pulse-current-line ()
  (interactive)
  (require 'hl-line)
  (pulse-momentary-highlight-one-line (point) 'hl-line))


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


(defun switch-to-same-major-mode-buffer ()
  "切换到和当前 buffer 相同 major-mode 的 buffer"
  (interactive)
  (let (filtered-buf
	(cur-major-mode major-mode))
    (dolist (buf (cdr (buffer-list)))
      ;; 不显示当前 buffer
      (with-current-buffer buf
	(when (eq major-mode cur-major-mode)
	  (push buf filtered-buf))))
    (if (length= filtered-buf 0)
        (message "No same marjo-mode buffer!")
      (switch-to-buffer
       (completing-read
        "Switch to buffer with same major-mode: "
        (mapcar (lambda (buf) (buffer-name buf)) filtered-buf))))))

(defun switch-to-locked-buffer ()
  "切换到启用 `emacs-lock-mode' 的 buffer

这样可以把 `emacs-lock-mode' 作为书签来用标记 “重要” buffer 的方法"
  (interactive)
  (let (filtered-buf
	(cur-major-mode major-mode))
    (dolist (buf (cdr (buffer-list)))
      ;; 不显示当前 buffer
      (with-current-buffer buf
	(when (bound-and-true-p emacs-lock-mode)
	  (push buf filtered-buf))))
    (switch-to-buffer
     (completing-read
      "Switch to locked buffer: "
      (mapcar (lambda (buf) (buffer-name buf)) filtered-buf)))))


;; 一行流，哈哈
(defvar pre-frame-height (frame-height))

(defun fei-frame-one-line ()
  (interactive)
  (let ((ch (frame-height)))
    (if (eq ch 5)
	(set-frame-height nil pre-frame-height)
      (setq pre-frame-height ch)
      (set-frame-height nil 5))))

;; (add-hook 'org-capture-mode-hook (lambda () (set-window-text-height nil 1)))


;; 准备弃用的命令
(defun split-window-right-select ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun split-window-below-select ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun eshell-other-window ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (eshell))

(defun replace-string-one-line ()
  (interactive)
  (replace-string-in-region (read-string "原始字符串: ")
                            (read-string "替换字符串: ")
                            (line-beginning-position)
                            (line-end-position)))

(provide 'fei-funcs)
