;;; init-encode.el  --- configs for encode

;; 任何地方都使用UTF-8
(set-charset-priority 'unicode) 
;;; 这个命令会导致在菜单栏选字体的时候出现乱码
;; (setq locale-coding-system   'utf-8)    ; pretty
(set-terminal-coding-system  'utf-8)    ; pretty
(set-keyboard-coding-system  'utf-8)    ; pretty
;; (set-selection-coding-system 'utf-8)    ; please
;;; 问题：
;; 这个命令会导致 emacsclient 出现编码问题：server 打开时候，
;; 终端命令 ec file.name 会出现文件名乱码
;; (prefer-coding-system        'utf-8)    ; with sugar on top
;; (setq default-process-coding-system '(utf-8 . utf-8))

(provide 'init-encode)

