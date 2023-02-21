(setq default-input-method "pyim")

(global-set-key (kbd "M-j") (li (activate-input-method "pyim")))

(defun termux-eudic ()
  "@REF: https://emacs-china.org/t/emacs/18978/2"
  (interactive)
  (shell-command
   (format "termux-open-url eudic://dict/%s"
	   (word-at-point))))

(setq browse-url-generic-program "termux-open-url"
      browse-url-browser-function #'browse-url-generic
      engine/browser-function #'browse-url-generic
      )

(provide 'init-termux)
