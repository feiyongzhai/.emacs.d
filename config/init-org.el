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

  ;; (setq org-level-color-stars-only t)	;只高亮 stars
  )

(with-eval-after-load 'org
  ;; 控制 org-latex-preview
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
  (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
  )

(setq org-highlight-latex-and-related '(native)
      ;; org-ellipsis " ∇ "
      org-ellipsis " ↩"
      org-adapt-indentation nil)

;; 使得 org 中的时间格式变成英文来规避乱码问题
;; (setq system-time-locale "C")
(with-eval-after-load 'org
  ;; 统一 linux 和 windows 平台的时间戳显示
  ;; @REF: https://emacs-china.org/t/topic/1551/31?u=yongfeizhai
  (setq org-time-stamp-formats '("<%Y-%m-%d %A>" . "<%Y-%m-%d %A %H:%M>"))

  ;; org-mode 中的 C-c M-l 绑定到了 `org-insert-last-stored-link' 上
  ;; C-c s 用于想在 org-mode 中用 `org-store-link'
  (global-set-key (kbd "C-c M-l") 'org-store-link)
  (global-set-key (kbd "C-c s") 'org-store-link)
  )

(setq org-export-async-init-file (expand-file-name "~/.emacs.d/config/init-org-export.el"))
(setq org-default-notes-file "~/Nutstore Files/org/capture.org")
(setq org-agenda-files '("~/Nutstore Files/org"))
(setq org-refile-targets
      '((nil :maxlevel . 1)
	(org-agenda-files :maxlevel . 1)
	("~/Nutstore Files/org/private/private.org" :maxlevel . 1)))
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



(require 'fei-promodo "~/.emacs.d/extensions/fei/fei-promodo.el")
(setq org-clock-sound "~/Music/rings/ding0.wav")
(autoload 'org-timer-set-timer "org" t)


;; Keys
(global-set-key (kbd "<pause>") 'fei-org-time)
(global-set-key (kbd "<C-pause>") 'org-timer-set-timer)
(global-set-key (kbd "<M-pause>") 'fei-pomodoro-timer)
(global-set-key (kbd "ESC <pause>") 'fei-pomodoro-timer)
(global-set-key (kbd "C-S-y") 'org-download-clipboard)

(global-set-key (kbd "C-c a") (li (org-agenda nil "a")))
(global-set-key (kbd "C-c A") 'org-agenda)
(global-set-key (kbd "C-c c") 'fei-org-capture-TODO)
(global-set-key (kbd "C-c C") 'fei-org-capture)
(global-set-key (kbd "C-c n t") 'fei-org-capture-TODO)
(global-set-key (kbd "C-c n n") 'fei-org-capture-note)
(global-set-key (kbd "C-c n N") 'fei-org-capture-goto-note)
(global-set-key (kbd "C-c n j") 'fei-org-capture-private)
(global-set-key (kbd "C-c n J") 'fei-org-capture-goto-private)
(global-set-key (kbd "C-c n s") 'fei-org-capture-SAR)
(global-set-key (kbd "C-c n S") 'fei-org-capture-goto-SAR)
(global-set-key (kbd "C-c n w") 'fei-org-capture-WANT)
(global-set-key (kbd "C-c n W") 'fei-org-capture-goto-WANT)
(global-set-key (kbd "C-c n k") 'fei-org-capture-Research)
(global-set-key (kbd "C-c n K") 'fei-org-capture-goto-Research)

(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "k") 'fei-org-capture)
  (define-key org-agenda-mode-map (kbd "K") 'org-agenda-capture))

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
	   (file "gtd.org")
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
