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
      '(telega magit citre sx))

;;; general needed packages
(setq fei-package-ensure-installed
      '(
	;; ==== 编辑相关 ====
	use-package
	evil general
	company yasnippet
	avy ace-window
	;; ctrlf anzu
	deadgrep
	auctex cdlatex
	neotree minimap
	markdown-mode
	;; devdocs
	matlab-mode
	iedit ialign
	yafolding
	symbol-overlay
	electric-spacing
	separedit
	pyvenv
	highlight-indent-guides
	helm-org-rifle org-download
	;; org-roam org-roam-server

	;; ==== minibuffer ====
	embark orderless marginalia consult vertico
	smex counsel ivy swiper ivy-posframe

	;; ==== 非编辑相关 ====
	adafruit-wisdom
	eshell-up
	elfeed
	pyim sis fcitx
	;; pinyin-search
	youdao-dictionary
	engine-mode
	w3m mb-url
	eyebrowse zygospore
        hide-mode-line
	;; mini-modeline
        helpful
	eshell-git-prompt
        openwith
	alarm-clock
	tldr trashed
	cal-china-x
	academic-phrases

	;; ==== 备忘 ====
	;; goto-line-preview
	;; calfw / calfw-org
	;; frames-only-mode
	;; zone zone-rainbow zone-nyan zone-sl totd
	;; zoom zlc web-search google-this
	;; bing-dict
	;; emojify

	))

(when *is-linux*
  (setq fei-package-ensure-installed
	(append fei-package-ensure-installed
		fei-package-ensure-installed-linux)))

(provide 'init-elpa)
;;; init-elpa.el ends here.
