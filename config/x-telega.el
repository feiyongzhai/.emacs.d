;;;TODO: 安装遇到的相关问题和解决方法

;; 相关链接：https://zevlg.github.io/telega.el/#windows-10-users

;;; Code
(add-to-list 'load-path "~/.emacs.d/extensions/telega")
(autoload 'telega "telega" nil t)
(setq telega-chat-fill-column 50
      telega-use-images t
      telega-open-file-function 'org-open-file
      telega-proxies '((:server "localhost" :port 1089 :enable t :type (:@type "proxyTypeSocks5"))))

(provide 'x-telega)
