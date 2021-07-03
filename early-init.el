;;; early-init.el

;;; Commentary:
;; 注意：emacs 26.3 不支持 early-init.el

;;; Code:

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

;;; site-lisp
(let ((default-directory "~/.emacs.d/extensions"))
  (normal-top-level-add-subdirs-to-load-path)
  (add-to-list 'load-path "~/.emacs.d/extensions/"))

;;; redirect custom config
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; `early-init.el' 可对 emacsclient 生效
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; (add-hook 'server-visit-hook (lambda ()
;; 			       (arrange-frame 84 30 170 20)))
