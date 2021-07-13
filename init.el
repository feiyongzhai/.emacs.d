;;; init.el

;; Produce backtraces when errors occur: helpful to diagnose startup issues
;; (setq debug-on-error t)

;;; enlarge gc to speed up startup
(setq pre-gc-cons-percentage gc-cons-percentage
      gc-cons-percentage 0.6)
(setq pre-gc-cons-threshold gc-cons-threshold
      gc-cons-threshold most-positive-fixnum)

;;; Require
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
(require 'init-c)
(require 'init-telega)


;;;; site-lisp
(when (display-graphic-p)
(require 'init-eaf))
(require 'init-thing-edit)
(require 'init-auto-save)
(require 'init-edit)
;; (require 'init-move-text)

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

;;; enable disabled command
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
