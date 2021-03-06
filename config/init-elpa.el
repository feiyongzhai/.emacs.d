;;; init-elpa.el --- configs for package

;; (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;;; emacs-china mirrors
;; (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;; 			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))
;;; USTC mirrors
(setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
                         ;; ("melpa-stable" . "http://mirrors.ustc.edu.cn/elpa/melpa-stable/")
                         ("org" . "http://mirrors.ustc.edu.cn/elpa/org/")))

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
	magit sx bash-completion pdf-tools
	vterm vterm-toggle graphviz-dot-mode
	;; citre
	))

;;; general needed packages
(setq fei-package-ensure-installed
      '(
	;; ==== Misc ====
	minions gcmh
	all-the-icons-ibuffer
	treemacs-icons-dired
	scratch imenu-list rg
	rainbow-mode
	rainbow-delimiters

	;; ==== 编辑相关 ====
	evil general
	highlight-parentheses highlight-indentation
	company yasnippet
	avy ace-window
	neotree
	electric-spacing
	iedit
	yafolding pyvenv conda
	symbol-overlay
	separedit
	smartparens
	corfu tempel
	olivetti
	math-symbol-lists laas
	expand-region

	;; Programming
	lsp-dart flutter
	emmet-mode

	;; ==== Helm ====
	helm-chrome helm-chrome-history

	;; ==== Major-mode ====
	markdown-mode matlab-mode
	auctex cdlatex

	;; ==== Org ====
	helm-org-rifle org-download
	;; org-roam org-roam-server

	;; ==== Minibuffer ====
	orderless vertico embark
	;; consult embark marginalia
	smex counsel ivy swiper

	;; ==== 非编辑相关 ====
	;; tab-bar-echo-area
	use-package
	adafruit-wisdom
	eshell-up
	elfeed
	pyim pyim-basedict fcitx
	youdao-dictionary
	engine-mode
	eyebrowse
        hide-mode-line
	
        helpful
        openwith
	alarm-clock
	tldr trashed
	cal-china-x
	academic-phrases

	;; ==== 备忘 ====
	;; ctrlf anzu
	;; eshell-git-prompt
	;; highlight-indent-guides
	;; devdocs
	;; sis pinyin-search
	;; mini-modeline
	;; zygospore 用自己修改的版本了
	;; goto-line-preview minimap
	;; calfw / calfw-org
	;; frames-only-mode
	;; zone zone-rainbow zone-nyan zone-sl totd
	;; zoom zlc web-search google-this
	;; bing-dict
	;; emojify
	;; focus
	;; dired-sider-bar
	;; ivy-posframe
	;; deadgrep
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
