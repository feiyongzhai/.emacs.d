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
      '(telega magit citre))

;;; general needed packages
(setq fei-package-ensure-installed
      '(evil general
	elfeed
	eshell-up
	company yasnippet
	smex counsel ivy swiper ivy-posframe ctrlf anzu avy
	embark orderless marginalia consult
	ace-window
	pinyin-search pyim
	youdao-dictionary
	auctex cdlatex
	neotree minimap
	engine-mode
	;; org-roam org-roam-server
	org-download
	markdown-mode
	;; devdocs
	use-package
	matlab-mode
	iedit ialign
        hide-mode-line
	goto-line-preview
        openwith
        helpful
	electric-spacing
	cal-china-x
	eyebrowse zygospore
	symbol-overlay
	tldr trashed w3m
	alarm-clock
	separedit
	;; frames-only-mode

	;; == 有趣/有用的 packages 备忘 ==
	academic-phrases
	;; calfw / calfw-org
	;; zone zone-rainbow zone-nyan zone-sl totd
	;; zoom zlc web-search google-this
	;; web-search bing-dict

	))

(when *is-linux*
  (setq fei-package-ensure-installed
	(append fei-package-ensure-installed
		fei-package-ensure-installed-linux)))

(provide 'init-elpa)
;;; init-elpa.el ends here.
