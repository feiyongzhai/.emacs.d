(add-hook 'LaTeX-mode-hook #'cdlatex-mode)
(add-hook 'LaTeX-mode-hook #'yas-minor-mode)
(add-hook 'LaTeX-mode-hook #'reftex-mode)
(add-hook 'LaTeX-mode-hook #'company-mode)
(add-hook 'LaTeX-mode-hook (lambda () (setq-local company-backends '(company-yasnippet))))

;; ==== Org Export ====

;; @REF: https://emacs-china.org/t/org-mode-pdf/16746/2
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("ctexart" "\\documentclass[11pt]{ctexart}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (setq org-latex-default-class "ctexart")
  (setq org-latex-compiler "xelatex"))

(require 'ox-beamer)
(with-eval-after-load 'ox-beamer
  (add-to-list 'org-latex-classes
               '("beamer" "\\documentclass[presentation]{ctexbeamer}"
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

;; @REF: https://emacs.stackexchange.com/questions/17988/variable-to-set-org-export-pdf-viewer
(add-to-list 'org-file-apps '("\\.pdf" . "evince %s")) ; 指定 org-export 后打开 pdf 的软件


;; ==== Quick Input ====

(with-eval-after-load 'cdlatex
  (define-key cdlatex-mode-map (kbd "<") nil))

;; (add-hook 'LaTeX-mode-hook #'laas-mode)
(with-eval-after-load 'latex
  ;; @ref https://github.com/yangsheng6810/dotfiles/blob/master/.spacemacs.d/init.org
  (add-to-list 'TeX-command-list
	       '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t)))

;;; @REF: https://github.com/karthink/.emacs.d/blob/0d56c66c2e2d53ba05366493f433e523cc36cd87/init.el#L2943
(defun my/yas-try-expanding-auto-snippets ()
    (when (and (boundp 'yas-minor-mode) yas-minor-mode)
      (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
        (yas-expand))))
(add-hook 'post-self-insert-hook #'my/yas-try-expanding-auto-snippets)


(provide 'init-latex)
