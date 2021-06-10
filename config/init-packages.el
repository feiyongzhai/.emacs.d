;;; init-packages  --- misc packages configs

;;; Code:


;;; treemacs 按键
(global-set-key (kbd "C-c SPC") 'neotree-toggle)

(global-set-key (kbd "C-M-0") #'helm-chrome-bookmarks)

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "M-s") nil)
  (define-key paredit-mode-map (kbd "M-r") #'paredit-splice-sexp))

;;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'init-packages)
;;; init-packages.el ends here.
