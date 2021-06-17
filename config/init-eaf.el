(defun fei-eaf-start ()
  (interactive)
  (use-package eaf
    :load-path "~/Sandbox/Emacs/emacs-application-framework"
    :init
    (use-package epc :defer t :ensure t)
    (use-package ctable :defer t :ensure t)
    (use-package deferred :defer t :ensure t)
    (use-package s :defer t :ensure t)
    :custom
    (eaf-browser-continue-where-left-off t)
    :config
    (eaf-setq eaf-browser-enable-adblocker "true")
    (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
    (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
    (eaf-bind-key take_photo "p" eaf-camera-keybinding)
    (eaf-bind-key nil "M-q" eaf-browser-keybinding)  ;; unbind, see more in the Wiki
    (setq eaf-proxy-type "socks5"
	  eaf-proxy-host "127.0.0.1"
	  eaf-proxy-port "1089")
    (setq eaf-browser-default-search-engine "duckduckgo"))
  (setq browse-url-browser-function '(("^http.*" . eaf-open-browser)
				      ("." . browse-url-default-browser)))
  (global-set-key (kbd "M-s M-w") 'eaf-search-it)
  (global-set-key (kbd "C-c e") 'eaf-open-this-buffer)
  (global-set-key (kbd "M-[") 'fei-eaf-file-share-current-dir))

(defun fei-eaf-file-share-current-dir ()
  (interactive)
  (eaf-file-browser-qrcode (substring (pwd) 10)))

(provide 'init-eaf)
