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
  (require 'setup-windows)
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
  ;; (setq auto-save-visited-interval 1)
  ;; (auto-save-visited-mode)
  (require 'init-alias)
  (unless *is-termux*
    (require 'init-proxy)
    (require 'init-rime))

  (require 'init-tab-line)
  (require 'init-modeline)
  (require 'init-fei)
  (require 'init-dired)
  (require 'init-ibuffer)
  (require 'init-engine)
  (with-eval-after-load 'webjump
    (require 'init-webjump))
  (require 'init-key)

  (when *is-windows*
    (require 'init-win10))
  (when *is-termux*
    (require 'init-termux))

  (run-with-idle-timer
   (if *is-windows* 3 1) nil
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
     (require 'init-evil)
     (require 'init-latex)
     (require 'init-shell)
     (require 'init-packages)

     (require 'init-yasnippet)
     (require 'init-company)

     (when *is-linux*
       (require 'init-linux))

     (require 'server)
     (unless (server-running-p)
       (server-start)
       (message "server 启动成功!"))

     (message "延时加载包加载完成！")
     ))

  ;; local configs
  (when (file-exists-p fei-local-config)
    (load-file fei-local-config))

  ;; load `custom-file' if exists
  ;; (when (file-exists-p custom-file)
  ;;   (load-file custom-file))
  )

;; init.el ends here
