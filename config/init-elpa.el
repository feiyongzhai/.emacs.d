;;; init-elpa.el --- configs for package

;; (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;;; emacs-china mirrors
;; (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;; 			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))
;;; USTC mirrors
(setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
			 ("nongnu" . "http://mirrors.ustc.edu.cn/elpa/nongnu/")
                         ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
                         ;; ("melpa-stable" . "http://mirrors.ustc.edu.cn/elpa/melpa-stable/")
                         ;; ("org" . "http://mirrors.ustc.edu.cn/elpa/org/")
			 ))

;; (package-initialize)

(defvar fei-package-ensure-installed nil
  "List of package names to install ,if missing.")

(defun fei-package-install-ensured ()
  "Install all `fei-package-ensure-installed' packages,if needed."
  (interactive)
  (package-refresh-contents)
  (mapcar (lambda (pck)
	    (unless (package-installed-p pck)
	      (package-install pck)))
	  fei-package-ensure-installed)
  (message "ensured package installed successfully!"))

;;; linux 专属
(setq fei-package-ensure-installed-linux
      '(
	bash-completion tmr exec-path-from-shell
	graphviz-dot-mode lsp-dart flutter
	;; citre vterm vterm-toggle sx magit fcitx
	))

;;; general needed packages
(setq fei-package-ensure-installed
      '(
	;; ==== Misc ====
	macrostep git-commit benchmark-init terminal-here

	helpful openwith
        imenu-list rg websocket
	interaction-log		 ;这个包需要自己 require，不会自动加载

	;; ==== 功能包 ====
	pyim pyim-basedict    ; 内置输入法
	trashed               ; 回收站管理
	keycast               ; 键盘回显
	alarm-clock           ; 定时器、闹钟
	pdf-tools             ; 增强 docview
	dashboard             ; 快速启动页面
	olivetti              ; 内容居中
	ace-window            ; 增强 other-window
	dirvish               ; dired 增强
	cal-china-x           ; 日历汉化
	vundo                 ; 可视化 undo
	hackernews            ; hackernews 客户端
	hnreader              ; hackernews 客户端2
	use-package           ; 包管理器
	general               ; 按键配置器
	elfeed                ; rss 客户端
	rubik                 ; 魔方游戏
	boxes                 ; ascii art
	figlet                ; ascii art2
	sl                    ; 小火车
	google-translate      ; 谷歌词典
	;; youdao-dictionary     ; 有道词典 插件使用的 api 已经过时
	evil                  ; vim 模拟
	consult-dir           ; interactive style `fasd` or `autojump`
        tldr                  ; 这个命令怎么用？

	;; ==== Minibuffer ====
	orderless vertico embark consult embark-consult
	consult-yasnippet marginalia vertico-posframe
	smex counsel ivy swiper ivy-posframe

        ;; ==== 外观 ====
	rainbow-mode rainbow-delimiters all-the-icons-ibuffer
	smart-mode-line standard-themes
	;; auto-dim-other-buffers

	;; === 窗口管理 ===
	popper bookmark-view

	;; ==== 编辑相关 ====
	hungry-delete           ; 发现一个自带的命令 `c-hungry-delete'
	goto-chg iedit symbol-overlay smartparens
	highlight-parentheses highlight-indent-guides
        ;; highlight-indentation
	company corfu yasnippet avy electric-spacing
	math-symbol-lists expand-region easy-kill

	;; ==== Org ====
	org-download org-tree-slide org-appear org-contrib obsidian
	org-kanban

	;; ==== Python ====
	yafolding pyvenv conda

	;; ==== 非编辑相关 ====
	eshell-up engine-mode hide-mode-line

	;; ==== LaTeX ====
	laas auctex cdlatex

	;; ==== 编程 ====
	emmet-mode js2-mode web-mode dumb-jump diff-hl yaml-mode
        rust-mode quickrun

	;; ==== Major-mode ====
	markdown-mode matlab-mode

	;; ==== Project ====
	;; project-tab-groups project-mode-line-tag beframe

	;; ==== Helm ====
	;; helm-chrome helm-chrome-history

	;; ==== 备忘 ====
	;; minions helm-org-rifle backward-forward
	;; tab-bar-echo-area eyebrowse
	;; academic-phrases valign separedit
	;; adafruit-wisdom anzu eshell-git-prompt gcmh
	;; devdocs sis pinyin-search mini-modeline
	;; minimap calfw calfw-org frames-only-mode
	;; zone zone-rainbow zone-nyan zone-sl totd
	;; zoom zlc web-search google-this scratch
	;; bing-dict emojify focus dired-sider-bar
	))

(when *is-linux*
  (setq fei-package-ensure-installed
	(append fei-package-ensure-installed
		fei-package-ensure-installed-linux)))

(provide 'init-elpa)
;;; init-elpa.el ends here.
