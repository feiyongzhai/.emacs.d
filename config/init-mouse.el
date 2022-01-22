;; 该配置的初衷：希望尽可能的利用到鼠标的侧键和拇指键，该配置要求将拇
;; 指键绑定到 C-M-s-~ 这个按键上去（与配置中的按键对应）

(require 'fei-funcs)

(defun mouse-used-for (usage)
  "该函数用来在几组不同的快捷键中切换"
  (interactive)
  )

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

;; ==== Mode Line ====

;FIXME: 按键的平台差异
(global-set-key (kbd "<mode-line> <mouse-5>") 'scroll-up-line)
(global-set-key (kbd "<mode-line> <mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mode-line> <mouse-9>") 'beginning-of-buffer)
(global-set-key (kbd "<mode-line> <mouse-8>") 'end-of-buffer)

;; ==== Fringe ====

;FIXME: 按键的平台差异
(global-set-key (kbd "<right-fringe> <mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<right-fringe> <mouse-5>") 'scroll-up-line)
(global-set-key (kbd "<right-fringe> <mouse-9>") 'beginning-of-buffer)
(global-set-key (kbd "<right-fringe> <mouse-8>") 'end-of-buffer)

(provide 'init-mouse)
