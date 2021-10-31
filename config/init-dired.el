;;; init-dired.el --- configs for dired

(require 'dired-x)
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))
(add-hook 'dired-mode-hook #'hl-line-mode)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;;; Keys

(with-eval-after-load 'dired
  (fei-define-key-with-map dired-mode-map
    '(("w" . browse-url-of-dired-file)
      ("W" . dired-copy-filename-as-kill)
      ("b" . dired-up-directory)
      ("N" . dired-next-dirline)
      ("P" . dired-prev-dirline)
      ("/" . isearch-forward)
      ("j" . isearch-forward)
      ("J" . isearch-backward)
      ("<f2>" . wdired-change-to-wdired-mode)
      ("<tab>" . dired-hide-subdir)
      ("z" . fei-dired-toggle-hidden)
      )))

;;; Vars

(setq delete-by-moving-to-trash t) ;; 删除 `dired' 文件进入回收站
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(when *is-linux*
  (setq dired-listing-switches "-Bhl --group-directories-first"))

;;; Func

(defvar fei-dired-toggle-hidden nil
  "t means on, nil means off")

(defun fei-dired-toggle-hidden ()
  (interactive)
  (if fei-dired-toggle-hidden
      (progn (dired-sort-other "-Bhl  --group-directories-first")
	     (setq fei-dired-toggle-hidden nil))
    (dired-sort-other (concat dired-listing-switches " -a"))
    (setq fei-dired-toggle-hidden t)))


(provide 'init-dired)
;;; init-dired.el ends here.
