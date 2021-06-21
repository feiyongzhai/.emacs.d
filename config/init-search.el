;;; config for search

;; There are several solution
;; 1. ctrlf-mode
;; 2. isearch + anzu
;; 3. isearch
;; 4. swiper

(require 'init-func)

;; (ctrlf-mode 1)
(with-eval-after-load 'ctrlf
  (add-to-list 'ctrlf-minibuffer-bindings '("C-p" . ctrlf-previous-match))
  (add-to-list 'ctrlf-minibuffer-bindings '("C-n" . ctrlf-next-match)))

;; (global-anzu-mode t)
(fei-define-key-with-map isearch-mode-map
  '(("C-n" . isearch-repeat-forward)
    ("C-p" . isearch-repeat-backward)
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("TAB" . isearch-complete)
    ("C-'" . avy-isearch)
    ("M-w" . (lambda ()
	       (interactive)
	       (isearch-exit)
	       (call-interactively 'copy-region-as-kill)))))

(provide 'init-search)
