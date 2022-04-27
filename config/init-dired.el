;;; init-dired.el --- configs for dired
(add-to-list 'load-path "~/.emacs.d/extensions/dired-hacks")
(require 'dired-ranger)
(require 'dired-filter)	; 这个包在设计上和 ibuffer 的 filter 保持了一致
(require 'fei-funcs)

;; (add-hook 'dired-mode-hook #'treemacs-icons-dired-mode)
(add-hook 'dired-mode-hook #'hl-line-mode)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;;; Vars

;; @REF: https://stackoverflow.com/questions/4532241/linux-find-all-symlinks-of-a-given-original-file-reverse-readlink
;; find -L /home/yongfeizhai/Desktop/文献仓库/ -samefile
(setq dired-guess-shell-alist-user
      '(("\\.pdf\\'"
	 "find -L /home/yongfeizhai/Desktop/文献仓库/ -samefile"
	 "xpdf")))

(setq delete-by-moving-to-trash t) ;; 删除 `dired' 文件进入回收站
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-mouse-drag-files t)		;Powered by emacs29
(setq dired-listing-switches "-lah")

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
      ("<C-return>" . browse-url-of-dired-file)
      ("h" . dired-up-directory)
      ("K" . dired-do-kill-lines)
      ("j" . dired-next-line)
      ("J" . fei-counsel-fd-file-jump)
      ("k" . dired-previous-line)
      ("l" . dired-find-file)
      ("e" . wdired-change-to-wdired-mode)
      ("." . fei-dired-toggle-hidden)
      ("`" . fei-eshell-cd-here)
      ("M-w" . dired-ranger-copy)
      ("C-y" . fei-dired-paste/move)
      )))

(defun fei-dired-toggle-hidden ()
  (interactive)
  (if (string-match-p "a" dired-listing-switches)
      (progn (setq-local dired-listing-switches "-lh")
	     (dired-sort-other dired-listing-switches))
    (setq-local dired-listing-switches "-lha")
    (dired-sort-other dired-listing-switches)))

(with-eval-after-load 'dired-x
  (define-key dired-mode-map (kbd "M-G") nil))

(define-key dired-mode-map (kbd "]") 'jump-to-register)
(define-key dired-mode-map (kbd "[") 'point-to-register)

(define-key dired-mode-map (kbd ";f") 'dired-jump-following-symlinks)
(define-key dired-mode-map (kbd ";e") 'fei-eshell-cd-here)

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

(provide 'init-dired)
;;; init-dired.el ends here.
