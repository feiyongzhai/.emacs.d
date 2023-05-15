;;; init.el

;;; 启用 server, 方便 emacsclient 调用
(require 'server)
(unless (server-running-p)
  (server-start)
  (message "server 启动成功!"))

;; (require 'benchmark-init-modes)
;; (require 'benchmark-init)
;; (benchmark-init/activate)

;;; 预先加载的很小一部分配置
(global-set-key (kbd "C-x l") #'load-my-config)
(global-set-key (kbd "C-x j") #'open-inbox-md)

(defun open-inbox-md ()
  (interactive)
  (require 'init-rime)
  (require 'init-yasnippet)
  (find-file "~/Nutstore Files/org/private/inbox.md"))

(defun load-my-config ()
  (interactive)
  (load "~/.emacs.d/config/load-config.el"))

;;; 延时加载重量级配置
;;@REF: https://github.com/lujun9972/emacs-document/blob/master/emacs-common/2个鲜为人知的提高Emacs启动速度的步骤.org
(run-with-idle-timer 5 nil 'load-my-config)

;; init.el ends here
