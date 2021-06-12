;;; init-dired.el --- configs for dired

(require 'dired-x)

;;; Code:

;;; Keys

(with-eval-after-load 'dired

  (setq delete-by-moving-to-trash t) ;; 删除 `dired' 文件进入回收站

  (define-key dired-mode-map (kbd "w") 'browse-url-of-dired-file)
  (define-key dired-mode-map (kbd "W") 'dired-copy-filename-as-kill)

  (define-key dired-mode-map (kbd "b") 'dired-up-directory)
  (define-key dired-mode-map (kbd "C-d") #'bookmark-set))

;;; Vars

(add-hook 'dired-mode-hook #'hl-line-mode)
(add-hook 'dired-mode-hook #'dired-hide-details-mode)


(provide 'init-dired)
;;; init-dired.el ends here.
