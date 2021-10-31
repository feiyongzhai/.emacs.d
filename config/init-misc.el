;;; init-misc.el --- misc configs

(require 'init-func)

;;; Modes
(global-auto-revert-mode t) ;; autoload the file changes on disk
(delete-selection-mode t)   ;; 选中文本后输入会覆盖
(column-number-mode t)
(save-place-mode t)
;; (desktop-save-mode t)
(savehist-mode t)
(show-paren-mode 1)
(blink-cursor-mode -1)

;;; Keys

(fei-define-key-with-map global-map
  `(("<insert>" . nil)
    ("M-g i" . imenu)
    ("C-x F" . set-fill-column)
    ("<f5>" . fei-simple-compile)
    ("<f10>" . global-hide-mode-line-mode)
    ("M-h" . find-file)		      ; inspired by emacstalk 嘉宾领峰
    ("M-H" . counsel-recentf)
    ("M-j" . switch-to-buffer)
    ("C-t" . embark-act)
    ("M-." . embark-dwim)
    ("C-x B" . consult-buffer)
    ))
(global-set-key (kbd "<menu>") 'embark-act)

;; {{ y-or-n
(fset 'yes-or-no-p 'y-or-n-p)
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)
;; }} y-or-n

;;; Vars

(setq inhibit-splash-screen t)
(setq-default cursor-type 'hbar)

(setq display-time-format " %H:%M  %Y-%m-%d")
(setq display-time-default-load-average nil) ;不显示time后面的不明数字（loa
(setq desktop-restore-frames nil)    ; don't restore any frame

;; 参考链接：https://www.newsmth.net/nForum/#!article/Emacs/97642
(setq ring-bell-function 'ignore)
;;; redirect the backup file path
(setq backup-directory-alist (quote (("." . "~/.emacs.d/.backup"))))
(setq initial-scratch-message "")

;;; Funcs

(defun fei-simple-compile ()
  (interactive)
  (save-buffer)
  (let (compilation-read-command)
    (call-interactively 'compile)))

(transient-command undo
  (undo)
  '(("u" . undo)))

;;; 参考链接：https://liujiacai.net/blog/2020/11/25/why-emacs/
(defun fei-google-search ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))

;;; 快速切换上一个 buffer --- code copied from meow-mode
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

;;; Misc

(global-set-key (kbd "C-x /") 'engine-mode-prefixed-map)
(setq ahk-indentation 4)
(setq minimap-window-location 'right)
(global-set-key (kbd "s-o") 'ace-window)
(setq aw-keys '(?j ?k ?l ?h ?g ?f ?d ?s ?a))
(custom-set-faces '(aw-leading-char-face
		    ((t (:foreground "red" :height 1.5)))))

(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i"
    #'youdao-dictionary-search-from-input))
(global-set-key (kbd "s-y") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "C-h y") 'youdao-dictionary-search-from-input)

(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "M-o") nil)
  (define-key diff-mode-map (kbd "M-k") nil)
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))

(defun yasnippet-snippets--fixed-indent ()
  "Set `yas-indent-line' to `fixed'."
  (set (make-local-variable 'yas-indent-line) 'fixed))

(defun yasnippet-snippets--no-indent ()
  "Set `yas-indent-line' to nil."
  (set (make-local-variable 'yas-indent-line) nil))

(with-eval-after-load 'yasnippet
  (yas-load-directory (expand-file-name "~/.emacs.d/snippets") t))

;;; Enable disabled command
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(provide 'init-misc)
;;; init-misc.el ends here.
