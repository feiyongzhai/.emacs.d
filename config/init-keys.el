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

    ("ESC ESC ;" . (lambda () (interactive) (find-file "~/.emacs.d/@scratch@")))
    ("ESC ESC o" . (lambda () (interactive) (find-file "~/.emacs.d/init-local.el")))

    ("ESC ESC b" . list-bookmarks)
    ("ESC ESC l" . list-packages)
    ("ESC ESC L" . list-processes)

    ;; M-s-* style
    ("M-s-b" . (lambda () (interactive) (browse-url "https://feiyongzhai.github.io")))
    ("M-s-e" . elfeed)
    ("M-s-g" . magit-status)
    ("M-s-n" . (lambda () (interactive) (dired "~/Nutstore Files")))
    ("M-s-i" . toggle-input-method)
    ("M-s-I" . insert-translated-name-insert)

    ("M-s-o" . (lambda () (interactive) (find-file "~/.emacs.d/init-local.el")))
    ("M-s-t" . tab-bar-mode)
    ("M-s-y" . youdao-dictionary-search-at-point-tooltip)
    ("M-s-;" . (lambda () (interactive) (find-file "~/.emacs.d/@scratch@")))

    ;; C-s-* style
    ("C-s-i" . fei-toggle-xhup-flypy)

    ;; s-* style usually Windows related
    ("s-[" . fei-store-window)
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

    ("C-x C-d" . dired)
    ("M-z" . fei-org-capture)
    ("C-M-z" . (lambda () (interactive)
		 (org-capture nil "i")
		 (activate-input-method 'rime)))

    ))


(provide 'init-keys)
