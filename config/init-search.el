;;; config for search
(require 'init-func)
(require 'fei-funcs)

(setq isearch-lazy-count t)
(setq lazy-count-suffix-format " [%s/%s]")
(setq lazy-count-prefix-format nil)
(setq-default
 isearch-regexp-lax-whitespace t
 search-whitespace-regexp ".*?")

(global-set-key (kbd "M-s M-s") 'browse-url)
(global-set-key (kbd "s-g") 'fei-search)
(global-set-key (kbd "M-G") 'fei-search)
(global-set-key (kbd "M-S") 'swiper-isearch)

(global-set-key (kbd "s-s") 'swiper-isearch)
(global-set-key (kbd "s-r") 'swiper-isearch-backward)

(with-eval-after-load 'swiper
  (define-key swiper-map (kbd "s-s") 'swiper-C-s)
  (define-key swiper-map (kbd "s-r") 'swiper-isearch-C-r)
  )

(fei-define-key-with-map isearch-mode-map
  '(
    ("M-g" . isearch-cancel)
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("<C-return>" . prot-search-isearch-other-end)
    ("C-'" . avy-isearch)
    ("M-'" . avy-isearch)	 ;gnome-terminal 读不到 C-',用这个代替
    ("C-c k" . fei-counsel-rg-from-isearch)
    ("M-s r" . rg-isearch-project)
    ("M-S" . swiper-isearch-toggle)
    ("s-s" . swiper-isearch-toggle)
    ))

(defun fei-counsel-rg-from-isearch ()
  (interactive)
  (isearch-exit)
  (counsel-rg isearch-string))

;; ==== ctrlf-mode ====
;; (ctrlf-mode 1)

(setq ctrlf-default-search-style 'fuzzy)
(setq ctrlf-show-match-count-at-eol nil)
(setq ctrlf-highlight-current-line nil)

(with-eval-after-load 'ctrlf
  (define-key ctrlf-minibuffer-mode-map (kbd "C-p") 'ctrlf-previous-match)
  (define-key ctrlf-minibuffer-mode-map (kbd "C-n") 'ctrlf-next-match)
  )

(provide 'init-search)
