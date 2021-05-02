;;; init-packages  --- misc packages configs

;;; Code:

;;; Add to list `user/package-ensure-installed'
(add-to-list 'user/package-ensure-installed 'paredit)
(add-to-list 'user/package-ensure-installed 'treemacs-all-the-icons)
(add-to-list 'user/package-ensure-installed 'helm-chrome)

;;; treemacs 按键
(global-set-key (kbd "C-c SPC") 'treemacs)

(global-set-key (kbd "M-P") #'helm-chrome-bookmarks)

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'init-packages)
;;; init-packages.el ends here.
