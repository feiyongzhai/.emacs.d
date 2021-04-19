;;; init-packages  --- misc packages configs

;;; Code:

;;; Add to list `user/package-ensure-installed'
(add-to-list 'user/package-ensure-installed 'paredit)

;;; recentf-mode
;; (recentf-mode 1)
;; (setq recentf-max-menu-item 10)

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'init-packages)
;;; init-packages.el ends here.
