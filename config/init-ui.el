;;; init-ui.el  --- configs for UI

;;; Require

(require 'init-var)

;;; Mode
(show-paren-mode 1)
(blink-cursor-mode -1)

;;; Vars
(setq inhibit-splash-screen t)
(setq frame-resize-pixelwise t)		;这个设置在笔记本电脑上面会出现画面透明的问题，找到问题了，是桌面特效的bug，不过是启动Emacs的时候有问题，别的应用也会出现消失不见的问题

(setq-default cursor-type 'bar)

(setq display-time-format " %H:%M  %Y-%m-%d")
(setq display-time-default-load-average nil) ;不显示time后面的不明数字（load-average）
(display-time-mode 1)

;;; Fonts
;; (if *is-windows*
;;     ;; Setting English Font 仅在 windows 生效
;;     (progn
;;       (set-face-attribute
;;        'default nil
;;        :font "DejaVu Sans Mono for Powerline"
;;        :height 140)
;;      ;; Setting Chinese Font
;;      (set-fontset-font t '(#x4e00 . #x9fff) "Microsoft Yahei")))
(custom-set-faces
 '(default ((t (:family #("等距更纱黑体 SC" 0 9 (charset chinese-gbk)) :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
;; @ref https://emacs-china.org/t/windows-emacs/7907/39
;; 下面这个配置当我需要更换其他的字体的时候，加上下面这一行，也可以保证中英文的对齐
;; (set-fontset-font "fontset-default" 'unicode'("等距更纱黑体 SC"))
(set-fontset-font t 'symbol "Symbola" nil 'append)

(if *is-windows*
    ;; customize the size of frame way2 仅在 windows 下生效
    (progn
     (defun arrange-frame (w h x y)
	"Set the width, height, and x/y position of the current frame"
	(let ((frame (selected-frame)))
	  ;; (delete-other-windows)
	  (set-frame-position frame x y)
	  (set-frame-size frame w h)))
     (arrange-frame 84 30 170 20)))

;;; Funcs


(provide 'init-ui)
;;; init-ui.el ends here.
