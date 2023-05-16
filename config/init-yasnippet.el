;; ==== Yasnippet ====
(yas-global-mode)

(defun fei/yas-insert-snippet ()
  (interactive)
  (or yas-minor-mode (yas-minor-mode))
  (call-interactively 'yas-insert-snippet))

(with-eval-after-load 'company
  (defun fei-company-yasnippet ()
    "Hide the current completeions and show snippets."
    (interactive)
    (company-cancel)
    (call-interactively 'company-yasnippet)))

(with-eval-after-load 'yasnippet
  (yas-load-directory (expand-file-name "~/.emacs.d/snippets") t))

(provide 'init-yasnippet)
