;;; early-init.el

;;; Commentary:
;; 注意：emacs 26.3 不支持 early-init.el

;; ==== 用于判断系统的变量 ====
(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))


;;; ==== Encode config ====

(set-charset-priority 'unicode)
(set-terminal-coding-system  'utf-8)    ; pretty
(set-keyboard-coding-system  'utf-8)    ; pretty


;; 这行代码放在这里，启动速度会快一点，
(package-initialize)

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq initial-major-mode 'fundamental-mode)


;; `early-init.el' 可对 emacsclient 生效
(require 'init-font)
(require 'init-elpa)
