;;; init.el

;; Produce backtraces when errors occur: helpful to diagnose startup issues
;; (setq debug-on-error t)

;;; enlarge gc to speed up startup
(setq pre-gc-cons-percentage gc-cons-percentage
      gc-cons-percentage 0.6)
(setq pre-gc-cons-threshold gc-cons-threshold
      gc-cons-threshold most-positive-fixnum)

;;; Builtins
(require 'init-misc)
(require 'init-ibuffer)
(require 'init-window-buffer-tab)
(require 'init-dired)
(require 'init-proxy)
(require 'init-vc)
(require 'init-org-markdown)
(require 'init-prog)
(require 'init-mail)

;;; Extensions

;;; [m]elpa
(require 'init-company)
(require 'init-completion)
(require 'init-elfeed)
(require 'init-search)
(require 'init-evil)
(require 'init-ime)
(require 'init-shell)
(require 'init-engine)
(when *is-linux*
  (require 'init-linux))

;;; site-elisp
(require 'init-thing-edit)
(require 'init-auto-save)
(require 'init-edit)
;; (require 'init-move-text)

;;;; eaf is special
(when *is-linux*
  (when (display-graphic-p)
    (require 'init-eaf))
  (add-hook 'server-after-make-frame-hook
	    (lambda () (when window-system (require 'init-eaf)))))

(when *is-windows*
  (require 'init-win10))

;;; keys configs
(require 'init-quick-open)

;;; local configs
(let ((local-config "~/.emacs.d/init-local.el"))
  (when (file-exists-p local-config)
    (load-file local-config)))

;; load `custom-file' if exists
;; (when (file-exists-p custom-file)
;;   (load-file custom-file))

;;; restore it's origin value
(setq gc-cons-percentage pre-gc-cons-percentage)
(setq gc-cons-threshold pre-gc-cons-threshold)
