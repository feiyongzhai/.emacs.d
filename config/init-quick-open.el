;;; {{ quick open
(fei-define-key-with-map global-map
  `(
    ;; ESC ESC * style -- quick open dir or file
    ("ESC ESC d" . ,(li (dired "~/Downloads")))
    ("ESC ESC D" . ,(li (dired "~/Desktop")))
    ("ESC ESC e" . ,(li (dired "~/.emacs.d")))
    ("ESC ESC h" . ,(li (dired "~")))
    ("ESC ESC m" . ,(li (dired "~/Music")))
    ("ESC ESC o" . ,(li (find-file "~/.emacs.d/init-local.el")))
    ("ESC ESC p" . ,(li (dired "~/Picture")))
    ("ESC ESC s" . ,(li (dired "~/Sandbox")))
    ("ESC ESC N" . ,(li (dired "~/Nutstore Files")))
    ("ESC ESC n" . ,(li (dired "~/Nutstore Files/我的坚果云/研究生/SAR/仓库/")))
    ("ESC ESC v" . ,(li (dired "~/Videos")))
    ("ESC ESC V" . ,(li (dired "~/.vim")))
    ("ESC ESC g" . ,(li (dired "~/Sandbox/Git/testGit/")))
    ("ESC ESC ." . ,(li (dired "~/dotfiles-fei")))
    ))
;;; }} quick open

(provide 'init-quick-open)
