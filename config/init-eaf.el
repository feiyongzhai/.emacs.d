(load-path-add "~/.emacs.d/extensions/emacs-application-framework")

(require 'fei-funcs)

(require 'eaf)
(require 'eaf-browser)
(require 'eaf-pdf-viewer)
(require 'eaf-markdown-previewer)
(require 'eaf-video-player)
(require 'eaf-image-viewer)
(require 'eaf-org-previewer)
(require 'eaf-mindmap)
(require 'eaf-mail)
(require 'eaf-terminal)
(require 'eaf-camera)
(require 'eaf-jupyter)
;; (require 'eaf-netease-cloud-music)
(require 'eaf-music-player)
(require 'eaf-system-monitor)
(require 'eaf-file-manager)
(require 'eaf-file-browser)
(require 'eaf-demo)
(require 'eaf-vue-demo)
(require 'eaf-interleave)
(require 'eaf-rss-reader)
(require 'eaf-fei)

(load-path-add "~/.emacs.d/extensions/popweb/extension/dict/")
(load-path-add "~/.emacs.d/extensions/popweb/extension/latex/")
(load-path-add "~/.emacs.d/extensions/popweb/")
(require 'popweb-dict-bing)
(require 'popweb-dict-youdao)
(require 'popweb-latex)

(global-set-key (kbd "C-h u") 'popweb-dict-youdao-pointer)
(global-set-key (kbd "s-/") 'eaf-open-rss-reader)

(setq eaf-browser-default-zoom (if (> (frame-pixel-width) 3000) 2.3 1))
(setq eaf-browser-enable-adblocker t)
(setq eaf-browser-enable-autofill t)
(setq eaf-browser-enable-scrollbar t)
(setq eaf-music-play-order "random")
(setq eaf-marker-letters "JKHLNMUIOYPFDSAVCRREW")
(setq eaf-file-manager-show-hidden-file nil)
(setq eaf-rss-reader-web-page-other-window nil)
(setq confirm-kill-processes nil)	; 退出不需要确认杀死进程

;;; Keys
(fei-define-key-with-map global-map
  '(
    ("C-c e" . eaf-open-this-buffer)
    ;; 终端用命令 `emacsclient -t file-name` 的时候，总是会响应快捷键
    ;; `ESC [ I` 这一组按键序列（这个可以通过 C-h l 来查看），这就导致
    ;; 启动的时候会自动调用下面的命令 `fei-eaf-file-share-current-dir`，
    ;; 很烦人，也暂时不知道怎么解决这个问题，只能先不把 `M-[` 快捷键绑
    ;; 定到命令上
    ;; 
    ;; ("M-[" . fei-eaf-file-share-current-dir)
    ("M-]" . fei-eaf-file-share-current-dir)
    ("C-x j" . eaf-open-in-file-manager)
    ("M-s s" . eaf-open-browser-with-history)
    ))

(with-eval-after-load 'eaf
  (eaf-bind-key eaf-interleave-sync-next-note "M-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-sync-previous-note "M-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-open-notes-file "n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-add-note "a" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-sync-current-note "s" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-open-external "w" eaf-pdf-viewer-keybinding)

  (eaf-bind-key eaf-open-terminal "S" eaf-file-manager-keybinding)
  (eaf-bind-key js_mark_article_as_read "b" eaf-rss-reader-keybinding)

  (fei-define-key-with-map eaf-interleave-mode-map
    '(("M-n" . eaf-interleave-sync-next-note)
      ("M-p" . eaf-interleave-sync-previous-note))
    ))

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

(unless *is-windows*
  (setq browse-url-browser-function '(("^http.*" . fei-eaf-open-browser)
				      ("." . browse-url-default-browser))))

;;; Funcs

(with-eval-after-load 'eaf
  (defun eaf-translate-text (text)
    (popweb-dict-bing-input text))

  (defun eaf-goto-left-tab ()
    (interactive)
    (call-interactively 'tab-line-switch-to-prev-tab))

  (defun eaf-goto-right-tab ()
    (interactive)
    (call-interactively 'tab-line-switch-to-next-tab))
  )

(provide 'init-eaf)
