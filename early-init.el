;;; early-init.el

;;; Commentary:
;; 注意：emacs 26.3 不支持 early-init.el

;; 根据 emacs-china 的说法，吧 gc 相关的配置放到 early-init 中会快一点
;; @REF: https://emacs-china.org/t/emacs-10/17716
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)

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
(defconst *is-termux*
  (and (eq system-type 'gnu/linux)
       (string-match-p "android" system-configuration))
  "这个判断方式不一定完全准确")

(setq fei-local-config (cond (*is-windows* "~/.emacs.d/local.el")
			     (*is-termux* "~/Nutstore Files/src/local-termux.el")
			     (*is-linux* "~/Nutstore Files/src/local-linux.el")
			     (t "")))


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
(setq frame-inhibit-implied-resize t)	;不要缩放frame.
;; (setq initial-scratch-message "")

(unless *is-termux*
  (scroll-bar-mode -1)

  ;; `early-init.el' 可对 emacsclient 生效
  (require 'init-font)
  )
