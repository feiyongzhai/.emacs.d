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

;;; matlab {{
(setq matlab-indent-level 2)
(add-hook 'matlab-mode-hook (lambda () (display-line-numbers-mode t)))
;;; matlab }}

;;; LaTeX {{
(add-hook 'LaTeX-mode-hook #'cdlatex-mode)
(with-eval-after-load 'latex
  ;; @ref https://github.com/yangsheng6810/dotfiles/blob/master/.spacemacs.d/init.org
  (add-to-list 'TeX-command-list '
	       ("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t)))
;;; LaTeX }}

;; devdocs {{
(with-eval-after-load 'devdocs
  (define-key devdocs-mode-map (kbd "s") 'devdocs-search))
(global-set-key (kbd "C-h q") 'devdocs-lookup)
(global-set-key (kbd "C-h Q") 'devdocs-search)
;; devdocs }}

;;; lisp program related {{
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "M-s") nil)
  (define-key paredit-mode-map (kbd "M-r") nil)
  (define-key paredit-mode-map (kbd "M-R") #'paredit-splice-sexp)
  )
;;; lisp program related }}


(provide 'init-prog)
