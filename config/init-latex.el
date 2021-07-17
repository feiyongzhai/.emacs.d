;;; Vars

(add-hook 'LaTeX-mode-hook #'cdlatex-mode)

;; (setq TeX-view-program-selection
;;       '(((output-dvi has-no-display-manager)
;; 	 "dvi2tty")
;; 	((output-dvi style-pstricks)
;; 	 "dvips and gv")
;; 	(output-dvi "xdvi")
;; 	(output-pdf "Zathura")
;; 	(output-html "xdg-open")))

(provide 'init-latex)
