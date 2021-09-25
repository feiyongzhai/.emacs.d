;;; config for search
(require 'init-func)

(ctrlf-mode 1)

;;; Keys

(global-set-key (kbd "s-s") 'fei-google-search)
(fei-define-key-with-map isearch-mode-map
  '(("C-n" . isearch-repeat-forward)
    ("C-p" . isearch-repeat-backward)
    ("s-s" . isearch-repeat-forward)
    ("s-r" . isearch-repeat-backward)
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("TAB" . isearch-complete)
    ("C-'" . avy-isearch)
    ("M-w" . (lambda ()
	       (interactive)
	       (isearch-exit)
	       (call-interactively 'copy-region-as-kill)))))

(with-eval-after-load 'ctrlf
  (add-to-list 'ctrlf-minibuffer-bindings '("C-p" . ctrlf-previous-match))
  (add-to-list 'ctrlf-minibuffer-bindings '("C-n" . ctrlf-next-match))
  (add-to-list 'ctrlf-minibuffer-bindings '("s-s" . ctrlf-next-match))
  (add-to-list 'ctrlf-minibuffer-bindings '("s-r" . ctrlf-previous-match)))

(setq ctrlf-default-search-style 'fuzzy)
(setq ctrlf-show-match-count-at-eol nil)

;; (global-anzu-mode t)
(setq-default
 isearch-regexp-lax-whitespace t
 search-whitespace-regexp ".*?")

(provide 'init-search)
