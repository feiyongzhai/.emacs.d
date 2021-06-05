;;; init-packages  --- misc packages configs

;;; Code:

;;; Add to list `fei-package-ensure-installed'
(add-to-list 'fei-package-ensure-installed 'paredit)
(add-to-list 'fei-package-ensure-installed 'treemacs-all-the-icons)
(add-to-list 'fei-package-ensure-installed 'helm-chrome)

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
