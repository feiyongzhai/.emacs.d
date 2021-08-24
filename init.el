;;; init.el

;; Produce backtraces when errors occur: helpful to diagnose startup issues
;; (setq debug-on-error t)

;;; enlarge gc to speed up startup
(setq pre-gc-cons-percentage gc-cons-percentage
      gc-cons-percentage 0.6)
(setq pre-gc-cons-threshold gc-cons-threshold
      gc-cons-threshold most-positive-fixnum)

;;; encode
(require 'init-encode)

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

;;; site-elisp
(require 'init-thing-edit)
(require 'init-auto-save)
(require 'init-edit)
;; (require 'init-move-text)

;;;; elpa
(require 'init-packages)
(require 'init-company)
(require 'init-counsel)
(require 'init-elfeed)
(require 'init-ido)
(require 'init-search)
(require 'init-evil)
(require 'init-ime)
(require 'init-latex)
(require 'init-shell)
(require 'init-org-roam)
(require 'init-engine)
(require 'init-c)
;; (require 'init-markdown)

;;; 只在Linux下面测试通过的配置
(require 'init-telega)

;;;; eaf is special
(when (display-graphic-p)
  (require 'init-eaf))
(add-hook 'server-after-make-frame-hook
	  (lambda () (when window-system (require 'init-eaf))))

(require 'init-win10)

;;;; keys configs
(require 'init-keys)

;;;; local configs
(let ((local-config "~/.emacs.d/init-local.el"))
  (when (file-exists-p local-config)
    (load-file local-config)))

;; load `custom-file' if exists
;; (when (file-exists-p custom-file)
;;   (load-file custom-file))

;;; restore it's origin value
(setq gc-cons-percentage pre-gc-cons-percentage)
(setq gc-cons-threshold pre-gc-cons-threshold)
