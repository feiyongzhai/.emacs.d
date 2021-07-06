(autoload 'eaf-open-browser "eaf" nil t)
(autoload 'eaf--bookmark-restore "eaf" nil t)

;;; Keys

(fei-define-key-with-map global-map
  '(("M-s M-w" . eaf-open-browser-with-history)
    ("s-b" . eaf-open-browser-with-history)
    ("C-c e" . eaf-open-this-buffer)
    ("M-[" . fei-eaf-file-share-current-dir))
  "eaf")

(with-eval-after-load 'eaf
  (eaf-bind-key eaf-interleave-sync-next-note "M-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-sync-previous-note "M-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-open-notes-file "n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-add-note "a" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-sync-current-note "s" eaf-pdf-viewer-keybinding)

  (fei-define-key-with-map eaf-interleave-mode-map
    '(("M-n" . eaf-interleave-sync-next-note)
      ("M-p" . eaf-interleave-sync-previous-note)))
  )

;;; Vars

(with-eval-after-load 'eaf
  (eaf-setq eaf-browser-enable-adblocker "true")
  (eaf-setq eaf-terminal-font-family "Hack")
  (eaf-setq eaf-terminal-font-size "16")
  (eaf-setq eaf-browser-enable-adblocker "true"))

(setq eaf-browser-continue-where-left-off t)

(setq eaf-proxy-type "socks5"
      eaf-proxy-host "127.0.0.1"
      eaf-proxy-port "1089")

(setq browse-url-browser-function '(("^http.*" . eaf-open-browser)
				    ("." . browse-url-default-browser)))

(setq confirm-kill-processes nil)	; 退出不需要确认杀死进程

;;; Funcs

(defun fei-eaf-start ()
  (interactive)
  (use-package eaf
    :load-path "~/Sandbox/Emacs/emacs-application-framework"
    :init
    (use-package epc :defer t :ensure t)
    (use-package ctable :defer t :ensure t)
    (use-package deferred :defer t :ensure t)
    (use-package s :defer t :ensure t)))

(defun fei-eaf-file-share-current-dir ()
  (interactive)
  (require 'eaf)
  (eaf-file-browser-qrcode (substring (pwd) 10)))

(provide 'init-eaf)
