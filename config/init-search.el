;;; config for search

;; There are several solution
;; 1. ctrlf-mode
;; 2. isearch + anzu
;; 3. isearch
;; 4. swiper

(require 'init-func)

(ctrlf-mode 1)
(setq ctrlf-default-search-style 'fuzzy)
(setq ctrlf-show-match-count-at-eol nil)

;; (global-anzu-mode t)
(setq-default
 isearch-regexp-lax-whitespace t
 search-whitespace-regexp ".*?")

(provide 'init-search)
