;;; init-dired.el --- configs for dired

;;; Code:

(with-eval-after-load 'dired
  ;; 删除 `dired' 文件进入回收站
  (setq delete-by-moving-to-trash t)
  ;; 交换这两个命令的默认绑定
  (define-key dired-mode-map (kbd "w") 'browse-url-of-dired-file)
  (define-key dired-mode-map (kbd "W") 'dired-copy-filename-as-kill)
  (define-key dired-mode-map (kbd "b") 'dired-up-directory))

;; 这个快捷键绑定似乎已经写在了 diredx.el 文件中，使用 `dired-jump' 之
;; 后命令会被重新绑定快捷键
(global-set-key (kbd "C-x C-j") 'dired-jump)

;;; 自动打开高亮行
(add-hook 'dired-mode-hook (lambda ()
			     (hl-line-mode 1)
			     (dired-hide-details-mode 1)))

(provide 'init-dired)
;;; init-dired.el ends here.
