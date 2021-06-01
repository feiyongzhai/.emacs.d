
(add-to-list 'fei-package-ensure-installed 'auctex)
(add-to-list 'fei-package-ensure-installed 'cdlatex)

(add-hook 'LaTeX-mode-hook (lambda ()
			     (cdlatex-mode t)))

(setq TeX-view-program-selection
      '(((output-dvi has-no-display-manager)
	 "dvi2tty")
	((output-dvi style-pstricks)
	 "dvips and gv")
	(output-dvi "xdvi")
	(output-pdf "Zathura")
	(output-html "xdg-open")))

(provide 'init-latex)
