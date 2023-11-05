;; 内置功能，无依赖

(require 'fei-funcs)
(require 'init-dired)
(require 'init-edit)

(delete-selection-mode)             ;选中文本后输入会覆盖
(savehist-mode t)                   ;保存 minibuffer 历史
(global-auto-revert-mode)	    ;autoload the file changes on disk
(minibuffer-depth-indicate-mode)
(column-number-mode)
(save-place-mode)
(show-paren-mode)
(blink-cursor-mode -1)
(repeat-mode)
(global-so-long-mode)

(when (executable-find "rg")
  (setq xref-search-program 'ripgrep))

(setq-default
 window-divider-default-bottom-width 1
 window-divider-default-places (quote bottom-only))

(setq whitespace-line-column nil)	;nil means use fill-column
(setq describe-bindings-outline t)
(setq enable-recursive-minibuffers t)

;; cua
(setq cua-prefix-override-inhibit-delay .01)
(setq cua-auto-mark-last-change t)	;cua 提供的 last-change 功能

;; Recentf
(recentf-mode t)
(setq recentf-max-saved-items 200)
(add-to-list 'recentf-exclude "bookmarks")
(add-to-list 'recentf-exclude "elgrep-data.el")

(setq-default cursor-in-non-selected-windows nil)
(setq-default display-line-numbers-width 3)
(setq show-paren-style 'parenthesis)

;; redirect the backup file path
;; (setq backup-directory-alist (quote (("." . "~/.emacs.d/.backup"))))

;; @REF：https://www.newsmth.net/nForum/#!article/Emacs/97642
(setq ring-bell-function 'ignore)	;no bell

;; (setq split-width-threshold nil) ;分屏的时候只使用上下分屏

(setq word-wrap-by-category t)		;按照中文折行

;;; Bookmark
(setq bookmark-set-fringe-mark nil)	;强迫症选项
(setq bookmark-save-flag 1)	 ;auto save bookmark file when change
(add-hook 'bookmark-bmenu-mode-hook 'hl-line-mode)

;;; y-or-n
;; (fset 'yes-or-no-p 'y-or-n-p)
(setq use-short-answers t)		;emacs-28 推荐配置
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

;;; hl-line
;; (setq hl-line-sticky-flag t)

;;; Man
(setq Man-notify-method 'aggressive)
(with-eval-after-load 'man
  (define-key Man-mode-map (kbd "o") 'zygospore-toggle-delete-other-windows))

;;; Help
(setq help-window-select t)             ;always select help window

;;; Speedbar
;; 让 `speedbar' 显示隐藏文件
;; @REF1: https://stackoverflow.com/questions/5135209/show-hidden-files-in-speedbar/5189565
;; @REF2: https://lists.gnu.org/archive/html/emacs-devel/2016-02/msg00953.html
(setq speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")

;;; Experiment
;; (global-unset-key (kbd "C-x C-c"))
;; (defalias 'exit 'save-buffers-kill-terminal)

;;; webjump
(with-eval-after-load 'webjump
  (setq webjump-sites
        (append '(("Google xueshu" .
		   [simple-query "scholar.google.com" "https://scholar.google.com/scholar?hl=zh-CN&q=" ""])
		  ("知乎" .
		   [simple-query "www.zhihu.com" "https://www.zhihu.com/search?type=content&q=" ""])
		  ("京东" .
		   [simple-query "www.jd.com" "https://search.jd.com/Search?keyword=" ""])
		  ("bing" .
		   [simple-query "www.bing.com" "https://www.bing.com/search?q=" ""])
		  ("quword" .
		   [simple-query "www.quword.com" "https://www.quword.com/w/" ""])
		  ("google" .
		   [simple-query "www.google.com" "https://www.google.com/search?ie=utf-8&q=" ""])
		  ("baidu" .
		   [simple-query "www.baidu.com" "https://www.baidu.com/s?wd=" ""])
		  ("sogou" .
		   [simple-query "www.sogou.com" "https://www.sogou.com/web?query=" ""])
		  ("weibo" .
		   [simple-query "www.weibo.com" "https://s.weibo.com/weibo?q=" ""])
		  ("github" .
		   [simple-query "www.github.com" "https://github.com/search?ref=simplesearch&q=" ""])
		  ("YouTube" .
		   [simple-query "youtube.com" "http://www.youtube.com/results?aq=f&oq=&search_query=" ""])
		  ("douyin" . "www.douyin.com")
                  ("bilibili" . "bilibili.com")
		  ("Emacs China" . "https://emacs-china.org")
		  ("博客" . "feiyongzhai.github.io")
		  ("Emacs Planet" . "https://planet.emacslife.com/")
		  ("HackNews" . "https://news.ycombinator.com/")
		  ("Google street" . "https://neal.fun/wonders-of-street-view/")
		  ("Steveshuo" . "http://steveshuo.com/")
		  ("cplusplus" . "https://cplusplus.com/")
		  ("cppsh" . "https://cpp.sh/")
		  ("cppsh" . "https://cpp.sh/")
		  ("cppreference" . "https://en.cppreference.com/w/")
		  ("clash" . "https://clash.razord.top/#/proxies")
                  )
                webjump-sample-sites)))

;;; Compile

(defun fei-kill-compilation ()
  (interactive)
  (ignore-errors (kill-compilation) (message "hh"))
  (compilation-mode))

(defun fei-cmp-change-run ()
  (interactive)
  (kill-compilation)
  (compile compile-command t))

(defun fei-cmp-change-dir-recompile ()
  (interactive)
  (setq target-dir (read-file-name "recompile at: " default-directory nil t))
  (let ((default-directory target-dir))
    (message "%s" default-directory)
    (compile compile-command)))

(defun my/apply-ansi-color-to-compilation-buffer-h ()
  "Applies ansi codes to the compilation buffers. Meant for
  `compilation-filter-hook'."
  (with-silent-modifications
    (ansi-color-apply-on-region compilation-filter-start (point))))

(add-hook 'compilation-filter-hook #'my/apply-ansi-color-to-compilation-buffer-h)

(provide 'init-builtin)
