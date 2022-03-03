;;; early-init.el

;;; Commentary:
;; 注意：emacs 26.3 不支持 early-init.el

;;; Enable disabled command
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)


;; ==== 用于判断系统的变量 ====
(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))


;;; ==== Encode config ====

(set-charset-priority 'unicode)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)


;; 这行代码放在这里，启动速度会快一点，
(package-initialize)

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "extensions" user-emacs-directory))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq inhibit-splash-screen t)
(setq frame-inhibit-implied-resize t)	; 不要缩放frame.
;; (setq initial-scratch-message "")

(tool-bar-mode -1)
(global-tab-line-mode)

(let ((hour (string-to-number
             (substring (current-time-string) 11 13))))
  (unless (member hour (number-sequence 6 18))
    (load-theme 'tangotango t)  
    ))


;; `early-init.el' 可对 emacsclient 生效
(require 'init-font)
(require 'init-elpa)
