;;; early-init.el

;;; Commentary:
;; 注意：emacs 26.3 不支持 early-init.el

;;;;;;;;;;;;;;;;;;;;;;; 用于判断系统的变量 ;;;;;;;;;;;;;;;;;;;;
(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))


;;; Encode config {{

;; 任何地方都使用UTF-8
(set-charset-priority 'unicode) 
;;; 此配置会导致在菜单栏选字体的时候出现乱码
;; (setq locale-coding-system   'utf-8)    ; pretty
(set-terminal-coding-system  'utf-8)    ; pretty
(set-keyboard-coding-system  'utf-8)    ; pretty
;; (set-selection-coding-system 'utf-8)    ; please
;; 问题：
;; 这个命令会导致 emacsclient 出现编码问题：server 打开时候，
;; 终端命令 ec file.name 会出现文件名乱码
;; (prefer-coding-system        'utf-8)    ; with sugar on top
;; (setq default-process-coding-system '(utf-8 . utf-8))

;;; Encode config }}


;; 把这行代码放到这里，启动速度会快一点，
(package-initialize)

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


;;; UI

;; `early-init.el' 可对 emacsclient 生效
(custom-set-faces
 '(default ((t (:family "Fantasque Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 158 :width normal)))))
(set-fontset-font t 'symbol "Symbola" nil 'append)

(require 'init-elpa)

