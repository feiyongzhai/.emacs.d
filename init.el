;;; init.el

;; Produce backtraces when errors occur: helpful to diagnose startup issues
;; (setq debug-on-error t)

;;; enlarge gc to speed up startup
(setq pre-gc-cons-percentage gc-cons-percentage
      gc-cons-percentage 0.6)
(setq pre-gc-cons-threshold gc-cons-threshold
      gc-cons-threshold most-positive-fixnum)

(require 'init-builtin)
(require 'init-extension)

(when *is-windows*
  (require 'init-win10))

;;;; keys configs
(require 'init-quick-open)

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
