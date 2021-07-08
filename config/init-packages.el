;;; init-packages  --- misc packages configs

;;; Keys

(with-eval-after-load 'yasnippet
  (yas-load-directory "/home/yongfeizhai/.emacs.d/snippets" t))

;;; Vars

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(provide 'init-packages)
;;; init-packages.el ends here.
