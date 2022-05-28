;;; init.el

;; (require 'benchmark-init-modes)
;; (require 'benchmark-init)
;; (benchmark-init/activate)

(let ((gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6))
  (require 'init-builtin)
  (require 'init-cursor)
  (require 'init-compile)
  (require 'init-packages)
  (require 'init-bs)
  (require 'init-ibuffer)
  (require 'init-window-buffer)
  (require 'init-tab-line)
  (require 'init-tab-bar)
  (require 'init-dired)
  (require 'init-proxy)
  (require 'init-misc)

  (require 'init-org)
  (require 'init-publish)

  (require 'init-git)
  (require 'init-markdown)
  (require 'init-prog)
  (require 'init-html-css-js)
  (require 'init-python)
  (require 'init-rust)
  (require 'init-matlab)
  (require 'init-c)
  (require 'init-lsp)
  (require 'init-lisp)

  (require 'init-latex)
  (require 'init-wanderlust)
  (require 'init-company)
  (require 'init-yasnippet)
  (require 'init-ivy)
  (require 'init-orderless)
  (require 'init-minibuffer)
  (require 'init-help)
  (require 'init-elfeed)
  (require 'init-search)
  (require 'init-evil)
  (require 'init-ime)
  (require 'init-shell)
  (require 'init-engine)
  (require 'init-edit)
  (require 'init-mark)
  (require 'init-thing-edit)
  (require 'init-auto-save)
  (require 'init-alias)
  (require 'init-mouse)
  (require 'init-tool-bar)
  (require 'init-menu-bar)
  (require 'init-modeline)
  (require 'init-roam)
  
  (cond
   (*is-linux*
    (require 'init-linux))
   (*is-windows*
    (require 'init-win10)))

  ;; 自己写的垃圾小插件
  (require 'init-fei)

  ;; 尝鲜
  (add-to-list 'load-path "~/.emacs.d/config/experiment/")
  (require 'init-lsp-bridge nil t)
  ;; (require 'init-tempel)
  
  ;; local configs
  (let ((local-config "~/.emacs.d/config/init-local.el"))
    (when (file-exists-p local-config)
      (load-file local-config)))
  
  ;; load `custom-file' if exists
  ;; (when (file-exists-p custom-file)
  ;;   (load-file custom-file))
  )

(run-with-idle-timer
 1 nil
 (lambda ()
   (require 'server)
   (unless (server-running-p)
     (server-start))))

;; init.el ends here
