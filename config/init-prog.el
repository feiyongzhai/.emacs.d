(add-hook 'c-mode-hook 'electric-pair-local-mode)
(add-hook 'c++-mode-hook 'electric-pair-local-mode)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (company-mode t)
	    (yas-minor-mode t)
	    (menu-bar--display-line-numbers-mode-absolute)))

;; {{ octave alternative for matlab-mode
(add-hook 'octave-mode-hook 'electric-pair-local-mode)
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

(add-hook 'octave-mode-hook
    (lambda () (progn (setq octave-comment-char ?%)
                      (setq comment-start "% ")
                      (setq comment-add 0)
		      (setq comment-column 0)
		      )))
;; }} octave

;;; {{ matlab
(setq matlab-indent-level 2)
(add-hook 'matlab-mode-hook (lambda () (display-line-numbers-mode t)))
;;; }}

;; {{ devdocs
(with-eval-after-load 'devdocs
  (define-key devdocs-mode-map (kbd "s") 'devdocs-search))
(global-set-key (kbd "C-h q") 'devdocs-lookup)
(global-set-key (kbd "C-h Q") 'devdocs-search)

;; }} devdocs

(provide 'init-prog)
