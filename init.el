;;; init.el

(require 'server)
(unless (server-running-p)
  (server-start)
  (message "server 启动成功!"))

;; (require 'benchmark-init-modes)
;; (require 'benchmark-init)
;; (benchmark-init/activate)

;;@REF: https://github.com/lujun9972/emacs-document/blob/master/emacs-common/2个鲜为人知的提高Emacs启动速度的步骤.org
(run-with-idle-timer
 5 nil
 (lambda ()
   (load "~/.emacs.d/config/load-config.el")))

;; init.el ends here
