;;; windows 平台专属
(require 'fei-funcs)

;;; Openwith
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "start" (file))
                              ("\\.doc\\'" "start" (file))
                              ("\\.docx\\'" "start" (file))))

;; font
(defun fei-setup-win-emoji ()
  (set-fontset-font "fontset-default" 'unicode '("微软雅黑"))
  ;; @REF: https://ianyepan.github.io/posts/emacs-emojis/
  (when (member "Segoe UI Emoji" (font-family-list))
    (set-fontset-font t 'emoji (font-spec :family "Segoe UI Emoji"))))

(fei-setup-win-emoji)
;; 都是 windows 自带的字体
(set-fontset-font t '(#x22000 . #x22fff) (font-spec :family "SimSun-ExtB")) ;中日韩统一表意文字扩展区B
(set-fontset-font t '(#x13000 . #x1342F) (font-spec :family "Segoe UI Historic")) ;圣书体


(setenv "EDITOR" "emacsclientw -c")

(w32-set-ime-open-status nil)
(defvar first-make-frame-flag nil
  "标志信号，保证只在第一次进行修改")

(setq w32-lwindow-modifier 'super)
(setq w32-pass-lwindow-to-system t)
(setq w32-apps-modifier 'super)

;; 控制启动窗口的大小
(add-hook 'server-after-make-frame-hook
	  (lambda ()
	    ;; @REF: http://kimi.im/2019-02-09-emacs-frame-dimention
	    (unless first-make-frame-flag
	      (w32-set-ime-open-status nil)
	      (setq first-make-frame-flag 1))

	    (fei-setup-win-emoji)

	    ;; (set-frame-height nil (/ (* 4 (x-display-pixel-height))
	    ;; 			     (* 5 (frame-char-height))))
	    ;; (set-frame-width nil (/ (* 4 (x-display-pixel-width))
	    ;; 			    (* 5 (frame-char-width))))
	    ))

;; ;;; I do not why, but `w32-register-hot-key' must after `w32-lwindow-modifier' setting
;; (dolist (keys '([s-0] [s-1] [s-2] [s-3]
;; 		[s-s] [s-u] [s-e]
;; 		[s-return] [M-escape]))
;;   (w32-register-hot-key keys))

;; (tool-bar-add-item "show" 'file-manager-here 'file-manager-here :help "file-manager-here")

;;; @DOWNLOAD: https://www.voidtools.com/zh-cn/downloads/
(setq locate-command "es.exe")

(setq browse-url-handlers '(("." . browse-url-default-browser)))

;;; Funcs
(defun wt()
  "Open an external Windows cmd in the current directory"
  (interactive)
  (call-process-shell-command "start wt"))

(defun open-current-file-with-notepad ()
  (interactive)
  (start-process "notepad" nil "notepad.exe"
		 (or (buffer-file-name)
		     default-directory)))

(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    ;; (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))
;; (arrange-frame 84 30 170 20)

;; 输入法自动切换插件，sis 在 linux 下使用有点问题。windows 下好像还不错。
;; (sis-ism-lazyman-config nil t 'w32)
;; (sis-global-respect-mode)

;; (add-hook 'org-capture-mode-hook #'sis-set-other)
;; (add-hook 'log-edit-mode-hook #'sis-set-other)

;; zoxide
;; @REF: https://emacs-china.org/t/emacs-helm-ag/6764
;; 使用以下配置之后 eshell 中的 zoxide 命令可以正常工作
;; 测试
(modify-coding-system-alist 'process "zoxide" '(utf-8 . chinese-gbk-dos))

;; 参考上面，解决 windows counsel-rg 乱码的问题
(modify-coding-system-alist 'process "rg" '(utf-8 . chinese-gbk-dos))

;; Eshell
(defun eshell/d () (eshell/cd "d:/"))
(defun eshell/c () (eshell/cd "c:/"))


(with-eval-after-load 'counsel
  (defun counsel-git (&optional initial-input)
    "魔改的 counsel-git 原始版本，解决编码问题
Find file in the current Git repository.
INITIAL-INPUT can be given as the initial minibuffer input."
    (interactive)
    (counsel-require-program counsel-git-cmd)
    (let ((default-directory (counsel-locate-git-root)))
      (ivy-read "Find file: " (mapcar (lambda (str) (decode-coding-string str 'utf-8)) (counsel-git-cands default-directory)) ;魔改部分
		:initial-input initial-input
		:action #'counsel-git-action
		:history 'counsel-git-history
		:caller 'counsel-git))))

(provide 'init-win10)
