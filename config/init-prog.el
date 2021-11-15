(add-hook 'c-mode-hook 'electric-pair-local-mode)
(add-hook 'c++-mode-hook 'electric-pair-local-mode)
(add-hook 'python-mode-hook 'electric-pair-local-mode)


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
(add-hook 'LaTeX-mode-hook #'yas-minor-mode)
(add-hook 'LaTeX-mode-hook #'laas-mode)
(with-eval-after-load 'latex
  ;; @ref https://github.com/yangsheng6810/dotfiles/blob/master/.spacemacs.d/init.org
  (add-to-list 'TeX-command-list '
	       ("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t)))

;;; @REF: https://github.com/karthink/.emacs.d/blob/0d56c66c2e2d53ba05366493f433e523cc36cd87/init.el#L2943
(defun my/yas-try-expanding-auto-snippets ()
    (when (and (boundp 'yas-minor-mode) yas-minor-mode)
      (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
        (yas-expand))))
(add-hook 'post-self-insert-hook #'my/yas-try-expanding-auto-snippets)
(with-eval-after-load 'yasnippet
  (yas-load-directory "~/.emacs.d/snippets/karthink"))

(use-package warnings
  :config
  (push '(yasnippet backquote-change) warning-suppress-types)
  )

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
