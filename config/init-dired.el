;;; init-dired.el --- configs for dired

(require 'dired-x)
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))

;;; Keys

(with-eval-after-load 'dired

  (fei-define-key-with-map dired-mode-map
    '(("w" . browse-url-of-dired-file)
      ("W" . dired-copy-filename-as-kill)
      ("b" . dired-up-directory)
      ("N" . dired-next-subdir)
      ("P" . dired-prev-subdir)
      ("/" . isearch-forward)
      ("j" . isearch-forward)
      ("<f2>" . wdired-change-to-wdired-mode)

      ("z" . dired-toggle-hidden)
      ("C-d" . bookmark-set)
      ("M-p" . dired-prev-dirline)
      ("M-n" . dired-next-dirline)
      ("M-G" . nil)
      )))

;;; Vars

(add-hook 'dired-mode-hook #'hl-line-mode)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(setq delete-by-moving-to-trash t) ;; 删除 `dired' 文件进入回收站
(when *is-linux*
  (setq dired-listing-switches "-Bhl --group-directories-first"))
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

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

(defun find-name-current-dired (arg)
  (interactive
   (let ((string
	  (read-string "Find-name(filename wildcard): " nil 'history)))
     (list string)))
  (find-name-dired "." arg))

(provide 'init-dired)
;;; init-dired.el ends here.
