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

;; obsidian
(obsidian-specify-path "~/Nutstore Files/org/obsidian")
(define-key markdown-mode-map (kbd "C-c M-o") 'obsidian-follow-link-at-point)
(define-key markdown-mode-map (kbd "C-x M-o") 'open-current-file-with-obsidian)

;; @REF: https://emacs-china.org/t/emacs-obsidian/22504/11?u=yongfeizhai
(defun open-current-file-with-obsidian ()
  "这个函数只可以打开 obsidian 仓库中的文件"
  (interactive)
  ;; `buffer-file-name' 函数在 windows 平台下，会把盘符转换成小写字母，而 obsidian:// uri
  ;; 中对于大小写是敏感的，即只认为大写盘符是正确的，如果非要使用 open?path action 的话，
  ;; 需要在 windows 平台将 `buffer-file-name' 返回值的盘符大写。
  ;; (browse-url (concat "obsidian://open?path=" (url-hexify-string (buffer-file-name))))

  ;; 下面这个方式避免了 Emacs 中文件名中盘符小写的问题
  (browse-url (concat "obsidian://open?vault=obsidian&file=" (url-hexify-string (buffer-name))))
  )

(provide 'init-markdown)
