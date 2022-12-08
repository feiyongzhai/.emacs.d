;; Telega
;; 相关链接：https://zevlg.github.io/telega.el/#windows-10-users

(add-to-list 'load-path "~/.emacs.d/extensions/telega")
(autoload 'telega "telega" nil t)
(setq telega-chat-fill-column 50
      telega-use-images t
      telega-open-file-function 'org-open-file
      telega-proxies '((:server "localhost" :port 1089 :enable t :type (:@type "proxyTypeSocks5"))))

(provide 'init-telega)