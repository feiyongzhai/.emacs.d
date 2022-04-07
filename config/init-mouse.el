;; 该配置的初衷：希望尽可能的利用到鼠标的侧键和拇指键，先利用鼠标宏功
;; 能，将一些很难按的按键绑定到鼠标的按键上，如 "C-M-s-~"

;; less known keybindings：
;; 1. <C-M-mouse-1> ：mouse-drag-region-rectangle
;; 2. <M-mouse-1> ：mouse-set-secondary (secondary selection)

;; windows 上的 mouse-4 对应 linux 上的 mouse-8
;; windows 上的 mouse-5 对应 linux 上的 mouse-9

(require 'fei-funcs)

(cond (*is-linux*
       ;; 快速查找定义 / 快速切换 buffer 或者 文件
       (global-set-key (kbd "<C-mouse-9>") (li (setq bs-cur-major-mode major-mode) (bs-show nil)))
       ;; (global-set-key (kbd "<mouse-9>") 'neotree-toggle)
       (global-set-key (kbd "<mouse-9>") 'treemacs)
       (global-set-key (kbd "<mouse-8>") 'fei-occur-for-mouse)
       ;; (global-set-key (kbd "<C-mouse-8>") 'fei-multi-occur-for-mouse)
       (global-set-key (kbd "<C-mouse-8>") 'symbol-overlay-find-at-point-project)
       ;; 相当于快速标记一个点并跳回（只作用于当前 buffer）
       (global-set-key (kbd "<M-mouse-9>") 'push-mark-command)
       (global-set-key (kbd "<M-mouse-8>") 'pop-to-mark-command)

       (global-set-key (kbd "C-M-s-~") 'speedbar)
       (with-eval-after-load 'speedbar
	 (define-key speedbar-mode-map (kbd "<mouse-8>") (kbd "b"))
	 (define-key speedbar-mode-map (kbd "<mouse-9>") (kbd "f")))
       )
      (*is-windows*
       ;; 快速查找定义 / 快速浏览文件
       (global-set-key (kbd "<mouse-5>") 'neotree-toggle)
       (global-set-key (kbd "<mouse-4>") 'fei-occur-for-mouse)
       (global-set-key (kbd "<C-mouse-4>") 'fei-multi-occur-for-mouse)
       (global-set-key (kbd "C-M-s-~") 'speedbar)
       (with-eval-after-load 'speedbar
	 (define-key speedbar-mode-map (kbd "<mouse-4>") (kbd "b"))
	 (define-key speedbar-mode-map (kbd "<mouse-5>") (kbd "f")))
       ))

(provide 'init-mouse)
