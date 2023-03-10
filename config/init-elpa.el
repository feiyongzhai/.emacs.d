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
	magit bash-completion pdf-tools
	graphviz-dot-mode lsp-dart flutter
	;; citre vterm vterm-toggle sx
	))

;;; general needed packages
(setq fei-package-ensure-installed
      '(
	;; ==== Misc ====
	minions gcmh tmr org-contrib
	org-appear
	all-the-icons-ibuffer
	scratch imenu-list rg
	rainbow-mode rainbow-delimiters
	dirvish ef-themes websocket
	interaction-log		 ;这个包需要自己 require，不会自动加载
	beframe

	;; ==== 编辑相关 ====
	evil general backward-forward goto-chg
	highlight-parentheses highlight-indentation
	company yasnippet avy ace-window
	neotree electric-spacing iedit yafolding pyvenv conda
	symbol-overlay separedit smartparens corfu
	olivetti math-symbol-lists laas expand-region vundo

	;; Programming
	emmet-mode js2-mode web-mode dumb-jump diff-hl

	;; ==== Helm ====
	;; helm-chrome helm-chrome-history

	;; ==== Major-mode ====
	markdown-mode matlab-mode auctex cdlatex

	;; ==== Org ====
	org-download obsidian

	;; ==== Minibuffer ====
	orderless vertico embark
	consult marginalia embark-consult
	smex counsel ivy swiper

	;; ==== 非编辑相关 ====
	use-package
	eshell-up elfeed pyim pyim-basedict fcitx
	youdao-dictionary engine-mode hide-mode-line
	
        helpful alarm-clock openwith trashed cal-china-x

	;; ==== 游戏 ====
	rubik

	;; ==== 备忘 ====
	;; helm-org-rifle org-roam org-roam-server
	;; tempel tab-bar-echo-area eyebrowse
	;; academic-phrases valign tldr
	;; adafruit-wisdom eshell-autojump
	;; treemacs-icons-dired
	;; ctrlf anzu eshell-git-prompt
	;; highlight-indent-guides
	;; devdocs sis pinyin-search mini-modeline
	;; goto-line-preview minimap
	;; calfw / calfw-org frames-only-mode
	;; zone zone-rainbow zone-nyan zone-sl totd
	;; zoom zlc web-search google-this
	;; bing-dict emojify focus dired-sider-bar ivy-posframe deadgrep
	;; zygospore 用自己修的版本了
	;; ==== 不想折腾了 ====
	;; w3m mb-url
	;; ialign 它竟然会修改只读 buffer
	))

(when *is-linux*
  (setq fei-package-ensure-installed
	(append fei-package-ensure-installed
		fei-package-ensure-installed-linux)))

(provide 'init-elpa)
;;; init-elpa.el ends here.
