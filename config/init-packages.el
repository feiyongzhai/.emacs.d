;; init-packages.el == configs for site packages

(require 'fei-funcs)

;;; TLDR
(setq tldr-locales '("zh"))

;;; 百度网盘
(add-to-list 'load-path "~/.emacs.d/extensions/baidupan")
(require 'dupan)

;;; Calendar
(require 'cal-china-x)
(setq calendar-week-start-day 1)

;;; Treemacs
(setq treemacs-position 'left)

(defun fei-switch-to-treemacs ()
  (interactive)
  (catch 'done
    (dolist (w (window-list) (treemacs))
      (with-current-buffer (window-buffer w)
	(when (eq major-mode 'treemacs-mode)
	  (throw 'done (select-window w)))))))

(defun fei-treemacs-move-to-left ()
  (interactive)
  (treemacs-quit)
  (setq treemacs-position 'left)
  (treemacs))

(defun fei-treemacs-move-to-right ()
  (interactive)
  (treemacs-quit)
  (setq treemacs-position 'right)
  (treemacs))

(defun treemacs-dired-jump ()
  "魔改自 `treemacs-select-directory'

一个已知但是不影响使用的问题：当切换目录的时候使用这个命令会出现一次
Error running timer ‘treemacs--apply-annotations-deferred’
的错误，之后如果不切换目录就不会出现。"
  (interactive)
  (require 'treemacs)
  (treemacs-do-create-workspace "Copilot")
  (treemacs-do-switch-workspace "Copilot")
  (treemacs-block
   (let* ((path (-> default-directory
                    (treemacs-canonical-path)))
          (name (treemacs--filename path))
          (ws (treemacs-current-workspace)))
     (treemacs-return-if
      (and (= 1 (length (treemacs-workspace->projects ws)))
           (string= path (-> ws
                             (treemacs-workspace->projects)
                             (car)
                             (treemacs-project->path))))
      (treemacs-select-window))
     (treemacs--show-single-project path name)
     (treemacs-pulse-on-success "Now showing %s"
                                (propertize path 'face 'font-lock-string-face)))))

;;; Imenu-list
(setq imenu-list-focus-after-activation t)

(defun fei-unhighlight-symbol-at-point ()
  (interactive)
  (unhighlight-regexp
   (concat "\\_<" (thing-at-point 'symbol) "\\_>")))

(defun fei-highlight-region (b e)
  (interactive "r")
  (highlight-phrase (buffer-substring b e))
  (deactivate-mark))

(defun symbol-overlay-find-at-point-project ()
  (interactive)
  (project-find-regexp (thing-at-point 'symbol)))

(defun fei-quword-at-point ()
  (interactive)
  (engine/search-quword (thing-at-point 'word)))

;;; Rg
(rg-define-toggle "--context 3" (kbd "C"))
(rg-define-toggle "-E gbk" (kbd "E"))
(rg-define-toggle "-A 5" (kbd "A"))
(rg-define-toggle "-F" (kbd "F"))	;-F / --fixed-strings flag do a literally search
(rg-define-search rg-project-all-files-no-ask
  :dir project :files "all")

;;; grep-dired
(add-to-list 'load-path "~/.emacs.d/extensions/grep-dired")
(autoload 'grep-dired "grep-dired" nil t) ;emacs 自带了一个相似的命令 `find-name-dired'

;;; jetbrains == Interoperable between emacs with jetbrains IDE
(autoload 'jetbrains-open-buffer-file "jetbrains" nil t)
(autoload 'jetbrains-create-dir-local-file "jetbrains" nil t)

;;; interaction-log
(autoload 'interaction-log-mode "interaction-log" nil t)

;; google-translate
(setq google-translate-default-source-language "auto")
(setq google-translate-default-target-language "zh-CN")

;; youdao-dictionary
(defun fei-youdao-at-point ()
  (interactive)
  (if (display-graphic-p)
      (call-interactively 'youdao-dictionary-search-at-point-tooltip)
    (call-interactively 'youdao-dictionary-search-at-point+)))

;; dumb-jump
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;; zoxide
(add-to-list 'load-path "~/.emacs.d/extensions/zoxide/")
(require 'zoxide)
(global-zoxide-mode)

;; highlight-parentheses
;; 配合 `rainbow-delimiters-mode' 只需要显示一层括号颜色就够了
(setq highlight-parentheses-colors '("Red"))

;; Dashboard
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
;; known bugs: 在 side 新 tab 的时候会报错
;; (setq tab-bar-new-tab-choice 'dashboard-open)

(setq popper-reference-buffers '("\\*Messages\\*$"
				 "\\*vterm\\*"
				 ;; "\\*eshell\\*"
				 ;; (compilation-mode . hide)
				 compilation-mode
				 ))

(popper-mode)
(popper-echo-mode)

(setq diff-hl-show-staged-changes nil)
;; (diff-hl-margin-mode)

(setq keyfreq-file "~/.emacs.d/.cache/emacs.keyfreq")

;; 有些时候，我们改变了一些配置导致了 `vertico-posframe' 或者 `ivy-posframe' 等 posframe 相关的
;; 包出现显示异常，可以通过 `posframe-delete-all' command 来尝试解决
(setq vertico-posframe-parameters
      '((left-fringe . 8)
        (right-fringe . 8)))

(add-to-list 'load-path "~/.emacs.d/extensions/dired-hacks")
(with-eval-after-load 'dired
  ;; (require 'dired-filter)
  (require 'dired-ranger))

;; Dirvish
(dirvish-override-dired-mode)
(setq dirvish-mode-line-height 18)
(setq dirvish-header-line-height 18)
(setq-default dirvish-mode-line-format '(:left (sort omit symlink) :right (index free-space)))
(setq dirvish-attributes
      '(subtree-state all-the-icons file-time file-size))
(setq dirvish-cache-dir "~/.emacs.d/.cache/dirvish/")

;; Markdown 增强插件：Obsidian
(with-eval-after-load 'markdown-mode
  (obsidian-specify-path "~/Nutstore Files/org/obsidian"))

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


;;;;;;;;;;;; Elfeed ;;;;;;;;;;;;
(setq elfeed-feeds
      '(("http://www.solidot.org/index.rss" 奇客)
	("https://manateelazycat.github.io/feed.xml" 懒猫)
	("https://emacstalk.github.io/podcast/index.xml" emacstalk)
	("https://sachachua.com/blog/feed/" SachaChua)
        ("https://yukieyun.net/feed/" 沉默之沙)
        ("https://feeds.fireside.fm/steve/rss" steve说)
        ("https://www.changhai.org/feed.xml" 卢昌海个人主页)
	("https://www.zhihu.com/rss" 知乎)
        ;; ("https://karthinks.com/index.xml" Karthinks)
        ;; ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0uTPqBCFIpZxlz_Lv1tk_g" personal video)
        ;; ("https://planet.emacslife.com/atom.xml" emacsplanet)
	;; ("https://emacs-china.org/latest.rss" emacs)
        ;; ("http://feed.pippa.io/public/shows/teamhuman" podcast culture)
	;; ("http://www.geekpark.net/rss" 极客公园)
	;; ("https://sspai.com/feed" sspai)
	))

(unless *is-termux*
  (add-hook 'elfeed-show-mode-hook
	    (lambda ()
              (when (display-graphic-p)
		(olivetti-mode t))
	      (olivetti-set-width 80))))

(with-eval-after-load 'elfeed
  (face-spec-set 'elfeed-search-title-face '((t (:font "Sarasa Mono SC-12")))))

;; (setq shr-inhibit-images t) ;nil

(provide 'init-packages)

;; Local Variables:
;; outline-regexp: ";;;+"
;; End:
