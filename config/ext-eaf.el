;;; TODO: 安装遇到的相关问题和解决方法

;; Code
(require 'fei-funcs)

(add-to-list 'load-path "~/Repos/eaf")
(setq eaf-python-command "/usr/bin/python3") ;有时会用别的 python 环境，指定更稳定

(require 'eaf)
(require 'eaf-browser)
(require 'eaf-pdf-viewer)
;; (require 'eaf-org)
;; (require 'eaf-image-viewer)
;; (require 'eaf-video-player)
;; (require 'eaf-music-player)
;; (require 'eaf-file-sender)
;; (require 'eaf-file-browser)
;; (require 'eaf-demo)
;; (require 'eaf-vue-demo)

;;; Vars
(setq eaf-org-override-pdf-links-store t)
(setq eaf-browser-continue-where-left-off t)
(setq eaf-browser-default-zoom (if (> (frame-pixel-width) 3000) 2.3 1))
(setq eaf-browser-enable-adblocker t)
(setq eaf-browser-enable-autofill t)
(setq eaf-browser-enable-scrollbar t)
(setq eaf-music-play-order "random")
(setq eaf-marker-letters "JKHLNMUIOYPFDSAVCRREW")
(setq confirm-kill-processes nil)	; 退出不需要确认杀死进程

(setq eaf-proxy-type "socks5"
      eaf-proxy-host "127.0.0.1"
      eaf-proxy-port "1089")

;; `browse-url-browser-function' 在 emacs-28 已经过时
;; (setq browse-url-browser-function '(("^http.*" . fei-eaf-browse-url)
;; 				      ("." . browse-url-default-browser)))
;; (setq browse-url-handlers '(("^http.*" . fei-eaf-browse-url)
;; 			      ("." . browse-url-default-browser)))

;;; Keys
(with-eval-after-load 'eaf-browser
  (eaf-bind-key nil "C-e" eaf-browser-keybinding)
  (eaf-bind-key nil "M-S" eaf-browser-keybinding)
  )

;; 终端用命令 `emacsclient -t file-name` 时，会响应这一组 `ESC [ I`按
;; 键序列（可通过 C-h l 查看），导致启动的时候会自动调用下面的命令
;; `fei-eaf-file-share-current-dir`
;; (global-set-key (kbd "M-[") 'fei-eaf-file-share-current-dir)

(with-eval-after-load 'eaf
  (tooltip-mode -1)
  (define-key eaf-pdf-outline-mode-map (kbd "q") 'quit-window)
  ;; 有个需要注意的点是，如果是 eaf-py-proxy- 开头的命令，要去掉 eaf-py-proxy- 这个前缀
  (eaf-bind-key add_annot_highlight "M-q" eaf-pdf-viewer-keybinding) ;这个按键单纯因为好按
  (eaf-bind-key mode-line-other-buffer "q" eaf-pdf-viewer-keybinding)
  (eaf-bind-key add_annot_squiggly "M-S" eaf-pdf-viewer-keybinding)
  (eaf-bind-key add_annot_squiggly "s" eaf-pdf-viewer-keybinding)
  (eaf-bind-key add_annot_underline "a" eaf-pdf-viewer-keybinding)
  (eaf-bind-key fei-eaf-open-pdf-external "e" eaf-pdf-viewer-keybinding)
  (eaf-bind-key file-manager-here "1" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down_page "<backspace>" eaf-pdf-viewer-keybinding)
  (eaf-bind-key google-translate-query-translate "<return>" eaf-pdf-viewer-keybinding)
  (eaf-bind-key fei-eaf-open-pdf-external "C-c e" eaf-pdf-viewer-keybinding)
  (eaf-bind-key fei-search "v" eaf-pdf-viewer-keybinding)
  (eaf-bind-key fei-search-1 "V" eaf-pdf-viewer-keybinding)
  (eaf-bind-key search-kill "C-y" eaf-pdf-viewer-keybinding)
  (eaf-bind-key google-translate-query-translate "y" eaf-pdf-viewer-keybinding)
  (eaf-bind-key counsel-imenu "C-c i" eaf-pdf-viewer-keybinding)
  (eaf-bind-key nil "C-e" eaf-pdf-viewer-keybinding)

  (define-key eaf-mode-map* (kbd "C-c B") #'eaf-open-bookmark)
  ;; (define-key eaf-mode-map* (kbd "C-c b") #'helm-chrome-history)
  )

;;; Funcs

(with-eval-after-load 'eaf
  (defun eaf-translate-text (text)
    (popweb-dict-bing-input text))

  (defun eaf-goto-left-tab ()
    (interactive)
    (call-interactively 'tab-line-switch-to-prev-tab))

  (defun eaf-goto-right-tab ()
    (interactive)
    (call-interactively 'tab-line-switch-to-next-tab)))

(defmacro fei-eaf-wrapper (sym)
  "给 EAF 相关的命令添加一个 wrapper ，避免在终端下不小心调用到出现问题"
  `(defun ,(intern (format "fei-%s" (symbol-name sym))) ()
     (interactive)
     (if (display-graphic-p)
	 (call-interactively ',(intern (symbol-name sym)))
       (message "EAF doesn't support in terminal"))))

(fei-eaf-wrapper eaf-open-browser)
(fei-eaf-wrapper eaf-open-browser-with-history)
(fei-eaf-wrapper eaf-open-url-at-point)

(global-set-key (kbd "C-c e b") 'fei-eaf-open-browser-with-history)
(global-set-key (kbd "C-c e B") 'fei-eaf-open-browser)
(global-set-key (kbd "C-c e s") 'fei-eaf-file-share-current-dir)
(global-set-key (kbd "C-c e u") 'fei-eaf-open-url-at-point)
(global-set-key (kbd "C-c e m") 'fei-eaf-play-music)

;; == eaf-music-player ==
(setq eaf-music-extension-list '("mp3" "m4a"))

;; == eaf-pdf-viewer ==
(setq eaf-pdf-dark-mode "ignore")

(define-key eaf-mode-map* (kbd "C-x C-j") 'eaf-dired-jump)
(defun eaf-dired-jump ()
  "目前只对 EAF 的 pdf浏览器 和 图片浏览器有作用"
  (interactive)
  (if (eq major-mode 'eaf-mode)
      (let ((file (concat default-directory (buffer-name))))
	(dired-jump)
	(dired-goto-file file))
    (message "You are not in EAF buffer!")))

(defun fei-eaf-open-pdf-external ()
  (interactive)
  (when (and (eq major-mode 'eaf-mode)
	     (string= eaf--buffer-app-name "pdf-viewer"))
    (start-process "evince" nil
		   "evince" "-i" (cadr mode-line-position) (buffer-name))))

(defun fei-eaf-browse-url (url &optional _new-window)
  "根据 `browse-url-chromium' 这个函数改的 这个函数诞生是为了让终端下也可以用 eaf"
  (interactive (browse-url-interactive-arg "URL: "))
  (setq url (browse-url-encode-url url))
  (if (and (display-graphic-p)
	   (or (eq major-mode 'eshell-mode)
	       (eq major-mode 'shell-mode)
	       (getenv "TERM")))
      (eaf-open-browser url _new-window)
    (browse-url-default-browser url _new-window)))

(defun fei-eaf-file-share-current-dir ()
  (interactive)
  (if (display-graphic-p)
      (eaf-file-browser-qrcode (substring (pwd) 10))
    (message "EAF doesn't support in terminal")))

(defun fei-eaf-play-music ()
  (interactive)
  (if (display-graphic-p)
      (eaf-open "/run/media/yongfeizhai/文档/音乐/" "music-player")
    (message "EAF doesn't support in terminal")))

(defun search-kill ()
  (interactive)
  (fei-google-search (car kill-ring)))

(provide 'ext-eaf)
