;;; config for search
(require 'init-func)

;; (ctrlf-mode 1)

;;; Keys
;;; isearch experimental config
(setq isearch-lazy-count t)
(setq lazy-count-suffix-format " [%s/%s]")
(setq lazy-count-prefix-format nil)
(with-eval-after-load 'isearch
  (define-key isearch-mode-map (kbd "M-g") 'isearch-cancel)
  (define-key isearch-mode-map (kbd "DEL") 'isearch-del-char)
  )

(global-set-key (kbd "s-s") 'fei-google-search)
(global-set-key (kbd "M-s p") 'pinyin-search)
(fei-define-key-with-map isearch-mode-map
  '(("C-n" . isearch-repeat-forward)
    ("C-p" . isearch-repeat-backward)
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("C-'" . avy-isearch)
    ("M-h" . isearch-exit)
    ("M-s j" . avy-isearch)
    ("M-w" . (lambda ()
	       (interactive)
	       (isearch-exit)
	       (call-interactively 'copy-region-as-kill)))))

(with-eval-after-load 'ctrlf
  (add-to-list 'ctrlf-minibuffer-bindings '("C-p" . ctrlf-previous-match))
  (add-to-list 'ctrlf-minibuffer-bindings '("C-n" . ctrlf-next-match))
  )

(setq ctrlf-default-search-style 'fuzzy)
(setq ctrlf-show-match-count-at-eol nil)
(setq ctrlf-highlight-current-line nil)

;; (global-anzu-mode t)
(setq-default
 isearch-regexp-lax-whitespace t
 search-whitespace-regexp ".*?")

(provide 'init-search)
