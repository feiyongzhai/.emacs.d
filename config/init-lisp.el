;; smartparens-mode
(require 'smartparens-config)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-strict-mode)
(setq sp-highlight-pair-overlay nil
      sp-highlight-wrap-overlay nil)

(provide 'init-lisp)
