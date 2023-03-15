(require 'fei-funcs)

;; obsidian
(obsidian-specify-path "~/Nutstore Files/org/obsidian")

;; @REF: https://emacs-china.org/t/emacs-obsidian/22504/11?u=yongfeizhai
(defun open-current-file-with-obsidian ()
  "这个函数只可以打开 obsidian 仓库中的文件"
  (interactive)
  ;; `buffer-file-name' 函数在 windows 平台下，会把盘符转换成小写字母，而 obsidian:// uri
  ;; 中对于大小写是敏感的，即只认为大写盘符是正确的，如果非要使用 open?path action 的话，
  ;; 需要在 windows 平台将 `buffer-file-name' 返回值的盘符大写。
  (if-let* ((file buffer-file-name)
	    (disk (upcase (substring file 0 1)))) ;因为 (upcase "/") => "/"，所以也适配 linux 平台
      (browse-url (concat "obsidian://open?path=" (url-hexify-string (concat disk (substring file 1)))))    
    (message "当前 buffer 没有和文件关联!"))

  ;; 下面这个方式避免了 Emacs 中文件名中盘符小写的问题
  ;; 2023-03-03: 随着 obsidian valt 的增加，下面这种指定 valt 的命令适用性较差
  ;; (browse-url (concat "obsidian://open?vault=obsidian&file=" (url-hexify-string (buffer-name))))
  )

(provide 'init-markdown)
