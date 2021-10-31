;;; Linux 专用配置

;;; {{ telega
(setq telega-chat-fill-column 50
      telega-use-images t
      telega-open-file-function 'org-open-file
      telega-proxies '((:server "localhost" :port 1089 :enable t :type (:@type "proxyTypeSocks5"))))
;;; }} telega

;; {{ citre
(global-set-key (kbd "C-c j") 'citre-jump)
(global-set-key (kbd "C-c J") 'citre-jump-back)
(global-set-key (kbd "C-c p") 'citre-ace-peek)
;; }} citre

(provide 'init-linux)
