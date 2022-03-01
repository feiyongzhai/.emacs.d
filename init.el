;;; init.el
(let ((gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6))
  (require 'init-misc)
  (require 'init-packages)
  (require 'init-ibuffer)
  (require 'init-window-buffer-tab)
  (require 'init-dired)
  (require 'init-proxy)
  (require 'init-eww)
  (require 'init-vc)
  (require 'init-org)
  (require 'init-markdown)
  (require 'init-publish)
  (require 'init-pair)
  (require 'init-latex)
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
  (require 'init-alias)
  (require 'init-cursor)
  (require 'init-mouse)
  (require 'init-prog)
  (require 'init-python)
  (require 'init-awesome-pair)
  (require 'init-lsp)
  (when *is-linux*
    (require 'init-linux))
  (when *is-windows*
    (require 'init-win10))

  ;; 尝鲜
  (require 'init-tempel)

  ;; local configs
  (let ((local-config "~/.emacs.d/config/init-local.el"))
    (when (file-exists-p local-config)
      (load-file local-config)))

  ;; load `custom-file' if exists
  ;; (when (file-exists-p custom-file)
  ;;   (load-file custom-file))
  )

;; init.el ends here
