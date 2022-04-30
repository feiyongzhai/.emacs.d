(require 'init-func)
(require 'fei-funcs)

;; ==== Popweb ====
(add-to-list 'load-path "~/.emacs.d/extensions/popweb/extension/dict/")
(add-to-list 'load-path "~/.emacs.d/extensions/popweb/extension/latex/")
(add-to-list 'load-path "~/.emacs.d/extensions/popweb/")
(require 'popweb-dict-bing)
(require 'popweb-dict-youdao)
(require 'popweb-latex)

;; ==== EAF ====
(add-to-list 'load-path "~/.emacs.d/extensions/emacs-application-framework")
(require 'eaf)
(require 'eaf-browser)
(require 'eaf-pdf-viewer)
(require 'eaf-markdown-previewer)
(require 'eaf-video-player)
(require 'eaf-image-viewer)
(require 'eaf-org-previewer)
(require 'eaf-music-player)
(require 'eaf-file-browser)
(require 'eaf-demo)
(require 'eaf-vue-demo)
;; (require 'eaf-fei)


;;; Vars

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

(unless *is-windows*
  ;;XXX: `browse-url-browser-function' 在 emacs-28 已经过时
  ;; (setq browse-url-browser-function '(("^http.*" . fei-eaf-browse-url)
  ;; 				      ("." . browse-url-default-browser)))
  ;; (setq browse-url-handlers '(("^http.*" . fei-eaf-browse-url)
  ;; 			      ("." . browse-url-default-browser)))
  )

;;; Keys
(global-set-key (kbd "C-h u") 'popweb-dict-youdao-pointer)
(global-set-key (kbd "C-c e") 'eaf-open-this-buffer)
;; 终端用命令 `emacsclient -t file-name` 时，会响应这一组 `ESC [ I`按
;; 键序列（可通过 C-h l 查看），导致启动的时候会自动调用下面的命令
;; `fei-eaf-file-share-current-dir`
;; (global-set-key (kbd "M-[") 'fei-eaf-file-share-current-dir)

(with-eval-after-load 'eaf
  (tooltip-mode -1)
  (define-key eaf-pdf-outline-mode-map (kbd "q") 'quit-window)
  ;; 有个需要注意的点是，如果是 eaf-py-proxy- 开头的命令，要去掉 eaf-py-proxy- 这个前缀
  (eaf-bind-key add_annot_highlight "M-q" eaf-pdf-viewer-keybinding) ;这个按键单纯因为好按
  (eaf-bind-key fei-meow-last-buffer "q" eaf-pdf-viewer-keybinding)
  (eaf-bind-key add_annot_squiggly "M-S" eaf-pdf-viewer-keybinding)
  (eaf-bind-key add_annot_squiggly "s" eaf-pdf-viewer-keybinding)
  (eaf-bind-key add_annot_underline "a" eaf-pdf-viewer-keybinding)
  (eaf-bind-key fei-eaf-open-pdf-external "e" eaf-pdf-viewer-keybinding)
  (eaf-bind-key file-manager-here "1" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down_page "<backspace>" eaf-pdf-viewer-keybinding)
  (eaf-bind-key youdao-dictionary-search-from-input "<return>" eaf-pdf-viewer-keybinding)
  (eaf-bind-key fei-eaf-open-pdf-external "C-c e" eaf-pdf-viewer-keybinding)
  (eaf-bind-key fei-search "v" eaf-pdf-viewer-keybinding)
  (eaf-bind-key fei-search-1 "V" eaf-pdf-viewer-keybinding)
  (eaf-bind-key youdao-dictionary-search-from-input "y" eaf-pdf-viewer-keybinding)
  (eaf-bind-key counsel-imenu "C-c i" eaf-pdf-viewer-keybinding)
  (eaf-bind-key nil "M-s" eaf-pdf-viewer-keybinding)
  
  (define-key eaf-mode-map* (kbd "C-c B") #'eaf-open-bookmark)
  (define-key eaf-mode-map* (kbd "C-c b") #'list-bookmarks)
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
    (call-interactively 'tab-line-switch-to-next-tab))
  )

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

(global-set-key (kbd "M-s e b") 'fei-eaf-open-browser-with-history)
(global-set-key (kbd "M-s e B") 'fei-eaf-open-browser)
(global-set-key (kbd "M-s e s") 'fei-eaf-file-share-current-dir)
(global-set-key (kbd "M-s e u") 'fei-eaf-open-url-at-point)
(global-set-key (kbd "M-s e m") 'fei-eaf-play-music)

;; == eaf-music-player ==
(setq eaf-music-extension-list '("mp3" "m4a"))

;; == eaf-pdf-viewer ==
;; 如果不添加下面这行配置，pdf总是是暗色的，这是一个 bug, 在 eaf-pdf-viewer
;; 最近的一次更新 cabb7696f95a9f334c97e350fee46d7420eee93e 已经修复了。
;; 不过更新测试发现还是存在不符合我预期的行为，暂时不更新
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

;; 或许我可以给 EAF 来个 PR，不过不着急，先测试一段时间

;; 下面 patch 的功能：
;;	1. 支持 consult-buffer 打开 pdf 是用 eaf-pdf-viewer 打开 （起因）
;;	2. 可以简化 eaf.el 中代码
;;	3. 可以使 dired 中行为与 emacs 的设计保持一致。
;;	现在 eaf.el 的逻辑是：如果有 mark 的文件，会一次性打开所有的文件。但通过我的测试发现
;;	emacs 中 dired-find-alternate-file/dired-find-file 的默认行为不是一次性打开所有 mark 的文件，
;;	而是只打开光标所在的文件。而我的这个 patch 则保证着同样的行为。更合理。

;; 下面 patch 已知的问题：
;;	1. 在 dired buffer 中按 o(dired-find-file-other-window) 工作不按照预期
(defun fei-eaf--find-file-noselect-advisor (orig-fn file &rest args)
  "Advisor of `find-file' that opens EAF supported file using EAF.

It currently identifies PDF, videos, images, and mindmap file extensions."
  (let ((fn (if (commandp 'eaf-open)
                #'(lambda (file)
                    (eaf-open file)
		    (buffer-name))
              orig-fn))
        (ext (file-name-extension file)))
    (if (and (not (eq major-mode 'telega-chat-mode)) ; 处理 telega 打开图片的问题
	     (eaf--find-file-ext-p ext))
        (apply fn file nil)
      (apply orig-fn file args))))
(advice-add #'find-file-noselect :around #'fei-eaf--find-file-noselect-advisor)

(advice-remove 'find-file 'eaf--find-file-advisor)
(advice-remove 'dired-find-file 'eaf--dired-find-file-advisor)
(advice-remove 'dired-find-alternate-file 'eaf--dired-find-file-advisor)

;; Default behavior of eaf
;; (advice-remove #'find-file-noselect #'fei-eaf--find-file-noselect-advisor)
;; (advice-add 'dired-find-file :around 'eaf--dired-find-file-advisor)
;; (advice-add 'dired-find-alternate-file :around 'eaf--dired-find-file-advisor)
;; (advice-add 'find-file :around 'eaf--find-file-advisor)

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

(provide 'init-eaf)
