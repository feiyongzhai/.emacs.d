;; 更多细节可以参考 elisp 手册中的相关章节：(info "(elisp) Menu Keymaps")

(defvar my-menu-bar-menu (make-sparse-keymap "Mine"))
(define-key global-map [C-M-down-mouse-3] my-menu-bar-menu) ;menu bar 也可以绑定一个快捷键
(add-to-list 'menu-bar-final-items 'my-menu 'append) ;让自己添加的 menu 放到最后的位置
(define-key-after global-map [menu-bar my-menu] (cons "Mine" my-menu-bar-menu) 'tools)

(define-key my-menu-bar-menu [my-cmd1] '(menu-item "fei-emacs" fei-emacs))
(define-key my-menu-bar-menu [my-cmd2] '(menu-item "fei-vscode" open-current-file-with-vscode))
(define-key my-menu-bar-menu [my-cmd3] '(menu-item "fei-gedit" open-current-file-with-gedit))
(define-key my-menu-bar-menu [my-cmd4] '(menu-item "fei-gvim" open-current-file-with-gvim))
(define-key my-menu-bar-menu [my-cmd5] '(menu-item "fei-emacsq" open-current-file-with-emacsq))

(provide 'init-menu-bar)
