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


(package-initialize)		 ;这行代码放在这里，启动速度会快一点，

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "extensions" user-emacs-directory))

(require 'init-elpa)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq inhibit-splash-screen t)
(setq frame-inhibit-implied-resize t)	; 不要缩放frame.
;; (setq initial-scratch-message "")

(setq tab-bar-select-tab-modifiers '(meta)) ;这个需要在 tab-bar-mode 启用之前
(tab-bar-mode)
(tab-bar-history-mode)
(tab-bar-echo-area-mode -1)
(tool-bar-mode)
(menu-bar-mode)
(global-tab-line-mode -1)

(let ((hour (string-to-number
             (substring (current-time-string) 11 13))))
  (unless (member hour (number-sequence 6 21))
    ;; (load-theme 'modus-vivendi t)
    ;; (load-theme 'whiteboard t)
    ;; (load-theme 'deeper-blue t)
    (load-theme 'tango-dark t)
    ))


;; `early-init.el' 可对 emacsclient 生效
(require 'init-font)

