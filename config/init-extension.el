;;;; [m]elpa
(require 'init-packages)
(require 'init-company)
(require 'init-counsel)
(require 'init-elfeed)
(require 'init-search)
(require 'init-evil)
(require 'init-ime)
(require 'init-latex)
(require 'init-shell)
(require 'init-engine)
(require 'init-markdown)
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


(provide 'init-extension)
