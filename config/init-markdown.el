(require 'fei-funcs)

(with-eval-after-load 'markdown-mode
  (fei-define-key-with-map markdown-mode-map
    '(
      ("M-s !" . markdown-insert-header-setext-1)
      ("M-s 1" . markdown-insert-header-atx-1)
      ("M-s 2" . markdown-insert-header-atx-2)
      ("M-s 3" . markdown-insert-header-atx-3)
      ("M-s 4" . markdown-insert-header-atx-4)
      ("M-s 5" . markdown-insert-header-atx-5)
      ("M-s 6" . markdown-insert-header-atx-6)
      ("M-s @" . markdown-insert-header-setext-2)
      ("<M-up>" . markdown-move-up)
      ("<M-down>" . markdown-move-down)
      )))

(provide 'init-markdown)
