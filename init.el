;;; init.el

;; (require 'benchmark-init-modes)
;; (require 'benchmark-init)
;; (benchmark-init/activate)

;;@REF: https://github.com/lujun9972/emacs-document/blob/master/emacs-common/2个鲜为人知的提高Emacs启动速度的步骤.org
(let ((file-name-handler-alist nil)
      (gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6))
  (require 'init-builtin)
  (require 'init-cursor)
  (require 'init-window-buffer)
  (require 'init-tab-bar)

  (require 'init-eshell)

  (require 'init-org)

  (require 'init-git)
  (require 'init-prog)
  (require 'init-html-css-js)
  (require 'init-python)
  (require 'init-rust)
  (require 'init-matlab)
  (require 'init-c)
  (require 'init-lisp)

  (require 'init-ivy)
  (require 'init-orderless)
  ;; (require 'init-minibuffer)
  (require 'init-vertico)
  (require 'init-help)
  (require 'init-search)

  (require 'init-edit)
  (require 'init-auto-save)
  (require 'init-alias)
  (require 'init-proxy)

  ;; (require 'init-tab-line)
  (require 'init-modeline)
  (require 'init-fei)
  (require 'init-rime)
  (require 'init-dired)
  (require 'init-ibuffer)
  (require 'init-engine)

  (when *is-windows*
    (require 'init-win10))
  ;; (require 'init-mark)

  (run-with-idle-timer
   3 nil
   (lambda ()
     ;; 把一些不是立刻需要的功能放到这里
     (require 'init-mouse)
     (require 'init-tool-bar)
     (require 'init-menu-bar)

     ;; (require 'init-bs)

     (require 'init-pyim)
     (require 'init-markdown)

     (require 'init-compile)
     (require 'init-lsp)
     (require 'init-elfeed)
     (require 'init-thing-edit)
     (require 'init-evil)
     (require 'init-latex)
     (require 'init-publish)
     (require 'init-shell)
     (require 'init-packages)
     
     (require 'init-yasnippet)
     (require 'init-company)

     (when *is-linux*
       (require 'init-linux))

     (require 'server)
     (unless (server-running-p)
       (server-start))))

  ;; local configs
  (let ((local-config "~/.emacs.d/config/init-local.el"))
    (when (file-exists-p local-config)
      (load-file local-config)))

  ;; load `custom-file' if exists
  ;; (when (file-exists-p custom-file)
  ;;   (load-file custom-file))
  )

;; init.el ends here
