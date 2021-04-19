(load (expand-file-name "init.el" user-emacs-directory))
;;(require 'package)
;; load autoload files and populate load-path’s
;;(package-initialize)
;; (package-initialize) doens’t require each package, we need to load
;; those we want manually
(add-to-list 'load-path "~/.emacs.d/lisp/")
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
;; dump image
(dump-emacs-portable "~/.emacs.d/emacs.pdmp")
