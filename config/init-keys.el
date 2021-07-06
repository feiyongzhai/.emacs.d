;;; quick open dir or file
(fei-define-key-with-map global-map
  '(
    ;; ESC ESC Style 这类快捷键会导致有点慢 这种快捷键的方式，完成一
    ;; 个命令需要按两下，如果命令本身就是一个动作的话，我在使用的过程
    ;; 中经常是按了前面的按键之后就不知道刚刚要干什么了，很打断思路，
    ;; 根据我的使用经验，这种分段的按键方式不适合那种很`直接的命令'，
    ;; 而是需要很具有`分段特性的命令'结合使用才不会打断思路直接的命令
    ;; 可以用一个组合按键来配合使用如同下面列举的：`M-s-*'和`C-s-*'类
    ;; 型的一步到位的组合键模式，而不适合这种序列式的按键模式

    ;; ESC ESC * style
    ("ESC ESC h" . (lambda () (interactive) (dired "~")))
    ("ESC ESC d" . (lambda () (interactive) (dired "~/Downloads")))
    ("ESC ESC D" . (lambda () (interactive) (dired "~/Desktop")))
    ("ESC ESC m" . (lambda () (interactive) (dired "~/Music")))
    ("ESC ESC s" . (lambda () (interactive) (dired "~/Sandbox")))
    ("ESC ESC p" . (lambda () (interactive) (dired "~/Picture")))
    ("ESC ESC n" . (lambda () (interactive) (dired "~/Nutstore Files")))
    ("ESC ESC e" . (lambda () (interactive) (dired "~/.emacs.d")))
    ("ESC ESC ." . (lambda () (interactive) (dired "~/dotfiles-fei")))
    ("ESC ESC c" . (lambda () (interactive) (dired "~/.config")))
    ("ESC ESC v" . (lambda () (interactive) (dired "~/Videos")))
    ("ESC ESC V" . (lambda () (interactive) (dired "~/.vim")))
    ("ESC ESC g" . (lambda () (interactive) (dired "~/Sandbox/Git/testGit/")))
    ("ESC ESC E" . (lambda () (interactive) (dired "~/Sandbox/Emacs/")))
    ("ESC ESC C-b" . (lambda () (interactive) (dired "~/Sandbox/Emacs/MyBlog/")))

    ("ESC ESC ;" . (lambda () (interactive) (find-file "~/.emacs.d/@scratch@")))
    ("ESC ESC o" . (lambda () (interactive) (find-file "~/.emacs.d/init-local.el")))

    ("ESC ESC b" . list-bookmarks)
    ("ESC ESC l" . list-packages)
    ("ESC ESC L" . list-processes)
    ("ESC ESC <M-escape>" . evil-local-mode-with-cursor)

    ;; M-s-* style
    ("M-s-b" . (lambda () (interactive) (browse-url "https://feiyongzhai.github.io")))
    ("M-s-d" . (lambda () (interactive) (dired "~/Desktop/")))
    ("M-s-e" . elfeed)
    ("M-s-g" . magit-status)
    ("M-s-n" . (lambda () (interactive) (dired "~/Nutstore Files")))
    ("M-s-i" . toggle-input-method)
    ("M-s-I" . insert-translated-name-insert)

    ("M-s-o" . (lambda () (interactive) (find-file "~/.emacs.d/init-local.el")))
    ("M-s-y" . youdao-dictionary-search-at-point-tooltip)
    ("M-s-;" . (lambda () (interactive) (find-file "~/.emacs.d/@scratch@")))
    ("M-s-l" . display-line-numbers-mode)

    ;; C-s-* style
    ("C-s-i" . fei-toggle-xhup-flypy)
    ("C-s-l" . toggle-truncate-lines)

    ;; C-M-s-* style
    ("C-M-s-l" . display-line-numbers-cycle)

    ;; s-* style usually Windows related
    ("s-[" . fei-restore-or-store-window)
    ("s-]" . fei-restore-window)
    ("s-0" . delete-window)
    ("s-1" . delete-other-windows)
    ("s-2" . split-window-below)
    ("s-3" . split-window-right)
    ("s-o" . other-window)
    ;; 下面这个fei-meow-last-buffer有一个Bug，就是在分屏之后，工作逻辑
    ;; 会有点奇怪，不管了，先用着吧
    ("<s-tab>" . fei-meow-last-buffer)
    ("s-u" . winner-undo)
    ("s-r" . winner-redo)
    ("s-\\" . fei-terminal-here)

    ;; Key Tweaks(less Ctrl style)
    ("C-x F" . set-fill-column)
    ("C-x f" . find-file)
    ("C-c r" . counsel-recentf)
    ("C-c f" . find-name-current-dired)
    ("C-c F" . find-name-dired)

    ("C-x C-d" . dired)
    ("M-z" . fei-org-capture)
    ("C-M-z" . (lambda () (interactive)
		 (org-capture nil "i")
		 (auto-fill-mode)
		 (activate-input-method 'rime)))
    ;; Misc
    ("<menu>" . youdao-dictionary-search-at-point-tooltip)
    ("<insert>" . nil)
    ("M-s s" . isearch-forward-symbol-at-point)
    ("M-s M-s" . swiper)
    ("M-G" . engine-mode-prefixed-map)
    ("M-G M-G" . eaf-open-browser-with-history)
    ("M-G p" . devdocs-lookup)

    ;; <f1> -- <f12>
    ("<f10>" . nil)

    ;; Tab related
    ("M-1" . (lambda () (interactive) (tab-bar-select-tab 1)))
    ("M-2" . (lambda () (interactive) (tab-bar-select-tab 2)))
    ("M-3" . (lambda () (interactive) (tab-bar-select-tab 3)))
    ("M-4" . (lambda () (interactive) (tab-bar-select-tab 4)))
    ("M-5" . (lambda () (interactive) (tab-bar-select-tab 5)))
    ("M-6" . (lambda () (interactive) (tab-bar-select-tab 6)))
    ("M-7" . (lambda () (interactive) (tab-bar-select-tab 7)))
    ("M-8" . (lambda () (interactive) (tab-bar-select-tab 8)))
    ("M-9" . (lambda () (interactive) (tab-bar-select-tab 9)))
    ("M-0" . (lambda () (interactive) (tab-bar-select-tab 10)))
    ("M-_" . tab-close)
    ("M-+" . tab-new)
    ("C-S-w" . tab-close)
    ("C-S-t" . tab-new)

    ;; C-c * style
    ("C-c s" . (lambda () (interactive) (require 'org) (call-interactively 'org-store-link)))

    ;; remap series

    ("M-i" . company-yasnippet/yas-expand)

    ))

;;; ctl-z-map for personal use
;; (define-prefix-command 'ctl-z-map)
;; (global-set-key (kbd "C-z") 'ctl-z-map)

;;; {{ need feature `general`
;;; Evil related keys
(general-create-definer fei-space-leader-def
  :prefix "SPC"
  :states '(normal visual))

(fei-space-leader-def
  "SPC" 'counsel-M-x
  "tt" 'modus-themes-toggle
  "ts" 'counsel-load-theme
  ;; "gg" 'browse-stackoverflow-search
  "g" 'engine-mode-prefixed-map
  "ss" 'eshell
  "se" 'shell
  "jj" 'scroll-other-window
  "kk" 'scroll-other-window-down
  )
;;; }}

(provide 'init-keys)
