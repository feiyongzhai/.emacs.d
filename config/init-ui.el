;;;;;;;;;;;; 光标 ;;;;;;;;;;;;

(add-hook 'post-command-hook 'fei-change-cursor-when-readonly)
(defun fei-change-cursor-when-readonly ()
  (if buffer-read-only
      (setq cursor-type 'box)
    (setq cursor-type 'bar)))

;;;;;;;;;;;; Menu-bar ;;;;;;;;;;;;

;; 更多细节可以参考 elisp 手册中的相关章节：(info "(elisp) Menu Keymaps")

(defvar my-menu-bar-menu (make-sparse-keymap "Mine"))
(define-key global-map [C-M-down-mouse-3] my-menu-bar-menu) ;menu bar 也可以绑定一个快捷键

(add-to-list 'menu-bar-final-items 'my-menu 'append) ;让自己添加的 menu 放到最后的位置
(define-key-after global-map [menu-bar my-menu] (cons "Mine" my-menu-bar-menu) 'tools)

(define-key my-menu-bar-menu [my-cmd2] '(menu-item "用vscode打开" open-current-file-with-vscode))
(and (executable-find "gedit")
     (define-key my-menu-bar-menu [my-cmd3] '(menu-item "用gedit打开" open-current-file-with-gedit)))
(and (executable-find "gvim")
     (define-key my-menu-bar-menu [my-cmd4] '(menu-item "用gvim打开" open-current-file-with-gvim)))
(define-key my-menu-bar-menu [my-cmd5] '(menu-item "用emacsq打开" open-current-file-with-emacsq))
(define-key my-menu-bar-menu [separator] '(menu-item "--" nil))
(define-key my-menu-bar-menu [my-cmd6] '(menu-item "打开所在文件夹" file-manager-here))
(define-key my-menu-bar-menu [my-cmd7] '(menu-item "此位置打开终端" terminal-here))

;; 添加子菜单示例
;; (define-key my-menu-bar-menu [my-cmd8] `(menu-item "Search" ,menu-bar-search-menu))


;;;;;;;;;;;; Mode-line ;;;;;;;;;;;;

;; smart-mode-line
(setq sml/theme nil)
;; (sml/setup)

(setq display-time-format " %H:%M %Y-%m-%d")
(setq display-time-default-load-average nil) ;不显示time后面的不明数字
;; (display-time-mode)

;; Doom-mode-line
(setq doom-modeline-icon nil)
(setq doom-modeline-height 18)
(setq doom-modeline-highlight-modified-buffer-name nil)


;;;;;;;;;;;; Tab-line ;;;;;;;;;;;;

;; (global-tab-line-mode 1)
;; (require 'tab-line)

(setq tab-line-close-button-show t)

(defun tab-line-kill-this-buffer ()
  (interactive)
  (call-interactively 'tab-line-select-tab)
  (kill-this-buffer))


;;;;;;;;;;;; 函数 ;;;;;;;;;;;;

(defun fei-toggle-ui ()
  (interactive)
  (if menu-bar-mode (menu-bar-mode -1) (menu-bar-mode t))
  (if tool-bar-mode (tool-bar-mode -1) (tool-bar-mode t))
  (if scroll-bar-mode (scroll-bar-mode -1) (scroll-bar-mode t)))

(provide 'init-ui)
