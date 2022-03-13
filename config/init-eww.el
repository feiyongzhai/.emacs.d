;; Commentary:

;; 如果没有下面的代码，eww 不能访问 wikipedia，根据参考链接的说明，这
;; 似乎是一个大坑，暂时不想踩，先用起来。不过看起来像是在解决代理问题。

;; ==== 方法1 ====

;; @REF: https://emacstalk.github.io/post/007/

;; (setq socks-proxy "socks5h://127.0.0.1:1089")

;; (use-package mb-url
;;   :ensure t
;;   :defer t
;;   :commands (mb-url-http-around-advice)
;;   :init
;;   (setq mb-url-http-backend 'mb-url-http-curl
;; 	mb-url-http-curl-switches `("--max-time" "20" "-x" ,socks-proxy))
;; 
;;   (advice-add 'url-http :around 'mb-url-http-around-advice))

;; ==== 方法2：这个方法更轻量化 ====

;; 问题定位是 https 的问题，socks5 只能对 http 生效不能对 https 生效，
;; 具体原因我也不知道。xuchunyang （方法2的提供者）是这么说的。不过链
;; 接中说 socks 的设置（在我这里对应的是 init-proxy.el）和下面的设置无
;; 法共存，我暂时没发现这个问题，共存也可以正常使用。继续观望中。。。

;; @REF: https://emacs-china.org/t/topic/2808/56?u=yongfeizhai
(setq url-proxy-services
      '(("https" . "localhost:8889")
	("http" . "localhost:8889")
        ("no_proxy" . "0.0.0.0")
	))


(provide 'init-eww)
