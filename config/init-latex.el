
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

(provide 'init-latex)