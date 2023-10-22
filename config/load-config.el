(let ((file-name-handler-alist nil))
  (require 'init-elpa)
  (require 'init-private)
  (require 'init-builtin)
  (require 'init-cursor)
  (require 'init-window-buffer)
  (require 'setup-windows)
  (require 'init-tab-bar)

  (require 'init-eshell)

  (require 'init-org)

  (require 'init-git)
  (require 'init-prog)
  (require 'x-ivy)
  (require 'x-orderless)
  ;; (require 'init-minibuffer)
  (require 'x-vertico)
  (require 'init-search)

  (require 'init-edit)
  (require 'init-auto-save)
  (require 'init-alias)
  (unless *is-termux*
    (require 'init-proxy)
    (require 'x-rime))

  (require 'init-tab-line)
  (require 'init-modeline)
  (require 'init-fei)
  (require 'init-bs)
  (require 'init-ibuffer)
  (require 'x-engine)
  (with-eval-after-load 'webjump
    (require 'init-webjump))
  (require 'init-key)
  (require 'x-evil)

  (when *is-windows*
    (require 'init-win10))
  (when *is-termux*
    (require 'init-termux))

  ;; 把一些不是立刻需要的功能放到这里
  (require 'init-mouse)
  ;; (require 'init-tool-bar)
  (require 'init-menu-bar)

  (require 'init-pyim)
  (require 'init-markdown)

  (require 'x-lsp)
  (require 'init-elfeed)
  (require 'init-latex)
  (require 'init-shell)
  (require 'init-packages)

  (require 'x-yasnippet)
  (require 'x-company)

  (when *is-linux*
    (require 'init-linux))

  ;; local configs
  (when (file-exists-p fei-local-config)
    (load-file fei-local-config))

  ;; load `custom-file' if exists
  ;; (when (file-exists-p custom-file)
  ;;   (load-file custom-file))
  )
