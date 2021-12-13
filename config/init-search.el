;;; config for search
(require 'init-func)
(require 'fei-funcs)

;;; Keys
;; isearch experimental config
(setq isearch-lazy-count t)
(setq lazy-count-suffix-format " [%s/%s]")
(setq lazy-count-prefix-format nil)
(with-eval-after-load 'isearch
  (define-key isearch-mode-map (kbd "M-g") 'isearch-cancel)
  (define-key isearch-mode-map (kbd "DEL") 'isearch-del-char)
  ;; M-j 曲线救国的方案，因为通过这样的快捷键设置后，我可以通过连续按
  ;; 两次 M-j 来完成 force enable 输入法的功能，如果能力够的化，我希望
  ;; 可以直接一个 M-j 就可以进入 isearch-edit-string 的 minibuffer 中，
  ;; 并启用输入法
  (define-key isearch-mode-map (kbd "M-j") 'isearch-edit-string)
  )

(global-set-key (kbd "C-s") 'fei-search-forward)
(global-set-key (kbd "C-r") 'fei-search-backward)

(global-set-key (kbd "s-s") 'fei-google-search)
(global-set-key (kbd "M-s p") 'pinyin-search)
(fei-define-key-with-map isearch-mode-map
  '(
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("C-'" . avy-isearch)
    ("M-h" . isearch-exit)
    ("M-s j" . avy-isearch)
    ("M-w" . fei-isearch-copy-region)
    ("<C-return>" . prot-search-isearch-other-end)
    ))

;; (global-anzu-mode t)
(setq-default
 isearch-regexp-lax-whitespace t
 search-whitespace-regexp ".*?")

;; ctrlf-mode

;; (ctrlf-mode 1)

(with-eval-after-load 'ctrlf
  (define-key (kbd "C-p") 'ctrlf-previous-match)
  (define-key (kbd "C-n") 'ctrlf-next-match)
  )

(setq ctrlf-default-search-style 'fuzzy)
(setq ctrlf-show-match-count-at-eol nil)
(setq ctrlf-highlight-current-line nil)

(provide 'init-search)
