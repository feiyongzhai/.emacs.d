(require 'fei-funcs)
(require 'init-func)

(minibuffer-depth-indicate-mode)
(global-auto-revert-mode)	    ;autoload the file changes on disk
(delete-selection-mode)		    ;选中文本后输入会覆盖
(column-number-mode)
(save-place-mode)
(show-paren-mode)
(blink-cursor-mode -1)
(repeat-mode)
(savehist-mode t)			;保存 minibuffer 历史
(global-so-long-mode)

(when (executable-find "rg")
  (setq xref-search-program 'ripgrep))

(setq-default
 window-divider-default-bottom-width 1
 window-divider-default-places (quote bottom-only))

(setq whitespace-line-column nil)	;nil means use fill-column
(setq describe-bindings-outline t)
(setq enable-recursive-minibuffers t)

;; recentf
(recentf-mode t)
(setq recentf-max-saved-items 200)

(setq-default cursor-in-non-selected-windows nil)
(setq-default display-line-numbers-width 3)
(setq show-paren-style 'parenthesis)

(setq display-time-format " %H:%M  %Y-%m-%d")
(setq display-time-default-load-average nil) ; 不显示time后面的不明数字
(display-time-mode)

;; redirect the backup file path
(setq backup-directory-alist (quote (("." . "~/.emacs.d/.backup"))))

;; @REF：https://www.newsmth.net/nForum/#!article/Emacs/97642
(setq ring-bell-function 'ignore)	;no bell

;; (setq split-width-threshold nil) ;分屏的时候只使用上下分屏

;; 我的实践过程中发现，在外接显示器或者较大的屏幕的时候，用一些比较宽
;; 的屏幕的时候，我还是希望可以左右分屏（水平分屏）的

(setq word-wrap-by-category t)	 ;按照中文折行

;;; Bookmark
(setq bookmark-set-fringe-mark nil)	;强迫症选项
(setq bookmark-save-flag 1)	 ;auto save bookmark file when changes

;;; y-or-n
;; (fset 'yes-or-no-p 'y-or-n-p)
(setq use-short-answers t)		;emacs-28 推荐配置
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

;;; Speedbar
;; 让 `speedbar' 显示隐藏文件
;; @REF1: https://stackoverflow.com/questions/5135209/show-hidden-files-in-speedbar/5189565
;; @REF2: https://lists.gnu.org/archive/html/emacs-devel/2016-02/msg00953.html
(setq speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")

;;; hl-line
;; (setq hl-line-sticky-flag t)

;;; Man
(setq Man-notify-method 'aggressive)
(with-eval-after-load 'man
  (define-key Man-mode-map (kbd "o") 'zygospore-toggle-delete-other-windows))

;;; Experiment
;; (global-unset-key (kbd "C-x C-c"))
;; (defalias 'exit 'save-buffers-kill-terminal)

(provide 'init-builtin)
