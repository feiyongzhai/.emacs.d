;;; Linux 专用配置

;;; {{ telega
(setq telega-chat-fill-column 50
      telega-use-images t
      telega-open-file-function 'org-open-file
      telega-proxies '((:server "localhost" :port 1089 :enable t :type (:@type "proxyTypeSocks5"))))
;;; }} telega

(provide 'init-linux)
