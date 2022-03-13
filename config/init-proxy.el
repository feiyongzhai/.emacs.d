;;; init-proxy.el --- Proxy configure

(defun proxy-socks-show ()
  "Show SOCKS proxy."
  (interactive)
  (when (fboundp 'cadddr)
    (if (bound-and-true-p socks-noproxy)
        (message "Current SOCKS%d proxy is %s:%d"
                 (cadddr socks-server) (cadr socks-server) (caddr socks-server))
      (message "No SOCKS proxy"))))

(defun proxy-socks-enable ()
  "Enable SOCKS proxy."
  (interactive)
  (require 'socks)
  (setq url-gateway-method 'socks
        socks-noproxy '("localhost")
        socks-server '("Default server" "127.0.0.1" 1089 5))
  (setenv "all_proxy" "socks5://127.0.0.1:1089")
  ;; (setenv "http_proxy" "http://127.0.0.1:8889")
  (proxy-socks-show))

(defun proxy-socks-disable ()
  "Disable SOCKS proxy."
  (interactive)
  (require 'socks)
  (setq url-gateway-method 'native
        socks-noproxy nil)
  (setenv "all_proxy" "")
  (proxy-socks-show))

(defun proxy-socks-toggle ()
  "Toggle SOCKS proxy."
  (interactive)
  (require 'socks)
  (if (bound-and-true-p socks-noproxy)
      (proxy-socks-disable)
    (proxy-socks-enable)))

;; (proxy-socks-enable)

;; 从实际的使用经验来看，emacs使用 http 的方式代理能够适配更多的场景
;; 典型的场景：
;;	1. pip 在 eshell 中下载东西用 socks5 代理不行
;;	2. cargo 相同的问题

;; 2022-03-13: 呃…… 刚刚测试，又抽风可以使用了。搞不懂到底什么情况。

;; 现在就使用 http 代理的方式

;; copied from xuchunyang-emacs.d
(defun chunyang-toggle-url-proxy ()
  "Toggle proxy for the url.el library."
  (interactive)
  (cond
   (url-proxy-services
    (message "Turn off URL proxy")
    (setq url-proxy-services nil))
   (t
    (message "Turn on URL proxy")
    (setq url-proxy-services
          '(("http" . "localhost:8889")
            ("https" . "localhost:8889")
            ("no_proxy" . "0.0.0.0"))))))

(provide 'init-proxy)

;;; init-proxy.el ends here
