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
  ;; (if-let* ((file buffer-file-name)
  ;; 	    (disk (upcase (substring file 0 1)))) ;因为 (upcase "/") => "/"，所以也适配 linux 平台
  ;;     (browse-url (concat "obsidian://open?path=" (url-hexify-string (concat disk (substring file 1)))))    
  ;;   (message "当前 buffer 没有和文件关联!"))

  ;; 下面这个方式避免了 Emacs 中文件名中盘符小写的问题
  ;; 2023-03-03: 随着 obsidian valt 的增加，下面这种指定 valt 的命令适用性较差
  ;; 2023-03-21: 因为 obsidian 端用 remote-save 插件同步，相当于另外一个坚果云客户端
  ;; 这样的话，如果同时开启坚果云同步和 remote-save 就会存在一些问题，用户在使用理解
  ;; 上也存在问题和纠结。为使问题简单，还是采用这个方式，同时 obsidian 的 vault 仓库
  ;; 不使用坚果云的 obsidian 文件夹。

  ;; 多说一点：因为坚果云始终和云端同步文件夹，相当于一个云端的镜像，如果 obsidian 的 vault
  ;; 用这个“云端镜像”，就相当于给这个“云端镜像”添加了一个“本地端”的逻辑，这样这几个同步逻辑
  ;; 作用在一起就很显得混乱，我使用理解起来也不方便，最重要的是这种混乱的同步方式很容易出现
  ;; 问题。

  ;; 在这种使用情景下，emacs 中打开的文件和 obsidian 中打开的文件不是同一个文件。
  (browse-url (concat "obsidian://open?vault=obsidian&file=" (url-hexify-string (buffer-name))))
  )

(provide 'init-markdown)
