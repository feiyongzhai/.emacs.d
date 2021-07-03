(require 'init-func)

(with-eval-after-load 'markdown-mode
  (fei-define-key-with-map markdown-mode-map
    '(
      ("C-c !" . markdown-insert-header-setext-1)
      ("C-c 1" . markdown-insert-header-atx-1)
      ("C-c 2" . markdown-insert-header-atx-2)
      ("C-c 3" . markdown-insert-header-atx-3)
      ("C-c 4" . markdown-insert-header-atx-4)
      ("C-c 5" . markdown-insert-header-atx-5)
      ("C-c 6" . markdown-insert-header-atx-6)
      ("C-c @" . markdown-insert-header-setext-2)
      ("C-c H" . markdown-insert-header-setext-dwim)
      ("C-c h" . markdown-insert-header-dwim)
      ("C-c s" . markdown-insert-header-setext-2)
      ("C-c t" . markdown-insert-header-setext-1)
      ("<M-up>" . markdown-move-up)
      ("<M-down>" . markdown-move-down)
      )))

(provide 'init-markdown)
