(require 'fei-funcs)

(defun mouse-used-for (usage)
  "该函数用来在几组不同的快捷键中切换"
  (interactive)
  )

;; 切换 Buffer
(global-set-key (kbd "<mouse-9>") 'next-buffer)
(global-set-key (kbd "<mouse-8>") 'previous-buffer)

;; copy / replace
(global-set-key (kbd "<mouse-9>") 'thing-copy-symbol)
(global-set-key (kbd "<mouse-8>") 'thing-replace-symbol)

;; 快速查找定义 / 快速浏览文件
(global-set-key (kbd "<mouse-9>") 'neotree-toggle)
(global-set-key (kbd "<mouse-8>") 'fei-occur-at-point)

;; ==== Mode Line ====

(global-set-key (kbd "<mode-line> <mouse-5>") 'scroll-up-line)
(global-set-key (kbd "<mode-line> <mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mode-line> <mouse-9>") 'beginning-of-buffer)
(global-set-key (kbd "<mode-line> <mouse-8>") 'end-of-buffer)

;; ==== Fringe ====

(global-set-key (kbd "<right-fringe> <mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<right-fringe> <mouse-5>") 'scroll-up-line)
(global-set-key (kbd "<right-fringe> <mouse-9>") 'beginning-of-buffer)
(global-set-key (kbd "<right-fringe> <mouse-8>") 'end-of-buffer)

(provide 'init-mouse)
