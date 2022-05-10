;;; Linux 专用配置

(require 'init-eaf)

;; Fasd
(add-to-list 'load-path "~/.emacs.d/extensions/fasd")
(with-eval-after-load 'ivy
  ;; 因为 fasd 的原因，需要在 ivy 之后加载
  (require 'fasd)
  (setq fasd-add-file-to-db-when-eshell t)
  (global-fasd-mode t)
  (setq fasd-enable-initial-prompt nil)
  )

;; Telega
(add-to-list 'load-path "~/.emacs.d/extensions/telega")
(autoload 'telega "telega" nil t)
(setq telega-chat-fill-column 50
      telega-use-images t
      telega-open-file-function 'org-open-file
      telega-proxies '((:server "localhost" :port 1089 :enable t :type (:@type "proxyTypeSocks5"))))

;; Fcitx
(setq fcitx-active-evil-states '(insert emacs hybrid))
(fcitx-evil-turn-on)
(fcitx-aggressive-minibuffer-turn-on)
;; (fcitx-aggressive-setup)
;; (fcitx-prefix-keys-add "M-s")
;; (fcitx-prefix-keys-add "C-x")
;; (fcitx-prefix-keys-add "C-c")
;; (fcitx-prefix-keys-add "C-h")
;; (fcitx-prefix-keys-turn-on)
;; BUG: `fcitx-prefix-keys-turn-on' 会引入一个问题：在按住修饰键，鼠标点击 tab bar 会造成 emacs 崩溃

;; Sis
;; sis 和 emacsclient / deamon 的时候会出现退不出 emacs 的情况

;; 错误提示如下：
;; terminal-focus-reporting--apply-to-terminal: Device 1 is not a termcap terminal device

;; (setq sis-prefix-override-keys '("C-c" "C-x" "C-h" "M-s"))
;; (sis-ism-lazyman-config "1" "2" 'fcitx)
;; (sis-global-respect-mode 1)

(provide 'init-linux)
