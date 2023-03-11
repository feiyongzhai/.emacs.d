;;; init-dired.el
(add-to-list 'load-path "~/.emacs.d/extensions/dired-hacks")
(require 'fei-funcs)

;; (add-hook 'dired-mode-hook #'treemacs-icons-dired-mode)
;; (add-hook 'dired-mode-hook #'dired-hide-details-mode)
(add-hook 'dired-mode-hook #'hl-line-mode)

;;; Vars

;; @REF: https://stackoverflow.com/questions/4532241/linux-find-all-symlinks-of-a-given-original-file-reverse-readlink
;; find -L /home/yongfeizhai/Desktop/文献仓库/ -samefile
(setq dired-guess-shell-alist-user
      '(("\\.pdf\\'"
	 "find -L /home/yongfeizhai/Desktop/文献仓库/ -samefile"
	 "xpdf")))

(setq delete-by-moving-to-trash t)	;删除 `dired' 文件进入回收站
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-mouse-drag-files t)		;Powered by emacs29
(setq dired-listing-switches "-lah")
(setq dired-clean-confirm-killing-deleted-buffers nil)

;;; Keys

(with-eval-after-load 'dired
  
  (require 'dired-ranger)
  ;; (require 'dired-filter)

  (define-key dired-mode-map [mouse-3] 'fei-dired-mouse-find-file-externally)
  (define-key dired-mode-map [mouse-2] 'dired-mouse-find-file)
  (cond
   (*is-linux*
    (define-key dired-mode-map [mouse-8] 'dired-up-directory))
   (*is-windows*
    (define-key dired-mode-map [mouse-4] 'dired-up-directory)))

  (fei-define-key-with-map dired-mode-map
    `(
      ("b" . dired-up-directory)
      ("h" . dired-up-directory)
      ("K" . dired-do-kill-lines)
      ("C-k" . dired-kill-subdir)
      ("j" . dired-next-line)
      ("J" . fei-counsel-fd-file-jump)
      ("k" . dired-previous-line)
      ("l" . dired-find-file)
      ("e" . wdired-change-to-wdired-mode)
      ("," . browse-url-of-dired-file)
      ("." . fei-dired-toggle-hidden)
      ("`" . fei-eshell-cd-here)
      ("_" . dired-create-empty-file)
      ("SPC" . find-file)
      ("z" . fei-compile)
      ))

  (define-key dired-mode-map (kbd ";f") 'dired-jump-following-symlinks)
  (define-key dired-mode-map (kbd ";c") 'dired-ranger-copy)
  (define-key dired-mode-map (kbd ";v") 'dired-ranger-paste)
  (define-key dired-mode-map (kbd ";V") 'dired-ranger-move)
  (define-key dired-mode-map (kbd ";d") 'dired-duplicate-this-file)
  (define-key dired-mode-map (kbd ";g") 'fei-git-status)
  (define-key dired-mode-map (kbd ";s") 'fei-vc-dired-jump)
  (define-key dired-mode-map (kbd ";w") 'file-manager-here)
  (define-key dired-mode-map (kbd ";l") 'vc-print-root-log)
  )

(with-eval-after-load 'dired-x
  (define-key dired-mode-map (kbd "M-G") nil))

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
    (dired-goto-file file)
    ))

(defun fei-dired-mouse-find-file-externally (event)
  (interactive "e")
  (mouse-set-point event)
  (call-interactively 'browse-url-of-dired-file))


(defun fei-git-status ()
  (interactive)
  (compile "git status"))

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


;; dirvish
(dirvish-override-dired-mode)
(global-set-key (kbd "M-s M-i") 'dirvish-side)
(setq dirvish-attributes
      '(subtree-state all-the-icons file-time file-size))
(setq dirvish-cache-dir "~/.emacs.d/.cache/dirvish/")

(setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
(with-eval-after-load 'dirvish
  (fei-define-key-with-map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
  '(("a"   . dirvish-quick-access)
    ("f"   . dirvish-file-info-menu)
    ("y"   . dirvish-yank-menu)
    ("N"   . dirvish-narrow)
    ("^"   . dirvish-history-last)
    ("H"   . dirvish-history-jump)	; remapped `describe-mode'
    ("s"   . dirvish-quicksort)	; remapped `dired-sort-toggle-or-edit'
    ("v"   . dirvish-vc-menu)	; remapped `dired-view-file'
    ("TAB" . dirvish-subtree-toggle)
    ("M-n" . dirvish-history-go-forward)
    ("M-p" . dirvish-history-go-backward)
    ("M-l" . dirvish-ls-switches-menu)
    ("M-m" . dirvish-mark-menu)
    ("M-t" . dirvish-layout-toggle)
    ("M-h" . dirvish-layout-toggle)	;好按
    ("M-u" . dirvish-setup-menu)
    ("M-e" . dirvish-emerge-menu)
    ("M-S" . dirvish-layout-switch)
    )))



(provide 'init-dired)
;;; init-dired.el ends here.
