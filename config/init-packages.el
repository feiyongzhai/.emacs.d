;;; init-packages  --- misc packages configs

;;; Code:


;;; Keys

(global-set-key (kbd "C-c SPC") 'neotree-toggle)

(global-set-key (kbd "C-=") 'er/expand-region)

(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "M-s") nil)
  (define-key paredit-mode-map (kbd "M-r") #'paredit-splice-sexp))

;;; Vars

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(provide 'init-packages)
;;; init-packages.el ends here.
