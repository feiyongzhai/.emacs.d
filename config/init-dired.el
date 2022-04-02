;;; init-dired.el --- configs for dired
(add-to-list 'load-path "~/.emacs.d/extensions/dired-hacks")
(require 'dired-ranger)
(require 'fei-funcs)

(add-hook 'dired-mode-hook #'hl-line-mode)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;;; Vars

;; find -L /home/yongfeizhai/Desktop/文献仓库/ -samefile
(setq dired-guess-shell-alist-user '(("\\.pdf\\'" "find -L /home/yongfeizhai/Desktop/文献仓库/ -samefile" "xpdf")))
(setq delete-by-moving-to-trash t) ;; 删除 `dired' 文件进入回收站
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(when *is-linux*
  ;; 感觉按照文件名排序就挺好的
  ;; (setq dired-listing-switches "-Bhl --group-directories-first")
  (setq dired-listing-switches "-Bhl")
  )

;;; Keys

(define-key dired-mode-map [mouse-3] 'fei-dired-mouse-find-file-externally)
(define-key dired-mode-map [mouse-2] 'dired-mouse-find-file)
(cond
 (*is-linux*
  (define-key dired-mode-map [mouse-8] 'dired-up-directory))
 (*is-windows*
  (define-key dired-mode-map [mouse-4] 'dired-up-directory)))

(with-eval-after-load 'dired
  (fei-define-key-with-map dired-mode-map
    `(
      ("b" . dired-up-directory)
      ("h" . dired-up-directory)
      ("K" . dired-do-kill-lines)
      ("j" . dired-next-line)
      ("J" . find-file)
      ("k" . dired-previous-line)
      ("l" . dired-find-file)
      ("e" . wdired-change-to-wdired-mode)
      ("." . fei-dired-toggle-hidden)
      ("`" . dired-open-term)
      ("M-w" . dired-ranger-copy)
      ("C-y" . fei-dired-paste/move)
      )))

(with-eval-after-load 'dired-x
  (define-key dired-mode-map (kbd "M-G") nil))

(define-key dired-mode-map (kbd "M-n") 'dired-next-subdir)
(define-key dired-mode-map (kbd "M-p") 'dired-prev-subdir)

(define-key dired-mode-map (kbd "]") 'jump-to-register)
(define-key dired-mode-map (kbd "[") 'point-to-register)

(define-key dired-mode-map (kbd ";f") 'dired-jump-following-symlinks)
;; @REF1: https://emacs.stackexchange.com/questions/41286/follow-symlinked-directories-in-dired
;; @REF2: `ibuffer-jump' 的源码
(defun dired-jump-following-symlinks ()
  "In Dired, visit the file or directory on the line, following symlinks"
  (interactive)
  (let ((find-file-visit-truename t)
	(file (file-truename (dired-get-filename))))
    (dired (file-name-directory file))
    (dired-goto-file file)
    ))

;; 这个包在设计上和 ibuffer 的 filter 保持了一致
(require 'dired-filter)

(provide 'init-dired)
;;; init-dired.el ends here.
