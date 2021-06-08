;;; init-ui.el  --- configs for UI

;; inhibit the startup screen
(setq inhibit-splash-screen t)

;; 避免光标闪烁
(blink-cursor-mode -1)
(setq-default cursor-type 'bar)

(setq display-time-format " %H:%M  %Y-%m-%d")
(setq display-time-default-load-average nil)	;不显示time后面跟着的不明数字（load-average）
(display-time-mode 1)

;; enable show-paren-mode
(show-paren-mode 1)

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
;;; 一个更好地字体设置,下面heigh的默认值是98
(custom-set-faces
 '(default ((t (:family #("等距更纱黑体 SC" 0 9 (charset chinese-gbk)) :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))

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

(provide 'init-ui)
;;; init-ui.el ends here.
