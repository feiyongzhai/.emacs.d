;; 私人配置

;; 无聊锦囊
(defun wuliaojn ()
  (interactive)
  (dired "/home/yongfeizhai/Nutstore Files/org/无聊锦囊/"))

(defun fei/org-notes-archive ()
  (interactive)
  (let ((source-dir (expand-file-name "~/Nutstore Files/"))
        (destination (concat (expand-file-name "~/Archives/org-notes/")
                             "org-"
                             (format-time-string "%Y-%m-%d-%H-%M")
                             ".zip")))
    (async-shell-command
     (concat
      (format "cd \"%s\" && " source-dir) ;先切到目标目录，不要 zip -r 得到的压缩包会有绝对路径
      "zip -r "                           ;递归的压缩文件
      (format "\"%s\" \"%s\"" destination "org/")))))

(defun fei-counsel-rg-my-org ()
  (interactive)
  (counsel-rg nil "~/Nutstore Files/org"))

;; @REF: https://stackoverflow.com/questions/4532241/linux-find-all-symlinks-of-a-given-original-file-reverse-readlink
;; find -L /home/yongfeizhai/Desktop/文献仓库/ -samefile
(setq dired-guess-shell-alist-user
      '(("\\.pdf\\'"
	 "find -L /home/yongfeizhai/Desktop/文献仓库/ -samefile"
	 "xpdf")))

(provide 'init-private)
