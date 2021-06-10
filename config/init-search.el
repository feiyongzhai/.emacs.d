;;; config for search

;; There are several solution
;; 1. ctrlf-mode
;; 2. isearch + anzu
;; 3. isearch
;; 4. swiper

;; (ctrlf-mode 1)
(with-eval-after-load 'ctrlf
  (add-to-list 'ctrlf-minibuffer-bindings '("C-p" . ctrlf-previous-match))
  (add-to-list 'ctrlf-minibuffer-bindings '("C-n" . ctrlf-next-match))
)

;; (global-anzu-mode t)
(define-key isearch-mode-map (kbd "C-n") #'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-p") #'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "M->") #'isearch-end-of-buffer)
(define-key isearch-mode-map (kbd "M-<") #'isearch-beginning-of-buffer)
(define-key isearch-mode-map (kbd "C-'") #'avy-isearch)
(define-key isearch-mode-map (kbd "M-w")
  (lambda ()
    (interactive)
    (isearch-exit)
    (call-interactively 'copy-region-as-kill)))


(provide 'init-search)
