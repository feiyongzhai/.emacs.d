;;; init-packages  --- misc packages configs

;;; autoload

(load-path-add "~/.emacs.d/extensions/insert-translated-name")
(autoload 'insert-translated-name-insert "insert-translated-name" nil t)

;;; {{ matlab
(autoload 'org-ctrl-c-ctrl-c "org" nil t) ; hack for matlab-mode
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "C-c C-c") 'org-ctrl-c-ctrl-c))
(add-hook 'matlab-mode-hook (lambda () (display-line-numbers-mode t)))
;;; }}

;;; {{ smex
;; (setq smex-prompt-string "^_^ ")
;;; }}

(defun yasnippet-snippets--fixed-indent ()
  "Set `yas-indent-line' to `fixed'."
  (set (make-local-variable 'yas-indent-line) 'fixed))

(defun yasnippet-snippets--no-indent ()
  "Set `yas-indent-line' to nil."
  (set (make-local-variable 'yas-indent-line) nil))

(with-eval-after-load 'yasnippet
  (yas-load-directory (expand-file-name "~/.emacs.d/snippets") t))

;;; Vars

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'prog-mode-hook 'diff-hl-mode)


(provide 'init-packages)
;;; init-packages.el ends here.
