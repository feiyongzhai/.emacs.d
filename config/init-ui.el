;;; init-ui.el  --- configs for UI

;;; Require

(require 'init-var)

;;; Mode
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(blink-cursor-mode -1)

;;; Vars
(setq inhibit-splash-screen t)
(setq frame-resize-pixelwise t)

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

;;; autoswitch theme by time
(let ((hour (string-to-number
	     (substring (current-time-string) 11 13))))
  (if (member hour (number-sequence 6 17))
      (load-theme 'modus-operandi t)
    (load-theme 'modus-vivendi t)))

(provide 'init-ui)
;;; init-ui.el ends here.
