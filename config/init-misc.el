;;; init-misc.el --- misc configs

(require 'init-func)
(require 'fei-funcs)

;;; Modes 
(global-auto-revert-mode t) ;; autoload the file changes on disk
(delete-selection-mode t)   ;; 选中文本后输入会覆盖
(column-number-mode t)
(save-place-mode t)
;; (desktop-save-mode t)
(savehist-mode t)
(show-paren-mode 1)
(blink-cursor-mode -1)

;;; Vars
(require 'cal-china-x)
(setq calendar-week-start-day 1)

(setq bookmark-save-flag 1)	 ;auto save bookmark file when changes
(setq recentf-max-saved-items 50)

(setq minimap-window-location 'right)
(setq show-paren-style 'parenthesis)
(setq-default cursor-in-non-selected-windows nil)
(setq-default display-line-numbers-width 3)
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
    ("M-g i"        . imenu)
    ("C-x F"        . set-fill-column)
    ("<f5>"         . fei-simple-compile)
    ("<f7>"         . scratch)
    ("M-s y"        . counsel-yank-pop)
    ("M-s g"        . rgrep)
    ("M-s M-w"      . fei-google-search)
    ("C-c y"        . youdao-dictionary-search-at-point-tooltip)
    ("<menu>"       . youdao-dictionary-search-at-point-tooltip)
    ("C-h y"        . youdao-dictionary-search-from-input)
    ))

(with-eval-after-load 'eaf-browser
  (eaf-bind-key nil "M-s" eaf-browser-keybinding)
  (eaf-bind-key nil "M-S" eaf-browser-keybinding)
  )

(global-set-key (kbd "<M-f12>") 'fei-emacs)
(global-set-key (kbd "ESC <f12>") 'open-current-file-with-gvim)

;; Helpful
(global-set-key (kbd "C-h o") 'helpful-symbol)
(global-set-key (kbd "C-h k") 'helpful-key)
(global-set-key (kbd "C-h O") 'helpful-at-point)

(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-i") 'info-display-manual)

(tool-bar-add-item "spell" 'global-tab-line-mode 'global-tab-line-mode)

;; y-or-n
(fset 'yes-or-no-p 'y-or-n-p)
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

;;; Misc

(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input))

(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "M-o") nil)
  (define-key diff-mode-map (kbd "M-k") nil)
  (define-key diff-mode-map (kbd "M-n") 'diff-file-next)
  (define-key diff-mode-map (kbd "M-p") 'diff-file-prev)
  (define-key diff-mode-map (kbd "M-N") nil)
  (define-key diff-mode-map (kbd "M-P") nil)
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))

;; apt-utils
(load-path-add "~/.emacs.d/extensions/")
(require 'apt-utils)

;; fasd
(load-path-add "~/.emacs.d/extensions/fasd")
(with-eval-after-load 'ivy
  ;; 因为 fasd 的原因，需要在 ivy 之后加载
  (require 'fasd)
  (setq fasd-add-file-to-db-when-eshell t)
  (global-fasd-mode t)
  (setq fasd-enable-initial-prompt nil)
  (global-set-key (kbd "C-x M-f") 'fasd-find-file))

;;; Enable disabled command
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)

(provide 'init-misc)
