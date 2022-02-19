(require 'fei-funcs)

(load-path-add "~/.emacs.d/extensions/emacs-application-framework")
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
;; (require 'eaf-camera)
;; (require 'eaf-jupyter)
;; (require 'eaf-netease-cloud-music)
(require 'eaf-music-player)
(require 'eaf-system-monitor)
(require 'eaf-file-manager)
(require 'eaf-file-browser)
(require 'eaf-interleave)
(require 'eaf-rss-reader)
(require 'eaf-demo)
(require 'eaf-vue-demo)
(require 'eaf-fei)

;;; Keys
(global-set-key (kbd "C-h u") 'popweb-dict-youdao-pointer)

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
    ("M-s s" . eaf-open-browser-with-history)
    ))

(with-eval-after-load 'eaf
  (eaf-bind-key eaf-interleave-sync-next-note "M-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-sync-previous-note "M-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-open-notes-file "n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-add-note "a" eaf-pdf-viewer-keybinding)
  (eaf-bind-key eaf-interleave-sync-current-note "s" eaf-pdf-viewer-keybinding)

  (eaf-bind-key eaf-open-terminal "S" eaf-file-manager-keybinding)
  (eaf-bind-key js_mark_article_as_read "b" eaf-rss-reader-keybinding)

  (fei-define-key-with-map eaf-interleave-mode-map
    '(("M-n" . eaf-interleave-sync-next-note)
      ("M-p" . eaf-interleave-sync-previous-note))
    )

  (define-key eaf-mode-map* (kbd "C-c B") #'eaf-open-bookmark)
  (define-key eaf-mode-map* (kbd "C-c b") #'list-bookmarks)
  )

;;; Vars

(setq eaf-browser-continue-where-left-off t)
(setq eaf-browser-default-zoom (if (> (frame-pixel-width) 3000) 2.3 1))
(setq eaf-browser-enable-adblocker t)
(setq eaf-browser-enable-autofill t)
(setq eaf-browser-enable-scrollbar t)
(setq eaf-music-play-order "random")
(setq eaf-marker-letters "JKHLNMUIOYPFDSAVCRREW")
(setq eaf-file-manager-show-hidden-file nil)
(setq eaf-rss-reader-web-page-other-window nil)
(setq confirm-kill-processes nil)	; 退出不需要确认杀死进程

(with-eval-after-load 'eaf
  (eaf-setq eaf-browser-enable-adblocker "true")
  (eaf-setq eaf-terminal-font-family "Hack")
  (eaf-setq eaf-terminal-font-size "20")
  (eaf-setq eaf-browser-enable-adblocker "true"))

(setq eaf-proxy-type "socks5"
      eaf-proxy-host "127.0.0.1"
      eaf-proxy-port "1089")

(unless *is-windows*
  (setq browse-url-browser-function '(("^http.*" . fei-eaf-browse-url)
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

(global-set-key (kbd "M-s e b") 'fei-eaf-open-browser-with-history)
(global-set-key (kbd "M-s e B") 'fei-eaf-open-browser)
(global-set-key (kbd "M-s e r") 'fei-eaf-open-rss-reader)
(global-set-key (kbd "M-s e f") 'fei-eaf-open-in-file-manager)
(global-set-key (kbd "M-s e s") 'fei-eaf-file-share-current-dir)
(global-set-key (kbd "M-s e t") 'fei-eaf-open-terminal)
(global-set-key (kbd "M-s e u") 'fei-eaf-open-url-at-point)
(global-set-key (kbd "M-s e m") 'fei-eaf-play-music)

(defmacro fei-eaf-wrapper (sym)
  "给 EAF 相关的命令添加一个 wrapper ，避免在终端下不小心调用到出现问题"
  `(defun ,(intern (format "fei-%s" (symbol-name sym))) ()
       (interactive)
     (if (display-graphic-p)
	 (call-interactively ',(intern (symbol-name sym)))
       (message "EAF doesn't support in terminal"))))

(fei-eaf-wrapper eaf-open-in-file-manager)
(fei-eaf-wrapper eaf-open-browser)
(fei-eaf-wrapper eaf-open-browser-with-history)
(fei-eaf-wrapper eaf-open-rss-reader)
(fei-eaf-wrapper eaf-open-terminal)
(fei-eaf-wrapper eaf-open-url-at-point)

;; ==== Popweb ====

(load-path-add "~/.emacs.d/extensions/popweb/extension/dict/")
(load-path-add "~/.emacs.d/extensions/popweb/extension/latex/")
(load-path-add "~/.emacs.d/extensions/popweb/")
(require 'popweb-dict-bing)
(require 'popweb-dict-youdao)
(require 'popweb-latex)


(provide 'init-eaf)
