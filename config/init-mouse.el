;; 该配置的初衷：希望尽可能的利用到鼠标的侧键和拇指键，先利用鼠标宏功
;; 能，将一些很难按的按键绑定到鼠标的按键上，如 "C-M-s-~"

(require 'fei-funcs)

(cond (*is-linux*
       ;; 快速查找定义 / 快速浏览文件
       (global-set-key (kbd "<mouse-9>") 'neotree-toggle)
       (global-set-key (kbd "<mouse-8>") 'fei-occur-at-point)
       (global-set-key (kbd "C-M-s-~") 'speedbar)
       (with-eval-after-load 'speedbar
	 (define-key speedbar-mode-map (kbd "<mouse-8>") (kbd "b"))
	 (define-key speedbar-mode-map (kbd "<mouse-9>") (kbd "f")))
       )
      (*is-windows*
       ;; 快速查找定义 / 快速浏览文件
       (global-set-key (kbd "<mouse-5>") 'neotree-toggle)
       (global-set-key (kbd "<mouse-4>") 'fei-occur-at-point)
       (global-set-key (kbd "C-M-s-~") 'speedbar)
       (with-eval-after-load 'speedbar
	 (define-key speedbar-mode-map (kbd "<mouse-4>") (kbd "b"))
	 (define-key speedbar-mode-map (kbd "<mouse-5>") (kbd "f")))
       ))

(provide 'init-mouse)
