;;; init-builtin.el --- misc configs

(require 'init-func)
(require 'fei-funcs)

(minibuffer-depth-indicate-mode)
(global-auto-revert-mode)	    ;autoload the file changes on disk
(delete-selection-mode)		    ;选中文本后输入会覆盖
(column-number-mode)
(save-place-mode)
(show-paren-mode)
(blink-cursor-mode -1)
(repeat-mode)
;; (savehist-mode t)		    ;保存 minibuffer 历史
;; (global-subword-mode 1)

(when (executable-find "rg")
  (setq xref-search-program 'ripgrep))

(setq modus-themes-mode-line '(3d))
;; (setq modus-themes-mode-line '3d)	;emacs29 不支持这个配置

(setq whitespace-line-column nil)	;nil means use fill-column
(setq describe-bindings-outline t)
(setq enable-recursive-minibuffers t)

(require 'cal-china-x)
(setq calendar-week-start-day 1)

(recentf-mode t)
(setq bookmark-save-flag 1)	 ;auto save bookmark file when changes
(setq recentf-max-saved-items 50)

(setq-default cursor-in-non-selected-windows nil)
(setq-default display-line-numbers-width 3)
(setq show-paren-style 'parenthesis)
(setq comment-empty-lines t)

(setq display-time-format " %H:%M  %Y-%m-%d")
(setq display-time-default-load-average nil) ; 不显示time后面的不明数字
(display-time-mode)

(setq desktop-restore-frames nil)	; don't restore any frame
(desktop-save-mode t)

;; redirect the backup file path
(setq backup-directory-alist (quote (("." . "~/.emacs.d/.backup"))))

;; @REF：https://www.newsmth.net/nForum/#!article/Emacs/97642
(setq ring-bell-function 'ignore)
(setq split-width-threshold nil) ;分屏的时候使用上下分屏，这个配置对于大屏幕比较有用
(setq word-wrap-by-category t)	 ;按照中文折行

;; Bookmark
(global-set-key (kbd "C-c b") 'list-bookmarks)
(global-set-key (kbd "C-c B") 'counsel-bookmark)
(with-eval-after-load 'bookmark
  (define-key bookmark-bmenu-mode-map (kbd "j") 'bookmark-jump))

;; y-or-n
;; (fset 'yes-or-no-p 'y-or-n-p)
(setq use-short-answers t)		;emacs-28 推荐配置
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

;; Speedbar
;; 让 `speedbar' 显示隐藏文件
;; @REF1: https://stackoverflow.com/questions/5135209/show-hidden-files-in-speedbar/5189565
;; @REF2: https://lists.gnu.org/archive/html/emacs-devel/2016-02/msg00953.html
(setq speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")

(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "M-o") nil)
  (define-key diff-mode-map (kbd "M-k") nil)
  (define-key diff-mode-map (kbd "M-n") nil)
  (define-key diff-mode-map (kbd "M-p") nil)
  (define-key diff-mode-map (kbd "M-N") nil)
  (define-key diff-mode-map (kbd "M-P") nil)
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))

;; builtin `project'
(global-set-key (kbd "C-x p p") 'project-switch-project)
(global-set-key (kbd "C-x p f") 'project-find-file)
(global-set-key (kbd "C-x p r") 'project-query-replace-regexp)

;; hl-line
;; (setq hl-line-sticky-flag t)

;; ;; experiment
;; (global-unset-key (kbd "C-x C-c"))
;; (defalias 'exit 'save-buffers-kill-terminal)

;; Man
(setq Man-notify-method 'aggressive)
(with-eval-after-load 'man
  (define-key Man-mode-map (kbd "o") 'zygospore-toggle-delete-other-windows))

(global-set-key (kbd "C-x m") 'execute-extended-command) ;default is `compose-mail'

(provide 'init-builtin)
