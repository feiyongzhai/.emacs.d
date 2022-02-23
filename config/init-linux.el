;;; Linux 专用配置

;; apt-utils
(require 'apt-utils)

;; Fasd
(add-to-list 'load-path "~/.emacs.d/extensions/fasd")
(with-eval-after-load 'ivy
  ;; 因为 fasd 的原因，需要在 ivy 之后加载
  (require 'fasd)
  (setq fasd-add-file-to-db-when-eshell t)
  (global-fasd-mode t)
  (setq fasd-enable-initial-prompt nil)
  (global-set-key (kbd "C-c f") 'fasd-find-file))

;; Telega
(setq telega-chat-fill-column 50
      telega-use-images t
      telega-open-file-function 'org-open-file
      telega-proxies '((:server "localhost" :port 1089 :enable t :type (:@type "proxyTypeSocks5"))))

;; EAF is special
(when (display-graphic-p)
  (require 'init-eaf))
(add-hook 'server-after-make-frame-hook
	  (lambda () (when window-system (require 'init-eaf))))

(provide 'init-linux)
