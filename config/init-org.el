;;; init-org.el == configs for Org/Markdown
(require 'fei-funcs)
(when (executable-find "deno")
  (require 'init-deno-bridge-jieba))

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
(add-hook 'org-mode-hook '+fei-org-mode-hook)

(defun +fei-org-mode-hook ()
  ;; (org-indent-mode) ;@REF: http://0x100.club/wiki_emacs/emacs-tricks.html#orgb2882ba
  (yas-minor-mode)
  (setq-local line-spacing 3) ;当有大段文字的时候，行与行之间的间距太小的话看起来会比较累

  ;; `visual-line-mode' 比 `toggle-truncate-lines' 效果更好，这两个函数在终端下表现差异很小
  (visual-line-mode)
  ;; (toggle-truncate-lines -1)
  
  (setq tab-width 2)

  (smartparens-mode)
  )

(with-eval-after-load 'org
  ;; 控制 org-latex-preview
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
  (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
  )


;; 使得 org 中的时间格式变成英文来规避乱码问题
;; (setq system-time-locale "C")
(with-eval-after-load 'org
  ;; 统一 linux 和 windows 平台的时间戳显示
  ;; @REF: https://emacs-china.org/t/topic/1551/31?u=yongfeizhai
  (setq org-time-stamp-formats '("<%Y-%m-%d %A>" . "<%Y-%m-%d %A %H:%M>"))

  ;; org-mode 中的 C-c M-l 绑定到了 `org-insert-last-stored-link' 上
  ;; C-c s 用于想在 org-mode 中用 `org-store-link'
  )

(setq org-export-async-init-file (expand-file-name "~/.emacs.d/config/init-org-export.el"))
(setq org-default-notes-file "~/Nutstore Files/org/capture.org")
(setq org-agenda-files '("~/Nutstore Files/org/gtd.org" "~/Nutstore Files/org/SAR.org"))
(setq org-refile-targets
      '((nil :maxlevel . 1)
	(org-agenda-files :maxlevel . 1)
	("~/Nutstore Files/org/private/private.org" :maxlevel . 1)))

;; 更好的样式
(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
	("PLAN" . "brown")
	("WANT" . "grey")
	("WIP" . "orange")
	("SOMEDAY" . "dark red")
	("FEELING" . "blue")
        ("REFLECT" . "purple")
	("LOG" . "blue")
	("NOTE" . "blue")
        ("CANCELED" . (:foreground "grey" :weight bold))))

(setq org-fontify-quote-and-verse-blocks t) ;给 quote 和 verse block 添加样式
(setq org-log-into-drawer t)		;把 log 放到 drawer 中，看起来更规整一些
;; (setq org-level-color-stars-only t)	;只高亮 stars
;; (setq org-hide-leading-stars t)
(setq org-highlight-latex-and-related '(native)
      ;; org-ellipsis " ∇ "
      org-ellipsis " ↩"
      org-adapt-indentation nil)
(with-eval-after-load 'org
  ;; 完成任务时, 将其划线勾掉
  (set-face-attribute 'org-headline-done nil :strike-through t))

;; 设置各个标题的大小，不使用配色来区分 headline 层级
(custom-set-faces
 '(org-level-1 ((t (:weight extra-bold :height 1.25))))
 '(org-level-2 ((t (:weight bold :height 1.15))))
 '(org-level-3 ((t (:weight bold :height 1.12))))
 '(org-level-4 ((t (:weight semi-bold :height 1.09))))
 '(org-level-5 ((t (:weight semi-bold :height 1.06))))
 '(org-level-6 ((t (:weight semi-bold :height 1.03))))
 '(org-level-8 ((t (:weight semi-bold)))))

;; headline 上下空一行会好看一些

;; org-num-mode: 给 headline 添加数字标题（内置功能）
;; org-bars: 添加缩进线（外部包，目前只在 github 上）
;; org-fragtog: latex 预览（melpa 可下载）

;; org-appear
(add-hook 'org-mode-hook 'org-appear-mode)
(setq org-hide-emphasis-markers t)	;builtin option
(setq org-appear-autoemphasis t
      org-appear-autosubmarkers t
      org-appear-autolinks nil)

;;; org 中文格式去除需要添加空格的限制，以及相应的 org-export 配置
;; @REF: https://emacs-china.org/t/org-mode/597/6?u=yongfeizhai
;; @REF: https://emacs-china.org/t/org-mode/597/5?u=yongfeizhai
;; @NOTE: 配置可能存在潜在问题，出现问题的时候留意观察
(setq org-emphasis-regexp-components
      ;; markup 记号前后允许中文
      (list (concat " \t('\"{"            "[:nonascii:]")
            (concat "- \t.,:!?;'\")}\\["  "[:nonascii:]")
            " \t\r\n,\"'"
            "."
            1))
(with-eval-after-load 'org
  (setq org-match-substring-regexp
        (concat
         ;; 限制上标和下标的匹配范围，org 中对其的介绍见：(org) Subscripts and superscripts
         "\\([0-9a-zA-Zα-γΑ-Ω]\\)\\([_^]\\)\\("
         "\\(?:" (org-create-multibrace-regexp "{" "}" org-match-sexp-depth) "\\)"
         "\\|"
         "\\(?:" (org-create-multibrace-regexp "(" ")" org-match-sexp-depth) "\\)"
         "\\|"
         "\\(?:\\*\\|[+-]?[[:alnum:].,\\]*[[:alnum:]]\\)\\)")))

;;; 关于 org-export 是对于换行符号的处理
;; latex 中的 xelatex 可以自己处理换行，所以在 emacs 这边不需要多余的处理
;; html 不会，所以需要在 emacs 这边进行一些配置
;; @NOTE: 配置可能存在潜在风险，出现问题的留意观察该部分
;; @REF: https://emacs-china.org/t/org-mode-html/7174
;; @REF: https://emacs-china.org/t/org-mode-html/7174/2?u=yongfeizhai
;; @REF: https://github.com/syl20bnr/spacemacs/blob/84d649ac2e5e6de508d3e5b57be38b6e00d5cdc1/layers/%2Bintl/chinese/packages.el#L131
;; 1. 一种方式是：#+options: \n:t
;; 2. 另外一种方式如下
(defadvice org-html-paragraph (before org-html-paragraph-advice
                                        (paragraph contents info) activate)
    "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
    (let* ((origin-contents (ad-get-arg 1))
           (fix-regexp "[[:multibyte:]]")
           (fixed-contents
            (replace-regexp-in-string
             (concat
              "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))
      (ad-set-arg 1 fixed-contents)))



(require 'fei-pomodoro "~/.emacs.d/extensions/fei/fei-pomodoro.el")
(setq org-clock-sound "~/Music/rings/ding0.wav")
(autoload 'org-timer-set-timer "org" t)

(setq org-directory "~/Nutstore Files/org")
;;; org-capture-templates
(with-eval-after-load 'org-capture
  ;; 为什么我这里用 eval-after-load 就不能按照预期运行
  (setq org-capture-templates
	`(("t" "Task" entry
	   (file "gtd.org")
	   "* TODO %?\nCREATE: %T\n")
	  ("T" "Task(为Eshell设计)" entry
	   (file "gtd.org")
	   "* TODO %i\nCREATE: %T\n"
	   :immediate-finish t)
	  ("s" "SomeDay" entry
	   (file "inbox.org")
	   "* SOMEDAY %?\nCREATE: %T\n")
	  ("S" "SAR" entry
	   (file+headline "SAR.org" "Inbox")
	   "* TODO %?")
	  ("K" "Research" entry
	   (file+headline "private/Research.org" ,(format-time-string "%Y-%m-%d" (current-time))) 
	   "* %(substring (current-time-string) 11 16) %?")
	  ("n" "note" entry
	   (file "notes.org")
	   "* %?")
	  ("P" "Private" entry
	   (file+headline "private/private.org" ,(format-time-string "%Y-%m-%d" (current-time)))
	   "* %(substring (current-time-string) 11 16) %i%?"
	   :immediate-finish t)
	  ("p" "Private" entry
	   (file+headline "private/private.org" ,(format-time-string "%Y-%m-%d" (current-time)))
	   "* %(substring (current-time-string) 11 16) %?")
	  ("d" "Diary" entry
	   (file "private/diary.org")
	   "* %t\n%?")
	  )))

;;; Org-download
(setq org-download-display-inline-images nil)
(setq-default org-download-image-dir "./images")
(with-eval-after-load 'org (org-download-enable))

;; Org Babel Dot(graphviz)
;; @REF: https://joy.pm/post/2017-09-17-a_graphviz_primer/
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t)))			; this line activates dot
  )

(defun my/fix-inline-images ()
  (when org-inline-image-overlays
    (org-redisplay-inline-images)))

(add-hook 'org-babel-after-execute-hook 'my/fix-inline-images)

;; Funcs

(defun fei-org-time ()
  (interactive)
  (if (not (boundp 'org-timer-start-time))
      (org-timer-start)
    (if (not org-timer-start-time)
	(org-timer-start)
      (call-interactively 'org-timer-pause-or-continue))))

;; Org-capture
(autoload 'org-capture-goto-target "org-capture")

(defun fei-org-capture ()
  (interactive)
  (call-interactively 'org-capture)
  (activate-input-method default-input-method))

(defun fei-org-capture-goto-Research ()
  (interactive)
  (org-capture-goto-target "K"))

(defun fei-org-capture-Research ()
  (interactive)
  (org-capture nil "K")
  (activate-input-method default-input-method))

(defun fei-org-capture-goto-SAR ()
  (interactive)
  (org-capture-goto-target "S"))

(defun fei-org-capture-SAR ()
  (interactive)
  (org-capture nil "S")
  (activate-input-method default-input-method))

(defun fei-org-capture-goto-WANT ()
  (interactive)
  (org-capture-goto-target "s"))

(defun fei-org-capture-TODO (&rest strings)
  (interactive)
  ;; (setq strings (eshell-flatten-and-stringify strings)) ;FIXME: 如果语句在这，strings 将总是会为 t
  (if strings
      (progn
	(setq strings (eshell-flatten-and-stringify strings))
        (org-capture-string strings "T") nil)
    (org-capture nil "t")
    (when (bound-and-true-p evil-mode)
      (evil-insert 0))
    (activate-input-method default-input-method)))

(defun fei-org-capture-WANT ()
  (interactive)
  (org-capture nil "s")
  (activate-input-method default-input-method))

(defun fei-org-capture-note (&rest strings)
  (interactive)
  ;; (setq strings (eshell-flatten-and-stringify strings)) ;FIXME: 如果语句在这，strings 将总是会为 t
  (if strings
      (progn
	(setq strings (eshell-flatten-and-stringify strings))
        (org-capture-string strings "P") nil)
    (org-capture nil "n")
    (when (bound-and-true-p evil-mode)
      (evil-insert 0))
    (activate-input-method default-input-method)))

(defun fei-org-capture-goto-note ()
  (interactive)
  (org-capture-goto-target "n"))

(defun fei-org-capture-goto-private ()
  (interactive)
  (org-capture-goto-target "p"))

(defun fei-org-capture-private ()
  (interactive)
  (org-capture nil "p")
  (when (bound-and-true-p evil-mode)
    (evil-insert 0))
  (activate-input-method default-input-method))

(defun fei-org-capture-diary ()
  (interactive)
  (org-capture nil "d")
  (when (bound-and-true-p evil-mode)
    (evil-insert 0))
  (activate-input-method default-input-method))

(defun fei-org-agenda ()
  (interactive)
  (org-agenda nil "a")
  (delete-other-windows))

(defun fei-activate-ime ()
  (cond
   (*is-windows*
    (w32-set-ime-open-status t))
   (*is-linux*
    (activate-input-method 'rime))))

(provide 'init-org)
;;; init-org-markdown.el ends here.
