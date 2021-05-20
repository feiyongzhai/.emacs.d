;;; init-packages  --- misc packages configs

;;; Code:

;;; Add to list `user/package-ensure-installed'
(add-to-list 'user/package-ensure-installed 'paredit)
(add-to-list 'user/package-ensure-installed 'treemacs-all-the-icons)
(add-to-list 'user/package-ensure-installed 'helm-chrome)

;;; treemacs 按键
(global-set-key (kbd "C-c SPC") 'treemacs)

(global-set-key (kbd "C-M-0") #'helm-chrome-bookmarks)

(global-set-key (kbd "C-c y y") #'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "C-c y i") #'youdao-dictionary-search-from-input)
(defun user/youdao-dictionary-search-from-input (_arg)
  (interactive "P")
  (message "施工中")
  (when _arg
    ;; TODO: 调用`youdao-dictionary-search-from-input'后自动启用minibuffer的输入法
    (message "施工中")
    ))

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "M-s") nil)
  (define-key paredit-mode-map (kbd "M-r") #'paredit-splice-sexp))

;;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'init-packages)
;;; init-packages.el ends here.
