;; minions-mode == 简化 minor-mode 的显示
(minions-mode)
(global-set-key [S-down-mouse-3] 'minions-minor-modes-menu) ;默认是 `kmacro-call-macro' （加载 kmacro.el 后）
(add-to-list 'minions-available-modes '(feebleline-mode . nil))	;添加显示的菜单项
(setq minions-prominent-modes '(company-mode company-search-mode)) ;不隐藏的 minor-mode

;; feebleline
(add-to-list 'load-path "~/.emacs.d/extensions/feebleline")
(require 'feebleline)

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


;;; modeline 到顶部
;; (setq-default header-line-format mode-line-format) ; Copy mode-line
;; (setq-default mode-line-format nil) ; Remove mode-line


(provide 'init-modeline)
