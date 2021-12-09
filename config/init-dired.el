;;; init-dired.el --- configs for dired
(require 'fei-funcs)
(require 'dired-x)

(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))
(add-hook 'dired-mode-hook #'hl-line-mode)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;;; Keys

(with-eval-after-load 'dired
  (fei-define-key-with-map dired-mode-map
    `(("w" . browse-url-of-dired-file)
      ("W" . dired-copy-filename-as-kill)
      ("/" . dired-copy-filename-as-kill)
      ("b" . ,(li (find-alternate-file "..")))
      ("h" . dired-up-directory)
      ("K" . dired-do-kill-lines)
      ("j" . dired-next-line)
      ("k" . dired-previous-line)
      ("l" . dired-find-file)
      ("c" . dired-do-copy)
      ("C" . dired-do-compress-to)
      ("r" . dired-do-rename)
      ("e" . wdired-change-to-wdired-mode)
      ("f" . dired-find-alternate-file)
      ("." . fei-dired-toggle-hidden)
      ("<tab>" . dired-subtree-toggle)
      )))

;;; Vars

(setq delete-by-moving-to-trash t) ;; 删除 `dired' 文件进入回收站
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(when *is-linux*
  (setq dired-listing-switches "-Bhl --group-directories-first"))

(provide 'init-dired)
;;; init-dired.el ends here.
