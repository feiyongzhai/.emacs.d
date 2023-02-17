;;; Linux 专用配置

(require 'fei-funcs)

(global-set-key (kbd "M-s k") 'fei-ansi-term)
(global-set-key (kbd "M-s M-k") 'fei-term-cd-here)

;; pdf-tools
(unless *is-termux*
  (require 'init-pdf-tools))

;; (require 'init-wanderlust)

;; Fcitx
(setq fcitx-active-evil-states '(insert emacs hybrid))
(fcitx-evil-turn-on)
(fcitx-aggressive-minibuffer-turn-on)
;; (fcitx-aggressive-setup)
;; (fcitx-prefix-keys-add "M-s")
;; (fcitx-prefix-keys-add "C-x")
;; (fcitx-prefix-keys-add "C-c")
;; (fcitx-prefix-keys-add "C-h")
;; (fcitx-prefix-keys-turn-on)
;; BUG: `fcitx-prefix-keys-turn-on' 会引入一个问题：在按住修饰键，鼠标点击 tab bar 会造成 emacs 崩溃

;; Sis
;; sis 和 emacsclient / deamon 的时候会出现退不出 emacs 的情况

;; 错误提示如下：
;; terminal-focus-reporting--apply-to-terminal: Device 1 is not a termcap terminal device

;; (setq sis-prefix-override-keys '("C-c" "C-x" "C-h" "M-s"))
;; (sis-ism-lazyman-config "1" "2" 'fcitx)
;; (sis-global-respect-mode 1)

;;; Funcs
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


(provide 'init-linux)
