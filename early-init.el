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
(defconst fei-ime (cond (*is-linux* 'rime) (*is-windows* 'pyim)))


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

(setq modus-themes-mode-line '(3d))
;; (setq modus-themes-mode-line '3d)	;emacs29 不支持这个配置
;; (load-theme 'modus-operandi t)
;; 换回默认配色，换换口味

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)


;; `early-init.el' 可对 emacsclient 生效
(require 'init-font)

