;;; init-test.el --- 尝试一些新功能

;;; Comentary:
;; 每次提交的时候我会默认把这个文件的变动忽略，或者说直接在 emacs 中提
;; 交的时候不提交这个文件。就是我不关心这个文件的变动，也不追踪这个文
;; 件的变化，这个文件的作用就是存在就可以了。便于我去尝试一些新功能，
;; 所以我也没有必要频繁提交这个文件。所以在这个文件中的内容存在着丢失
;; 的风险。如果想要保留一些觉得有用的配置。请移动其他文件中。

;;; Code:

;;; Netease Cloud Music
;; 项目主页：https://github.com/SpringHan/netease-cloud-music.el
;; Dependences: `request' `async'
;; (add-to-list 'user/package-ensure-installed 'async)

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/netease-cloud-music.el")

;; (require 'netease-cloud-music)

(load-theme 'doom-gruvbox t)

(custom-set-faces
 '(default ((t (:family #("等距更纱黑体 SC" 0 9 (charset chinese-gbk)) :foundry "outline" :slant normal :weight normal :height 180 :width normal)))))


(provide 'init-test)
;;; init-test.el ends here.
