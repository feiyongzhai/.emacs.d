;;; init-org.el == configs for Org/Markdown
(require 'fei-funcs)

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
(add-hook 'org-mode-hook '+fei-org-mode-hook)

(defun +fei-org-mode-hook ()
  (yas-minor-mode)
  (smartparens-mode)			;方便快速输入 =+_ 等强调符号
  (org-indent-mode)			;试试这个默认样式
  (setq tab-width 2))

(with-eval-after-load 'org		;控制 org-latex-preview
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
  (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot)))

;; (setq system-time-locale "C") ;使得 org 中的时间格式变成英文来规避乱码问题
(with-eval-after-load 'org
  ;; 统一 linux 和 windows 平台的时间戳显示
  ;; @REF: https://emacs-china.org/t/topic/1551/31?u=yongfeizhai
  (setq org-time-stamp-formats '("<%Y-%m-%d %A>" . "<%Y-%m-%d %A %H:%M>"))

  ;; org-mode 中的 C-c M-l 绑定到了 `org-insert-last-stored-link' 上
  ;; C-c s 用于想在 org-mode 中用 `org-store-link'
  )

(setq org-default-notes-file "~/Nutstore Files/org/capture.org")
(setq org-refile-targets
      '((nil :maxlevel . 1)
	(org-agenda-files :maxlevel . 1)
	("~/Nutstore Files/org/notes.org" :level . 1)
	("~/Nutstore Files/org/inbox.org" :level . 0)
	("~/Nutstore Files/org/private/private.org" :maxlevel . 1)))

(defun fei-org-refile-to-file ()
  (interactive)
  (let ((org-refile-use-outline-path 'file))
    (call-interactively 'org-refile)))

;;; ==== Org Agenda 配置开始 ===
;; @SEEALSO: https://stackoverflow.com/questions/32423127/how-to-view-the-next-days-in-org-modes-agenda
(setq org-agenda-span 3)		;控制显示的天数
(setq org-agenda-start-day "-1d")
(add-hook 'org-agenda-mode-hook 'fei/org-agenda-mode-hook)
(defun fei/org-agenda-mode-hook ()
  (hl-line-mode)
  (toggle-truncate-lines 1))

;;; org-agenda 完成任务时, 将其划线勾掉
;; (with-eval-after-load 'org-agenda
;;   (set-face-attribute 'org-agenda-done nil :strike-through t))

(defvar fei/agenda-hide-done-flag nil)
(defun fei-org-agenda-toggle-done-entry ()
  (interactive)
  (if fei/agenda-hide-done-flag
      (progn
	(setq fei/agenda-hide-done-flag nil)
	(setq org-agenda-skip-timestamp-if-done nil)
	(setq org-agenda-skip-deadline-if-done nil)
	(setq org-agenda-skip-scheduled-if-done nil))
    (setq fei/agenda-hide-done-flag t)
    (setq org-agenda-skip-timestamp-if-done t)
    (setq org-agenda-skip-deadline-if-done t)
    (setq org-agenda-skip-scheduled-if-done t))
  (org-agenda-redo))

(defun fei-org-agenda-refile-to-file ()
  (interactive)
  (let ((org-refile-use-outline-path 'file))
    (call-interactively 'org-agenda-refile)))

(setq org-agenda-use-time-grid nil)
(setq org-agenda-window-setup 'current-window)
(setq org-agenda-files '("~/Nutstore Files/org/gtd.org" "~/Nutstore Files/org/work.org"))

(defun fei/org-agenda-next-line ()
  "Move cursor to the next line, and show if follow mode is active."
  (interactive)
  (call-interactively 'next-line)
  (org-agenda-do-context-action)
  (fei/echo-line))

(defun fei/org-agenda-prev-line ()
  "Move cursor to the next line, and show if follow mode is active."
  (interactive)
  (call-interactively 'previous-line)
  (org-agenda-do-context-action)
  (fei/echo-line))
;; ==== Org Agenda 配置结束 ===

;; 修改 Org 中一些关键词的样式
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

;; (setq org-level-color-stars-only t)	;只高亮 stars
;; (setq org-hide-leading-stars t)
(setq org-fontify-quote-and-verse-blocks t) ;给 quote 和 verse block 添加样式
(setq org-log-into-drawer t)		;把 log 放到 drawer 中，看起来更规整一些
(setq org-highlight-latex-and-related '(native)
      ;; org-ellipsis " ∇ "
      org-ellipsis " ↩"
      org-adapt-indentation nil)

;; 设置各个标题的大小，不使用配色来区分 headline 层级

;; 受观点（REF1）的影响和促动，决定还是把 org-mode 搞得简单一点，朴素一点，不太在意 org-mode 长什么样，而是在意我要干什么。
;; 把重点从 EMACS 的身上转移到我真正要做的事情身上
;; @REF1: https://emacs-china.org/t/emacs/23849/94?u=yongfeizhai

;; (custom-set-faces
;;  '(org-level-1 ((t (:weight extra-bold :height 1.25))))
;;  '(org-level-2 ((t (:weight bold :height 1.15))))
;;  '(org-level-3 ((t (:weight bold :height 1.12))))
;;  '(org-level-4 ((t (:weight semi-bold :height 1.09))))
;;  '(org-level-5 ((t (:weight semi-bold :height 1.06))))
;;  '(org-level-6 ((t (:weight semi-bold :height 1.03))))
;;  '(org-level-8 ((t (:weight semi-bold)))))

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

;;; ==== Org Export 配置开始 ====

;; @REF: https://emacs-china.org/t/org-mode-pdf/16746/2
(setq org-export-async-init-file (expand-file-name "~/.emacs.d/misc/fei-org-export.el"))
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("ctexart" "\\documentclass[11pt]{ctexart}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (setq org-latex-default-class "ctexart")
  (setq org-latex-compiler "xelatex"))

(with-eval-after-load 'ox
  (require 'ox-beamer) ;没有这一行在 ox-dispatcher 中不会显示 ox-beamer 的选项
  (add-to-list 'org-latex-classes
               '("beamer" "\\documentclass[presentation]{ctexbeamer}"
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(with-eval-after-load 'org
  ;; @REF: https://emacs.stackexchange.com/questions/17988/variable-to-set-org-export-pdf-viewer
  (when *is-linux*
    ;; 指定 org-export 后打开 pdf 的软件
    (add-to-list 'org-file-apps '("\\.pdf" . "evince %s"))))

;;; Hack: org 中文格式去除需要添加空格的限制，以及相应的 org-export 配置
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

;;; Hack: 关于 org-export 是对于换行符号的处理
;; latex 中的 xelatex 可以自己处理换行，所以在 emacs 这边不需要多余的处理
;; html 不会，所以需要在 emacs 这边进行一些配置
;; @NOTE: 配置可能存在潜在风险，出现问题的留意观察该部分
;; @REF: https://emacs-china.org/t/org-mode-html/7174
;; @REF: https://emacs-china.org/t/org-mode-html/7174/2?u=yongfeizhai
;; @REF: https://github.com/syl20bnr/spacemacs/blob/84d649ac2e5e6de508d3e5b57be38b6e00d5cdc1/layers/%2Bintl/chinese/packages.el#L131
;; 1. 一种方式是：#+options: \n:t
;; 2. 另一种方式如下
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

;;; ==== Org Export 配置结束 ====

(require 'fei-pomodoro "~/.emacs.d/extensions/fei/fei-pomodoro.el")
(setq org-clock-sound "~/Music/rings/ding0.wav")
(autoload 'org-timer-set-timer "org" t)
(setq org-directory "~/Nutstore Files/org")
(setq org-archive-default-command 'org-archive-set-tag)

;;; org-capture-templates
(with-eval-after-load 'org-capture
  ;; 为什么我这里用 eval-after-load 就不能按照预期运行
  (setq org-capture-templates
	`(("t" "Task" entry (file "gtd.org") "* TODO %?\nCREATE: %T\n")
	  ("l" "Log" entry (file "gtd.org") "* %?\nCREATE: %T\n")
	  ("r" "Subtask for current clocked entry" entry (clock) "* SUBTODO %?\nCREATE: %T\n")
	  ("T" "Task(为Eshell设计)" entry (file "gtd.org")
	   "* TODO %i\nCREATE: %T\n"
	   :immediate-finish t)
	  ("c" "Canvas" entry (file "question.org")
	   "* %(fei-generate-obsidian-canvas-uuid-link) %?"
	   ;; 可以用 C-u C-c C-c 跳过去，自动跳过去有点烦
	   ;; :jump-to-captured t
	   )
	  ("n" "note" entry (file "notes.org") "* %?")
	  ("p" "Private" entry
	   (file+headline "private/private.org"
			  ,(format-time-string "%Y-%m-%d" (current-time)))
	   "* %(substring (current-time-string) 11 16) %?")
	  ("P" "Private" entry
	   (file+headline "private/private.org"
			  ,(format-time-string "%Y-%m-%d" (current-time)))
	   "* %(substring (current-time-string) 11 16) %i%?"
	   :immediate-finish t)
	  ("s" "SomeDay" entry (file "inbox.org") "* SOMEDAY %?\nCREATE: %T\n"
	   :kill-buffer t)
	  ("K" "Work" entry (file "work.org") "* TODO %?\nCREATE: %T\n")
	  ("d" "Diary" entry (file "private/diary.org") "* %t\n%?")
	  )))

(defun fei-generate-obsidian-canvas-uuid-link ()
  "Designed for org-capture-templates"
  (concat "[["
	  "obsidian://new?vault=obsidian"
	  "&file="     ;注意：? 和 & 不可以放到 `url-hexify-string' 里
	  (url-hexify-string "白板/")
	  (org-id-uuid)
	  ".canvas"
	  "&overwrite" ;复用已经存在的文件
	  "][白板]]"
	  ;; note: 使用 ?path 参数并不能实现在指定文件夹创建文件，所以
	  ;; 只能采用制定 vault + file 的方式来实现，可能缺乏一定灵活
	  ;; 性：不能适应多 vault 的情况。
	  ))

(defun insert-fei-generate-obsidian-canvas-uuid-link ()
  (interactive)
  (insert (fei-generate-obsidian-canvas-uuid-link)))

;;; ==== Org-download ====
(setq org-download-display-inline-images nil)
(setq-default org-download-image-dir "./images")
(setq org-download-method 'attach)
(with-eval-after-load 'org (org-download-enable))

;;; ==== Org Babel Dot(graphviz) ====
;; @REF: https://joy.pm/post/2017-09-17-a_graphviz_primer/
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t)))			;this line activates dot
  )

(add-hook 'org-babel-after-execute-hook 'my/fix-inline-images)

(defun my/fix-inline-images ()
  (when org-inline-image-overlays
    (org-redisplay-inline-images)))

;; ==== Org time related ====
(defun fei-org-time ()
  (interactive)
  (if (not (boundp 'org-timer-start-time))
      (org-timer-start)
    (if (not org-timer-start-time)
	(org-timer-start)
      (call-interactively 'org-timer-pause-or-continue))))

;;; Org-capture 相关配置
(autoload 'org-capture-goto-target "org-capture")

(defun fei-org-capture ()
  (interactive)
  (call-interactively 'org-capture)
  (activate-input-method default-input-method))

(defun fei-org-capture-log ()
  (interactive)
  (org-capture nil "l")
  (activate-input-method default-input-method))

(defun fei-org-capture-goto-log ()
  (interactive)
  (org-capture-goto-target "l"))

(defun fei-org-capture-work ()
  (interactive)
  (org-capture nil "K")
  (activate-input-method default-input-method))

(defun fei-org-capture-goto-work ()
  (interactive)
  (org-capture-goto-target "K"))

(defun fei-org-capture-clock ()
  (interactive)
  (org-capture nil "r")
  (activate-input-method default-input-method))

(defun fei-org-capture-canvas ()
  (interactive)
  (org-capture nil "c")
  (activate-input-method default-input-method))

(defun fei-org-capture-goto-canvas ()
  (interactive)
  (org-capture-goto-target "c"))

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

(defun fei-org-capture-goto-WANT ()
  (interactive)
  (org-capture-goto-target "s"))

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

(defun fei-org-capture-private ()
  (interactive)
  (org-capture nil "p")
  (when (bound-and-true-p evil-mode)
    (evil-insert 0))
  (activate-input-method default-input-method))

(defun fei-org-capture-goto-private ()
  (interactive)
  (org-capture-goto-target "p"))

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

;;; ==== work with obsidian ====
(with-eval-after-load 'org
  ;; 目前在笔记本 manjaro 平台做了测试

  ;; obsidian link handling for obsidian:// links
  (defun org-obsidian-link-open (slash-message-id)
    "Handler for org-link-set-parameters that opens a obsidian:// link in obsidian"
    (browse-url (concat "obsidian:" slash-message-id)))

  ;; on obsidian://aoeu link, this will call handler with //aoeu
  (org-link-set-parameters "obsidian" :follow #'org-obsidian-link-open))

(provide 'init-org)
