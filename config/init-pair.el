;; smartparens-mode
(require 'smartparens-config)
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-strict-mode)
(setq sp-highlight-pair-overlay nil
      sp-highlight-wrap-overlay nil)

(define-key smartparens-mode-map (kbd "<C-right>") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "<C-left>") 'sp-forward-barf-sexp)
(define-key smartparens-mode-map (kbd "M-U") 'sp-splice-sexp)
(define-key smartparens-mode-map (kbd "M-q") 'sp-indent-defun)


(provide 'init-pair)
