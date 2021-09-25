;;; {{ quick open
(fei-define-key-with-map global-map
  `(
    ;; ESC ESC * style -- quick open dir or file
    ("ESC ESC c" . ,(li (dired "~/.config")))
    ("ESC ESC d" . ,(li (dired "~/Downloads")))
    ("ESC ESC D" . ,(li (dired "~/Desktop")))
    ("ESC ESC e" . ,(li (dired "~/.emacs.d")))
    ("ESC ESC E" . ,(li (dired "~/Sandbox/Emacs/")))
    ("ESC ESC h" . ,(li (dired "~")))
    ("ESC ESC m" . ,(li (dired "~/Music")))
    ("ESC ESC o" . ,(li (find-file "~/.emacs.d/init-local.el")))
    ("ESC ESC p" . ,(li (dired "~/Picture")))
    ("ESC ESC s" . ,(li (dired "~/Sandbox")))
    ("ESC ESC N" . ,(li (dired "~/Nutstore Files")))
    ("ESC ESC n" . ,(li (dired "/home/yongfeizhai/Nutstore Files/我的坚果云/研究生/SAR/")))
    ("ESC ESC v" . ,(li (dired "~/Videos")))
    ("ESC ESC V" . ,(li (dired "~/.vim")))
    ("ESC ESC g" . ,(li (dired "~/Sandbox/Git/testGit/")))
    ("ESC ESC C-b" . ,(li (dired "~/Sandbox/Emacs/MyBlog/")))
    ("ESC ESC ." . ,(li (dired "~/dotfiles-fei")))
    ("ESC ESC ;" . ,(li (find-file "~/.emacs.d/@scratch@")))
    ("M-s-b" . ,(li (browse-url "https://feiyongzhai.github.io")))
    ("M-s-m" . ,(li (dired "~/Nutstore Files/我的坚果云/研究生")))
    ("M-s-o" . ,(li (find-file "~/.emacs.d/init-local.el")))
    ("M-s-;" . ,(li (find-file "~/.emacs.d/@scratch@")))
    ("M-s-n" . ,(li (dired "~/Nutstore Files")))
    ))
(global-set-key (kbd "<s-tab>") 'fei-meow-last-buffer)
;;; }} quick open

(provide 'init-quick-open)
