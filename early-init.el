;;; early-init.el

;;; Commentary:
;; 注意：emacs 26.3 不支持 early-init.el

;;; Code:

;;; 暂时还不知道是什么原因，但是把这行代码放到这里，启动速度会快一点，
;;; 目前发现收到影响的就是启动之后使用`list-package'会显示一堆new，不过
;;; 问题不大，就先这么用着。显示一堆new的原因大概就是这行命令之后改变了
;;; `package-archives'的值。我暂时就知道这么多
(package-initialize)

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

;;; site-lisp
(let ((default-directory "~/.emacs.d/extensions"))
  (normal-top-level-add-subdirs-to-load-path)
  (add-to-list 'load-path "~/.emacs.d/extensions/"))

;;; redirect custom config
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; `early-init.el' 可对 emacsclient 生效
(require 'init-elpa)
(require 'init-ui)
;; (add-hook 'server-visit-hook (lambda ()
;; 			       (arrange-frame 84 30 170 20)))
