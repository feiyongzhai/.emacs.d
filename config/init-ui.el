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

;; == 修改 mode-line 的一个示例 ==

;; (setq mode-line-format
;;       `(:propertize (:eval (buffer-name))
;;             help-echo "Major mode\n\
;; mouse-1: Display major mode menu\n\
;; mouse-2: Show help for major mode\n\
;; mouse-3: Toggle minor modes"
;; 	    face bold
;;             mouse-face highlight
;;             local-map ,(make-mode-line-mouse-map 'mouse-1 my-menu-bar-menu)))

;;; 把 modeline 到顶部
;; (setq-default header-line-format mode-line-format) ; Copy mode-line
;; (setq-default mode-line-format nil) ; Remove mode-line


;;;;;;;;;;;; Tool-bar ;;;;;;;;;;;;
;; (tool-bar-add-item "spell" 'global-tab-line-mode 'global-tab-line-mode)

;; (define-key-after (default-value 'tool-bar-map) [separator-fei] menu-bar-separator)

;; (tool-bar-add-item-from-menu 'previous-buffer "left-arrow" nil :vert-only t)
;; (tool-bar-add-item-from-menu 'next-buffer "right-arrow" nil :vert-only t)
;; (tool-bar-add-item "left-arrow" 'previous-buffer 'previous-buffer :label "")
;; (tool-bar-add-item "right-arrow" 'next-buffer 'next-buffer :label "")

;; (let ((tool-bar-map (default-value 'tool-bar-map)))
;;   (tool-bar-add-item "index" (lambda ()
;; 			       (interactive)
;; 			       (popup-menu my-menu-bar-menu))
;; 		     'help
;; 		     :help "Pop up the Help menu"
;; 		     :label ""))


 ;;;;;;;;;;;; Tab-line ;;;;;;;;;;;;

;; (global-tab-line-mode 1)
;; (require 'tab-line)

(setq tab-line-close-button-show t)
;; (setq tab-line-new-button-show nil)
;; (setq tab-line-tab-name-function 'tab-line-tab-name-truncated-buffer)
;; (setq tab-line-separator "|")

;; `face-spec-set' 和 `custom-set-faces' 还是有点区别的，
;; `custom-set-faces' 在更换主题后会重新加载，所以更推荐用
;; `custom-set-faces'

;; (face-spec-set 'tab-line '((t (:inherit mode-line :height 0.95))))
;; (face-spec-set 'tab-line '((t (:inherit nil :height 0.95))))
;; (custom-set-faces
;;  '(tab-line ((t (:inherit nil :background "grey85" :foreground "black" :height 0.95)))))

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
