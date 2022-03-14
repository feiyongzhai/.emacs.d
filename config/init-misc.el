;;; init-misc.el --- misc configs

(require 'init-func)
(require 'fei-funcs)

;;; Modes
(setq describe-bindings-outline t)
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)
(global-auto-revert-mode t)	    ;autoload the file changes on disk
(delete-selection-mode t)	    ;选中文本后输入会覆盖
(column-number-mode t)
(save-place-mode t)
(show-paren-mode 1)
(blink-cursor-mode -1)
(repeat-mode)
;; (savehist-mode t)		    ;保存 minibuffer 历史
;; (global-subword-mode 1)
;; (desktop-save-mode t)

;;; Vars
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
(setq desktop-restore-frames nil)	     ; don't restore any frame

;; @REF：https://www.newsmth.net/nForum/#!article/Emacs/97642
(setq ring-bell-function 'ignore)
;; redirect the backup file path
(setq backup-directory-alist (quote (("." . "~/.emacs.d/.backup"))))

;;; Keys
(fei-define-key-with-map global-map
  `(("<insert>"     . fei-occur-at-point)
    ("<insertchar>" . fei-occur-at-point)
    ("C-x F"        . set-fill-column)
    ("<f5>"         . fei-simple-compile)
    ("M-s g"        . rgrep)
    ))

(global-set-key (kbd "C-c o f") 'file-manager-here)
(global-set-key (kbd "C-c o t") 'fei-terminal-here)
(global-set-key (kbd "C-c o v") 'open-current-file-with-gvim)
(global-set-key (kbd "C-c o C-v") 'open-current-file-with-vscode)
(global-set-key (kbd "C-c o C-e") 'open-current-file-with-emacsq)
(global-set-key (kbd "C-c o e") 'open-current-file-with-emacsv)
(global-set-key (kbd "C-c o E") 'open-current-file-with-emacs)
(global-set-key (kbd "<f12>") 'fei-emacs) ;use for quick debug

(global-set-key (kbd "M-s M-l") (li (find-file "~/.emacs.d/config/init-local.el")))
(global-set-key (kbd "M-s L") (li (fei-meow-last-buffer 1)))

;; ESC ESC * == toggle style mode
(fei-define-key-with-map global-map
  '(
    ("M-ESC b" . display-battery-mode)
    ("M-ESC f" . display-fill-column-indicator-mode)
    ("M-ESC l" . display-line-numbers-mode)
    ("M-ESC L" . fei-display-line-numbers-cycle)
    ("M-ESC m" . feebleline-mode)
    ("M-ESC M" . menu-bar-mode)
    ("M-ESC o" . olivetti-mode)
    ("M-ESC t" . display-time-mode)
    ("M-ESC T" . tool-bar-mode)
    ("M-ESC C-t" . tab-bar-mode)
    ("M-ESC r" . ruler-mode)
    ("M-ESC u" . fei-toggle-ui)
    ("M-ESC w" . whitespace-mode)
    ("M-ESC W" . whitespace-newline-mode)
    ("M-ESC v" . evil-mode-with-cursor)
    ))

;; Bookmark
(global-set-key (kbd "C-c b") 'list-bookmarks)
(global-set-key (kbd "C-c B") 'counsel-bookmark)
(with-eval-after-load 'bookmark
  (define-key bookmark-bmenu-mode-map (kbd "j") 'bookmark-jump))

(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-i") 'info-display-manual)

(tool-bar-add-item "spell" 'global-tab-line-mode 'global-tab-line-mode)

;; y-or-n
;; (fset 'yes-or-no-p 'y-or-n-p)
(setq use-short-answers t)		;emacs-28 推荐配置
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

;;; ==== Misc ====

;; 让 `speedbar' 显示隐藏文件
;; @REF1: https://stackoverflow.com/questions/5135209/show-hidden-files-in-speedbar/5189565
;; @REF2: https://lists.gnu.org/archive/html/emacs-devel/2016-02/msg00953.html
(setq speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")

(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "M-o") nil)
  (define-key diff-mode-map (kbd "M-k") nil)
  (define-key diff-mode-map (kbd "M-n") 'diff-file-next)
  (define-key diff-mode-map (kbd "M-p") 'diff-file-prev)
  (define-key diff-mode-map (kbd "M-N") nil)
  (define-key diff-mode-map (kbd "M-P") nil)
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))

;; builtin `project'
(global-set-key (kbd "C-x p p") 'project-switch-project)
(global-set-key (kbd "C-x p f") 'project-find-file)
(global-set-key (kbd "C-x p r") 'project-query-replace-regexp)

;; Pulse
(global-set-key (kbd "C-c h") 'fei-pulse-current-line)

;; hl-line
;; (setq hl-line-sticky-flag t)

;; goldendict
(global-set-key (kbd "C-c C-d") 'fei-golden-dict)
(global-set-key (kbd "C-c d") 'fei-golden-dict)

(add-hook 'server-after-make-frame-hook 'fei-resize-frame)
(defun fei-resize-frame ()
  (interactive)
  (when (display-graphic-p)
    (set-frame-width nil 125)))

;; 计算器
(global-set-key (kbd "M-s -") 'calculator)
(global-set-key (kbd "M-s =") 'calc)

;; ;; experiment
;; (global-unset-key (kbd "C-x C-c"))
;; (defalias 'exit 'save-buffers-kill-terminal)

(global-set-key (kbd "<f7>") 'fei-ff-find-other-file-pdf-org)

(provide 'init-misc)
