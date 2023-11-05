(let ((file-name-handler-alist nil))
  (require 'init-ui)
  (require 'init-elpa)
  (require 'init-private)
  (require 'init-builtin)
  (require 'init-window-buffer)
  (require 'setup-windows)
  (require 'init-tab-bar)

  (require 'init-eshell)
  (require 'init-org)

  (require 'init-git)
  (require 'init-prog)
  (require 'ext-ivy.el)
  (require 'ext-orderless)
  (require 'ext-vertico)
  (require 'init-search)

  (require 'init-edit)
  (require 'init-auto-save)
  (require 'init-alias)
  (unless *is-termux*
    (require 'ext-rime))

  (require 'init-fei)
  (require 'init-bs)
  (require 'init-ibuffer)
  (require 'ext-engine)

  (require 'init-key)
  (require 'ext-evil)

  (when *is-windows*
    (require 'init-win10))
  (when *is-termux*
    (require 'init-termux))
  
  (require 'init-pyim)
  (require 'init-latex)
  (require 'init-packages)
  (require 'ext-yasnippet)
  (require 'ext-company)
  (require 'ext-lsp)

  (when *is-linux*
    (require 'init-linux))

  ;; local configs
  (when (file-exists-p fei-local-config)
    (load-file fei-local-config))

  ;; load `custom-file' if exists
  ;; (when (file-exists-p custom-file)
  ;;   (load-file custom-file))
  )
