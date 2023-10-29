;;; init.el

;;; 启用 server, 方便 emacsclient 调用
(require 'server)
(unless (server-running-p)
  (server-start)
  (message "server 启动成功!"))

;; (require 'benchmark-init-modes)
;; (require 'benchmark-init)
;; (benchmark-init/activate)

(setq make-backup-files nil)            ;不生成 file-name~ 文件

;;; 预先加载的很小一部分配置
(when *is-windows*
  ;; windows 平台下，输入法状态和窗口有绑定关系，需要抢一下窗口焦点。
  ;; 保证输入法状态被准确放到 emacs 的窗口上。
  (raise-frame)
  (w32-set-ime-open-status nil)
  (message "输入法切换成英文模式"))
(global-set-key (kbd "C-x l") #'load-my-config-manually)
(global-set-key (kbd "C-x j") #'open-inbox-md)
(global-set-key (kbd "C-\\") #'fei/toggle-input-method)

(defun fei/toggle-input-method ()
  (interactive)
  (require 'ext-rime)
  (call-interactively 'toggle-input-method))

(defun open-inbox-md ()
  (interactive)
  (require 'ext-rime)
  (require 'ext-yasnippet)
  (find-file "~/Nutstore Files/org/private/inbox.md"))

(defvar has-load-config nil)

(defun load-my-config ()
  (interactive)
  (or has-load-config
      (load "~/.emacs.d/config/load-config.el")))

(defun load-my-config-manually ()
  (interactive)
  (setq has-load-config t)
  (load "~/.emacs.d/config/load-config.el"))

;;; 延时加载重量级配置
;;@REF: https://github.com/lujun9972/emacs-document/blob/master/emacs-common/2个鲜为人知的提高Emacs启动速度的步骤.org
;; (run-with-idle-timer 5 nil 'load-my-config)
(when *is-linux* (load-my-config))
;; init.el ends here
