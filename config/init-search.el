;;; config for search
(require 'init-func)
(require 'fei-funcs)

(setq isearch-lazy-count t)
(setq lazy-count-suffix-format " [%s/%s]")
(setq lazy-count-prefix-format nil)
(with-eval-after-load 'isearch
  (define-key isearch-mode-map (kbd "M-g") 'isearch-cancel)
  (define-key isearch-mode-map (kbd "DEL") 'isearch-del-char)
  ;; M-j 配合 `isearch-mode-hook' 和 `isearch-mode-end-hook' 可以完成
  ;; 在 isearch 的情况下也是 "输入中文" 这个功能，这样 M-j 按键的功能
  ;; 就有一致性的表现了
  (define-key isearch-mode-map (kbd "M-j") 'isearch-edit-string)
  )

(add-hook 'isearch-mode-hook '+fei-isearch-deacivate-input-method)
(add-hook 'isearch-mode-end-hook '+fei-isearch-end-restore-input-method)

(global-set-key (kbd "M-s M-s") 'browse-url)
(global-set-key (kbd "s-s") 'fei-search)
(global-set-key (kbd "M-s p") 'swiper-isearch)
(global-set-key (kbd "M-s M-p") 'swiper-isearch)

(with-eval-after-load 'swiper
  (define-key swiper-map (kbd "M-s p") 'swiper-isearch-toggle)
  (define-key swiper-map (kbd "M-s M-p") 'swiper-isearch-toggle))

(fei-define-key-with-map isearch-mode-map
  '(
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("C-'" . avy-isearch)
    ("M-'" . avy-isearch)		;gnome-terminal 读不到 C-',用这个代替
    ("M-s r" . rg-isearch-project)
    ("M-w" . fei-isearch-copy-region)
    ("<C-return>" . prot-search-isearch-other-end)
    ("M-s p" . swiper-isearch-toggle)
    ("M-s M-p" . swiper-isearch-toggle)
    ))

;; (global-anzu-mode t)
(setq-default
 isearch-regexp-lax-whitespace t
 search-whitespace-regexp ".*?")

;; ctrlf-mode

;; (ctrlf-mode 1)

(with-eval-after-load 'ctrlf
  (define-key ctrlf-minibuffer-mode-map (kbd "C-p") 'ctrlf-previous-match)
  (define-key ctrlf-minibuffer-mode-map (kbd "C-n") 'ctrlf-next-match)
  )

(setq ctrlf-default-search-style 'fuzzy)
(setq ctrlf-show-match-count-at-eol nil)
(setq ctrlf-highlight-current-line nil)

(provide 'init-search)
