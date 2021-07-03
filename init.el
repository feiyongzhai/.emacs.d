;;; init.el

;;; Code:

;;; 加速启动速度
(setq pre-gc-cons-percentage gc-cons-percentage
      gc-cons-percentage 0.6)
(setq pre-gc-cons-threshold gc-cons-threshold
      gc-cons-threshold most-positive-fixnum)

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;; (setq debug-on-error t)

;;; Load Path
(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "config")))

;;; site-lisp : 第三方 package
(let ((default-directory "~/.emacs.d/extensions"))
  (normal-top-level-add-subdirs-to-load-path)
  (add-to-list 'load-path "~/.emacs.d/extensions/"))

;;; redirect the custom config generated by Custom to custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;; Require
(require 'init-encode)
(require 'init-var)

(require 'init-elpa)

;;;; built-in
(require 'init-ui)
(require 'init-misc)
(require 'init-ibuffer)
(require 'init-windows)
(require 'init-tab)
(require 'init-dired)
(require 'init-proxy)
(require 'init-vc)

(require 'init-org)

;;;; elpa
(require 'init-company)
(require 'init-counsel)
(require 'init-elfeed)
(require 'init-ido)
(require 'init-search)
;; (require 'init-projectile)
(require 'init-evil)
(require 'init-ime)
(require 'init-dict)
(require 'init-packages)
(require 'init-latex)
(require 'init-shell)
(require 'init-org-roam)
(require 'init-engine)
(require 'init-markdown)

;;;; site-lisp
(require 'init-eaf)
(require 'init-thing-edit)
(require 'init-auto-save)
(require 'init-move-text)

;;;; keys configs
(require 'init-keys)

;;;; local configs
(let ((local-config "~/.emacs.d/init-local.el"))
  (when (file-exists-p local-config)
    (load-file local-config)))


;; 如果有custom.el文件，就加载custom.el文件
;; 如果不加这局话。custom.el中的配置无法加载
;; (when (file-exists-p custom-file)
;;   (load-file custom-file))
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)

;;; 恢复原来的值
(setq gc-cons-percentage pre-gc-cons-percentage)
(setq gc-cons-threshold pre-gc-cons-threshold)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
