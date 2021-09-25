;;; init-packages  --- misc packages configs

;;; autoload

(load-path-add "~/.emacs.d/extensions/insert-translated-name")
(autoload 'insert-translated-name-insert "insert-translated-name" nil t)

;; {{ iedit
(global-set-key (kbd "C-;") 'iedit-mode)
;; }} iedit

;;; {{ matlab
(autoload 'org-ctrl-c-ctrl-c "org" nil t) ; hack for matlab-mode
(setq matlab-indent-level 2)
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "C-c C-c") 'org-ctrl-c-ctrl-c))
(add-hook 'matlab-mode-hook (lambda () (display-line-numbers-mode t)))
;;; }}

;; {{ octave alternative for matlab-mode
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

(add-hook 'octave-mode-hook
    (lambda () (progn (setq octave-comment-char ?%)
                      (setq comment-start "% ")
                      (setq comment-add 0)
		      (setq comment-column 0)
		      )))
;; }} octave

;;; {{ smex
;; (setq smex-prompt-string "^_^ ")
;;; }}

;;; {{ ace-window config
(global-set-key (kbd "s-o") 'ace-window)
(setq aw-keys '(?j ?k ?l ?h ?g ?f ?d ?s ?a))
(custom-set-faces '(aw-leading-char-face ((t (:foreground "red" :height 1.5)))))
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

(provide 'init-packages)
;;; init-packages.el ends here.
