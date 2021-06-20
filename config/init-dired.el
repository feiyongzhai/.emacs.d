;;; init-dired.el --- configs for dired

(require 'dired-x)

;;; Code:

;;; Keys

(with-eval-after-load 'dired

  (setq delete-by-moving-to-trash t) ;; 删除 `dired' 文件进入回收站

  (fei-define-key-with-map dired-mode-map
    '(("w" . browse-url-of-dired-file)
      ("W" . dired-copy-filename-as-kill)
      ("b" . dired-up-directory)
      ("N" . dired-next-dirline)
      ("P" . dired-prev-dirline)

      ("C-d" . bookmark-set)
      ("M-h" . dired-toggle-hidden)
      )))

;;; Vars

(add-hook 'dired-mode-hook #'hl-line-mode)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(setq dired-listing-switches "-Bhl --group-directories-first")

;;; Func

(defvar dired-toggle-hidden nil
  "t means on, nil means off")

(defun dired-toggle-hidden ()
  (interactive)
  (if dired-toggle-hidden
      (progn (dired-sort-other "-Bhl  --group-directories-first")
	     (setq dired-toggle-hidden nil))
    (dired-sort-other (concat dired-listing-switches " -a"))
    (setq dired-toggle-hidden t)))


(provide 'init-dired)
;;; init-dired.el ends here.
