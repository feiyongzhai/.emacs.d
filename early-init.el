;;; early-init.el --- 

;;; Commentary:
;; 这部分代码在 windows 平台下的 emacsclient 的 frame 生效
;; 但是在 Linux Mint 平台下似乎不生效: 我知道原因了，mint上面
;; emacs是26.3,还不支持 early-init 这个功能

;;; Code:

;;; UI
;; 这个文件 `early-init' 可以对于 emacsclient 生效
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; (add-hook 'server-visit-hook (lambda ()
;; 			       (arrange-frame 84 30 170 20)))

;;; early-init.el ends here
