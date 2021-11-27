;;; init.el

;;; enlarge gc to speed up startup
(setq pre-gc-cons-percentage gc-cons-percentage
      gc-cons-percentage 0.6)
(setq pre-gc-cons-threshold gc-cons-threshold
      gc-cons-threshold most-positive-fixnum)

(require 'init-misc)
(require 'init-ibuffer)
(require 'init-window-buffer-tab)
(require 'init-dired)
(require 'init-proxy)
(require 'init-vc)
(require 'init-org-markdown)
(require 'init-prog)
(require 'init-pair)
(require 'init-latex)
(require 'init-matlab-octave)
(require 'init-mail)
(require 'init-company)
(require 'init-completion)
(require 'init-elfeed)
(require 'init-search)
(require 'init-evil)
(require 'init-ime)
(require 'init-shell)
(require 'init-engine)
(require 'init-thing-edit)
(require 'init-auto-save)
(require 'init-edit)
(require 'init-quick-open)
(when *is-linux*
  (require 'init-linux))
(when *is-windows*
  (require 'init-win10))

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
