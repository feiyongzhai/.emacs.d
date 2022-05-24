;; ==== Yasnippet ====
(yas-global-mode)
(global-set-key (kbd "C-x y") 'yas-insert-snippet)
(global-set-key (kbd "C-M-y") 'company-yasnippet)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-M-y") 'fei-company-yasnippet)
  (defun fei-company-yasnippet ()
    "Hide the current completeions and show snippets."
    (interactive)
    (company-cancel)
    (call-interactively 'company-yasnippet)))

(with-eval-after-load 'yasnippet
  (yas-load-directory (expand-file-name "~/.emacs.d/snippets") t))

;; @REF: http://joaotavora.github.io/yasnippet/snippet-expansion.html
(with-eval-after-load 'yasnippet
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "M-i") yas-maybe-expand) ;注意：`yas-maybe-expand' 是一个 variable
  (define-key yas-keymap (kbd "M-n") 'yas-next-field)
  (define-key yas-keymap (kbd "M-p") 'yas-prev-field)
  (define-key yas-keymap (kbd "M-i") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "M-I") 'yas-prev-field)
  )


(provide 'init-yasnippet)
