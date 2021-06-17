;;; init-misc.el --- misc configs

(require 'init-func)

;;; Code:

;;; mode enable or disable
(global-auto-revert-mode t) ;; autoload the file changes on disk
(delete-selection-mode t)   ;; 选中文本后输入会覆盖
(save-place-mode t)

;;; Keys

(global-set-key (kbd "C-z") #'undo)
(global-set-key (kbd "C-x u") #'transient-undo)
(global-set-key (kbd "<f9>") #'global-set-or-unset-key)
(global-set-key (kbd "M-0") #'fei-google-search)
(global-set-key (kbd "M--") #'fei-meow-last-buffer)
(global-set-key (kbd "<s-tab>") #'fei-meow-last-buffer)

;;; replace y-or-n frome yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)
;; 回车代替输入y
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

;;; quick open dir or file
(fei-define-key-with-map global-map
  '(("ESC ESC h" . (lambda () (interactive) (dired "~")))
    ("ESC ESC d" . (lambda () (interactive) (dired "~/Downloads")))
    ("ESC ESC D" . (lambda () (interactive) (dired "~/Desktop")))
    ("ESC ESC m" . (lambda () (interactive) (dired "~/Music")))
    ("ESC ESC s" . (lambda () (interactive) (dired "~/Sandbox")))
    ("ESC ESC p" . (lambda () (interactive) (dired "~/Picture")))
    ("ESC ESC n" . (lambda () (interactive) (dired "~/Nutstore Files")))
    ("ESC ESC e" . (lambda () (interactive) (dired "~/.emacs.d")))
    ("ESC ESC ." . (lambda () (interactive) (dired "~/dotfiles-fei")))
    ("ESC ESC c" . (lambda () (interactive) (dired "~/.config")))
    ("ESC ESC v" . (lambda () (interactive) (dired "~/Videos")))
    ("ESC ESC V" . (lambda () (interactive) (dired "~/.vim")))

    ("ESC ESC ;" . (lambda () (interactive) (find-file "~/.emacs.d/@scratch@")))
    ("ESC ESC o" . (lambda () (interactive) (find-file "~/.emacs.d/init-local.el")))

    ("ESC ESC b" . list-bookmarks)
    ("ESC ESC l" . list-packages)
    ("ESC ESC L" . list-processes)
    ))

;;; Vars

;;; no bell
;; 参考链接：https://www.newsmth.net/nForum/#!article/Emacs/97642
(setq ring-bell-function 'ignore)

;; no backup-file
;; (setq make-backup-files nil)
;;; redirect the backup file path
(setq backup-directory-alist (quote (("." . "~/.emacs.d/.backup"))))

;;; 此配置配合`auto-save'避免写在*scratch*中的内容未保存导致的数据丢失
(add-hook 'after-init-hook
	  (lambda ()
	    (find-file "~/.emacs.d/@scratch@")
	    ;; (setq initial-buffer-choice "~/.emacs.d/@scratch@")
	    (kill-buffer "*scratch*")))

;;; Funcs

;;; quick set key and unset key
(defun global-set-or-unset-key (arg)
  (interactive "P")
  (if arg
      (call-interactively 'global-unset-key)
    (call-interactively 'global-set-key)))

(transient-command transient-undo
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

(provide 'init-misc)
;;; init-misc.el ends here.
