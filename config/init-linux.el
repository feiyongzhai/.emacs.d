;;; Linux 专用配置

;;; Telega
(setq telega-chat-fill-column 50
      telega-use-images t
      telega-open-file-function 'org-open-file
      telega-proxies '((:server "localhost" :port 1089 :enable t :type (:@type "proxyTypeSocks5"))))

;;; EAF is special
(when (display-graphic-p)
  (require 'init-eaf))
(add-hook 'server-after-make-frame-hook
	  (lambda () (when window-system (require 'init-eaf))))

(provide 'init-linux)
