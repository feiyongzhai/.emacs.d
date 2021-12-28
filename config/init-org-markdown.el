;;; init-org-markdown.el == configs for Org/Markdown

(require 'fei-funcs)

;; @REF: http://0x100.club/wiki_emacs/emacs-tricks.html#orgb2882ba
(add-hook 'org-mode-hook 'org-indent-mode)

;; Keys
(with-eval-after-load 'markdown-mode
  (fei-define-key-with-map markdown-mode-map
    '(
      ("C-c !" . markdown-insert-header-setext-1)
      ("C-c 1" . markdown-insert-header-atx-1)
      ("C-c 2" . markdown-insert-header-atx-2)
      ("C-c 3" . markdown-insert-header-atx-3)
      ("C-c 4" . markdown-insert-header-atx-4)
      ("C-c 5" . markdown-insert-header-atx-5)
      ("C-c 6" . markdown-insert-header-atx-6)
      ("C-c @" . markdown-insert-header-setext-2)
      ("C-c H" . markdown-insert-header-setext-dwim)
      ("C-c h" . markdown-insert-header-dwim)
      ("C-c s" . markdown-insert-header-setext-2)
      ("C-c t" . markdown-insert-header-setext-1)
      ("<M-up>" . markdown-move-up)
      ("<M-down>" . markdown-move-down)
      )))

(global-set-key (kbd "<pause>") 'fei-org-time)
(global-set-key (kbd "C-c s") 'fei-org-store-link)

(global-set-key (kbd "M-z") 'fei-org-capture)
(global-set-key (kbd "<f1>") 'fei-org-capture-note)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'fei-org-capture)
(global-set-key (kbd "<f2>") 'fei-org-capture-SAR)
(global-set-key (kbd "<f10>") 'fei-org-capture-SAR)
(global-set-key (kbd "<f9>") 'fei-org-capture-WANT)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "M-h") nil))
(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "k") 'fei-org-capture)
  (define-key org-agenda-mode-map (kbd "K") 'org-agenda-capture))

;;; Vars

;; 使得 org 中的时间格式变成英文来规避乱码问题
(setq system-time-locale "C")
(setq org-default-notes-file "~/Nutstore Files/org/capture.org")
(setq org-agenda-files '("~/Nutstore Files/org"))
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

;;; org-capture-templates
(with-eval-after-load 'org-capture
  ;; 为什么我这里用 eval-after-load 就不能按照预期运行
  (setq org-capture-templates
	'(("t" "Task" entry
	   (file+headline "~/Nutstore Files/org/gtd.org" "Tasks") 
	   "* TODO %?\nCREATE: %T\n"
	   :empty-lines-before 1)
	  ("s" "SomeDay" entry
	   (file+headline "~/Nutstore Files/org/gtd.org" "Tasks") 
	   "* SOMEDAY %?\nCREATE: %T\n"
	   :empty-lines-before 1)
	  ("S" "SAR" entry
	   (file+headline "~/Nutstore Files/org/SAR.org" "Inbox") 
	   "* TODO %?\nCREATE: %T\n"
	   :empty-lines-before 1)
	  ("i" "Inbox" entry
	   (file+headline "~/Nutstore Files/org/notes.org" "Inbox")
	   "* %?\nCREATE: %T\n"
	   :empty-lines-before 1)
	  ("d" "Diary" entry
	   (file "~/Nutstore Files/org/diary.org")
	   "* %t\n%?"
	   :empty-lines-before 1)
	  ("c" "Code Snippets")
	  ("ce" "Code Snippets for Emacs" entry
	   (file+headline "~/Nutstore Files/org/snippets.org" "Emacs")
	   "* %?\nCREATE: %T\n#+begin_src emacs-lisp\n%c\n#+end_src"
	   :empty-lines-after 1)
	  ("co" "Code Snippets for Others" entry
	   (file+headline "~/Nutstore Files/org/snippets.org" "Others")
	   "* %?\nCREATE: %T\n#+begin_src shell\n%c\n#+end_src"
	   :empty-lines-after 1))))

;;; Org-download
(setq org-download-display-inline-images nil)
(setq-default org-download-image-dir "./images")
(org-download-enable)

(provide 'init-org-markdown)
;;; init-org-markdown.el ends here.
