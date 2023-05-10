;; smart-mode-line
(setq sml/theme nil)
(sml/setup)

(setq display-time-format " %H:%M %Y-%m-%d")
(setq display-time-default-load-average nil) ; 不显示time后面的不明数字
;; (display-time-mode)



;; Awesome-tray
(add-to-list 'load-path "~/.emacs.d/extensions/awesome-tray")
(require 'awesome-tray)
(setq awesome-tray-date-format "%H:%M %m-%d %a")
(setq awesome-tray-hide-mode-line nil)
(setq awesome-tray-active-modules '("date"))


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
