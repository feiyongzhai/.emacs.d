(require 'init-func)
(require 'fei-funcs)

(setenv "PAGER" "cat")
;; (setq eshell-banner-message "")
(setq eshell-list-files-after-cd nil)
(setq eshell-history-size 500)
(setq eshell-cmpl-ignore-case t)
(setq eshell-visual-commands nil)	;避免自己不小心启用

;;; Make eshell don't always scroll to bottom
;; @REF: https://emacs.stackexchange.com/questions/28819/eshell-goes-to-the-bottom-of-the-page-after-executing-a-command
;; There are two solutions
(setq eshell-scroll-show-maximum-output nil)
;; (add-hook 'eshell-mode-hook
;;           (defun chunyang-eshell-mode-setup ()
;;             (remove-hook 'eshell-output-filter-functions
;;                          'eshell-postoutput-scroll-to-bottom)))

;;; Keys

(global-set-key (kbd "<s-return>") 'fei-terminal-here)
(global-set-key (kbd "M-s j") 'eshell)	;many times eshell is enough
(global-set-key (kbd "M-s M-j") 'fei-eshell-cd-here)
(global-set-key (kbd "M-s k") 'fei-ansi-term)
(global-set-key (kbd "M-s M-k") 'fei-term-cd-here)

(add-hook 'eshell-mode-hook '+fei-eshell-mode-hook)
(defun +fei-eshell-mode-hook ()
  (define-key eshell-mode-map (kbd "C-l") (li (recenter 0)))
  (define-key eshell-mode-map (kbd "C-j") 'eshell-send-input)
  (define-key eshell-mode-map (kbd "C-d") '+eshell/quit-or-delete-char)
  (define-key eshell-hist-mode-map (kbd "M-r") 'fei-my/ivy-eshell-history)
  (define-key eshell-hist-mode-map (kbd "M-s") nil)
  ;; `substring' style is very useful for eshell completion
  (setq-local completion-styles '(basic partial-completion substring emacs22))
  (toggle-truncate-lines 0))

;; Funcs
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

;; @ref https://github.com/manateelazycat/aweshell/blob/master/aweshell.el
;; `aweshell-emacs' function
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
(defun samray/eshell-fasd-z (&rest args)
  "Use fasd to change directory more effectively by passing ARGS."
  (setq args (eshell-flatten-and-stringify args))
  (let* ((fasd (concat "fasd -d " args))
	 (fasd-result (shell-command-to-string fasd))
	 (path (replace-regexp-in-string "\n$" "" fasd-result)))
    (if (eq 0 (length args))
	(eshell/cd "-")
      (eshell/cd path)
      ;; (eshell/echo path)
      )))


(provide 'init-eshell)
