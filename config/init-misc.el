;;; init-misc.el --- misc configs

(require 'init-func)
(require 'fei-funcs)

;;; Modes & Vars
(global-auto-revert-mode t) ;; autoload the file changes on disk
(delete-selection-mode t)   ;; 选中文本后输入会覆盖
(column-number-mode t)
(save-place-mode t)
;; (desktop-save-mode t)
(savehist-mode t)
(show-paren-mode 1)
(blink-cursor-mode -1)

(setq minimap-window-location 'right)
;; (setq split-width-threshold 0)        ;分屏的时候使用左右分屏
(setq split-height-threshold nil)
(setq show-paren-style 'parenthesis)
(setq-default cursor-in-non-selected-windows nil)
(setq-default display-line-numbers-width 3)
(setq comment-empty-lines t)

(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
(setq display-time-format " %H:%M  %Y-%m-%d")
(setq display-time-default-load-average nil) ; 不显示time后面的不明数字
(setq desktop-restore-frames nil)	     ; don't restore any frame

;; 参考链接：https://www.newsmth.net/nForum/#!article/Emacs/97642
(setq ring-bell-function 'ignore)
;; redirect the backup file path
(setq backup-directory-alist (quote (("." . "~/.emacs.d/.backup"))))

;;; Keys
(fei-define-key-with-map global-map
  `(("<insert>" . nil)
    ("M-g i"    . imenu)
    ("C-x F"    . set-fill-column)
    ("<f5>"     . fei-simple-compile)
    ("M-h"      . find-file) ; inspired by emacstalk 嘉宾领峰
    ("M-H"      . counsel-recentf)
    ("M-j"      . switch-to-buffer)
    ("M-s y"    . counsel-yank-pop)
    ("M-g s"    . scratch)
    ("M-s M-w"  . fei-google-search)
    ("s-y"      . youdao-dictionary-search-at-point-tooltip)
    ("<menu>"   . youdao-dictionary-search-at-point-tooltip)
    ("C-h y"    . youdao-dictionary-search-from-input)
    ))

(global-set-key (kbd "M-s b") 'fei-meow-last-buffer)
(with-eval-after-load 'eaf-browser
  (eaf-bind-key nil "M-s" eaf-browser-keybinding)
  (eaf-bind-key nil "M-S" eaf-browser-keybinding)
  )

(global-set-key (kbd "<M-f12>") (li (start-process "emacs" nil "emacs")))
(global-set-key (kbd "ESC <f12>") 'open-current-file-with-gvim)
(global-set-key (kbd "C-h o") 'helpful-symbol)
(global-set-key (kbd "C-h k") 'helpful-key)
(tool-bar-add-item "spell" 'global-tab-line-mode 'global-tab-line-mode)

;; {{ y-or-n
(fset 'yes-or-no-p 'y-or-n-p)
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)
;; }} y-or-n

(transient-command undo (undo)
  '(("u" . undo)))

;;; Misc

(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input))

(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "M-o") nil)
  (define-key diff-mode-map (kbd "M-k") nil)
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))

;;; Enable disabled command
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(provide 'init-misc)
;;; init-misc.el ends here.
