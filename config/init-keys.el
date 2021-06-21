;;; quick open dir or file
(fei-define-key-with-map global-map
  '(
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

    ;; C-s-* style
    ))


(provide 'init-keys)
