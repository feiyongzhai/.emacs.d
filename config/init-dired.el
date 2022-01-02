;;; init-dired.el --- configs for dired
(load-path-add "~/.emacs.d/extensions/dired-hacks")
(require 'dired-ranger)
(require 'fei-funcs)
(require 'dired-x)

(add-hook 'dired-mode-hook #'hl-line-mode)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;;; Keys

(with-eval-after-load 'dired
  (fei-define-key-with-map dired-mode-map
    `(("w" . browse-url-of-dired-file)
      ("W" . dired-copy-filename-as-kill)
      ("/" . dired-copy-filename-as-kill)
      ("b" . dired-up-directory)
      ("h" . dired-up-directory)
      ("K" . dired-do-kill-lines)
      ("j" . dired-next-line)
      ("k" . dired-previous-line)
      ("l" . dired-find-file)
      ("e" . wdired-change-to-wdired-mode)
      ("." . fei-dired-toggle-hidden)
      ("'" . fei-eshell-cd-here)
      ("`" . dired-open-term)
      ("V" . dired-view-file)
      ("M-w" . dired-ranger-copy)
      ("C-y" . fei-dired-paste/move)
      ("c" . dired-do-copy)
      ("r" . dired-do-rename)
      )))

;;; Vars

(setq delete-by-moving-to-trash t) ;; 删除 `dired' 文件进入回收站
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(when *is-linux*
  (setq dired-listing-switches "-Bhl --group-directories-first"))

(provide 'init-dired)
;;; init-dired.el ends here.
