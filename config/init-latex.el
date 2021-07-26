;;; Vars

(add-hook 'LaTeX-mode-hook #'cdlatex-mode)

(with-eval-after-load 'latex
  ;; @ref https://github.com/yangsheng6810/dotfiles/blob/master/.spacemacs.d/init.org
  (add-to-list 'TeX-command-list '
	       ("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t)))

;;; eaf support
;; @ref https://github.com/manateelazycat/emacs-application-framework/wiki/LaTeX
(defun TeX-eaf-sync-view()
  (unless (fboundp 'eaf-open)
    ;; (error "EAF is not available!")
    (require 'eaf)
    )
  (let* ((pdf (TeX-active-master (TeX-output-extension)))
         (url (expand-file-name pdf))
         (app-name "pdf-viewer")
         (exists-eaf-buffer)
         (eaf-buffer-window))
    (catch 'found-match-buffer
      (dolist (buffer (buffer-list))
        (set-buffer buffer)
        (when (equal major-mode 'eaf-mode)
          (when (and (string= eaf--buffer-url url)
                     (string= eaf--buffer-app-name app-name))
            (setq exists-eaf-buffer buffer)
            (setq eaf-buffer-window (get-buffer-window exists-eaf-buffer))
            (throw 'found-match-buffer t)))))
    (if (and exists-eaf-buffer eaf-buffer-window)
        (pop-to-buffer exists-eaf-buffer)
      (eaf-open url app-name "--synctex_on=True"))))

(eval-after-load "tex"
  '(progn
	(add-to-list 'TeX-view-program-list '("eaf" TeX-eaf-sync-view))
	(add-to-list 'TeX-view-program-selection '(output-pdf "eaf"))
))


;; (setq TeX-view-program-selection
;;       '(((output-dvi has-no-display-manager)
;; 	 "dvi2tty")
;; 	((output-dvi style-pstricks)
;; 	 "dvips and gv")
;; 	(output-dvi "xdvi")
;; 	(output-pdf "Zathura")
;; 	(output-html "xdg-open")))

(provide 'init-latex)
