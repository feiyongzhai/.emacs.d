;;; init-dired.el
(require 'fei-funcs)

;; (add-hook 'dired-mode-hook #'treemacs-icons-dired-mode)
;; (add-hook 'dired-mode-hook #'dired-hide-details-mode)
(add-hook 'dired-mode-hook #'hl-line-mode)

(setq delete-by-moving-to-trash t)	;删除 `dired' 文件进入回收站
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-mouse-drag-files t)		;Powered by emacs29
(setq dired-listing-switches "-lah")
(setq dired-listing-switches
      "-l --almost-all --human-readable --group-directories-first --no-group")

(defun fei-dired-toggle-hidden ()
  (interactive)
  (if (string-match-p "a" dired-listing-switches)
      (progn (setq-local dired-listing-switches "-lh")
	     (dired-sort-other dired-listing-switches))
    (setq-local dired-listing-switches "-lha")
    (dired-sort-other dired-listing-switches)))

;; @REF1: https://emacs.stackexchange.com/questions/41286/follow-symlinked-directories-in-dired
;; @REF2: `ibuffer-jump' 的源码
(defun dired-jump-following-symlinks ()
  "In Dired, visit the file or directory on the line, following symlinks"
  (interactive)
  (let ((find-file-visit-truename t)
	(file (file-truename (dired-get-filename))))
    (dired (file-name-directory file))
    (dired-goto-file file)))

(defun fei-dired-mouse-find-file-externally (event)
  (interactive "e")
  (mouse-set-point event)
  (call-interactively 'browse-url-of-dired-file))

;; @REF: https://emacs.stackexchange.com/questions/60661/how-to-duplicate-a-file-in-dired
(defun dired-duplicate-this-file ()
  "Duplicate file on this line.
   暂时没有对文件夹很好的处理，不过能用，管他的呢。"
  (interactive)
  (let* ((this (dired-get-filename t))
	 (name (file-name-base this))
	 (ext  (file-name-extension this))
         (ctr  1)
         (new   (format "%s[%d].%s" name ctr ext)))
    (while (file-exists-p new)
      (setq ctr  (1+ ctr)
            new  (format "%s[%d].%s" name ctr ext)))
    (dired-copy-file this new nil))
  (revert-buffer))

(provide 'init-dired)
;;; init-dired.el ends here.
