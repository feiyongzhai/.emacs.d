;;; init-org.el == configs for Org/Markdown
(require 'fei-funcs)

(with-eval-after-load 'org
  ;; 控制 org-latex-preview
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
  )
(setq org-highlight-latex-and-related '(native)
      org-ellipsis "  "
      org-adapt-indentation nil)
;; 使得 org 中的时间格式变成英文来规避乱码问题
(setq system-time-locale "C")
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

(add-hook 'org-mode-hook '+fei-org-mode-hook)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
(defun +fei-org-mode-hook ()
  ;; (org-indent-mode) ;@REF: http://0x100.club/wiki_emacs/emacs-tricks.html#orgb2882ba
  (yas-minor-mode)
  (setq-local line-spacing 3) ;当有大段文字的时候，行与行之间的间距太小的话看起来会比较累
  (toggle-truncate-lines -1))

;; Keys
(global-set-key (kbd "<pause>") 'fei-org-time)
(global-set-key (kbd "C-c S") 'fei-org-store-link)

(global-set-key (kbd "C-c a") (li (org-agenda nil "a")))
(global-set-key (kbd "C-c A") 'org-agenda)
(global-set-key (kbd "C-c c") 'fei-org-capture-note)
(global-set-key (kbd "C-c C") 'fei-org-capture)
(global-set-key (kbd "C-c n n") 'fei-org-capture-note)
(global-set-key (kbd "C-c n p") 'fei-org-capture-private)
(global-set-key (kbd "C-c n s") 'fei-org-capture-SAR)
(global-set-key (kbd "C-c n w") 'fei-org-capture-WANT)
(global-set-key (kbd "C-c n k") 'fei-org-capture-Research)

(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "k") 'fei-org-capture)
  (define-key org-agenda-mode-map (kbd "K") 'org-agenda-capture))

;;; org-capture-templates
(with-eval-after-load 'org-capture
  ;; 为什么我这里用 eval-after-load 就不能按照预期运行
  (setq org-capture-templates
	`(("t" "Task" entry
	   (file+headline "~/Nutstore Files/org/gtd.org" "Tasks") 
	   "* TODO %?\nCREATE: %T\n"
	   :empty-lines-before 1)
	  ("s" "SomeDay" entry
	   (file "~/Nutstore Files/org/gtd.org") 
	   "* SOMEDAY %?\nCREATE: %T\n"
	   :empty-lines-before 1)
	  ("S" "SAR" entry
	   (file+headline "~/Nutstore Files/org/SAR.org" "Inbox") 
	   "* TODO %?\nCREATE: %T\n"
	   :empty-lines-before 1)
	  ("K" "Research" entry
	   (file+headline "~/Nutstore Files/org/private/Research.org" ,(format-time-string "%Y-%m-%d" (current-time))) 
	   "* %(substring (current-time-string) 11 16) %?"
	   :empty-lines-before 1)
	  ("i" "Inbox" entry
	   (file+headline "~/Nutstore Files/org/notes.org" "Inbox")
	   "* CREATE: %U\n%?"
	   :empty-lines-before 1)
	  ("P" "Private" entry
	   (file+headline "~/Nutstore Files/org/private/private.org" ,(format-time-string "%Y-%m-%d" (current-time)))
	   "* %(substring (current-time-string) 11 16) %?"
	   :empty-lines-before 1 :immediate-finish t)
	  ("p" "Private" entry
	   (file+headline "~/Nutstore Files/org/private/private.org" ,(format-time-string "%Y-%m-%d" (current-time)))
	   "* %(substring (current-time-string) 11 16) %?"
	   :empty-lines-before 1)
	  ("d" "Diary" entry
	   (file "~/Nutstore Files/org/private/diary.org")
	   "* %t\n%?"
	   :empty-lines-before 1)
	  ("c" "Code Snippets")
	  ("ce" "Code Snippets for Emacs" entry
	   (file+headline "~/Nutstore Files/org/snippets.org" "Emacs")
	   "* %?CREATE: %T\n#+begin_src emacs-lisp\n%^C\n#+end_src"
	   :empty-lines-after 1)
	  ("co" "Code Snippets for Others" entry
	   (file+headline "~/Nutstore Files/org/snippets.org" "Others")
	   "* %?\nCREATE: %T\n#+begin_src shell\n%^C\n#+end_src"
	   :empty-lines-after 1))))

;;; Org-download
(setq org-download-display-inline-images nil)
(setq-default org-download-image-dir "./images")
(org-download-enable)

(provide 'init-org)
;;; init-org-markdown.el ends here.
