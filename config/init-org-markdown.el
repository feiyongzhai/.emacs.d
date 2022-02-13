;;; init-org-markdown.el == configs for Org/Markdown

(require 'fei-funcs)

;; @REF: http://0x100.club/wiki_emacs/emacs-tricks.html#orgb2882ba
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'yas-minor-mode)

;; Keys
(with-eval-after-load 'markdown-mode
  (fei-define-key-with-map markdown-mode-map
    '(
      ("M-s !" . markdown-insert-header-setext-1)
      ("M-s 1" . markdown-insert-header-atx-1)
      ("M-s 2" . markdown-insert-header-atx-2)
      ("M-s 3" . markdown-insert-header-atx-3)
      ("M-s 4" . markdown-insert-header-atx-4)
      ("M-s 5" . markdown-insert-header-atx-5)
      ("M-s 6" . markdown-insert-header-atx-6)
      ("M-s @" . markdown-insert-header-setext-2)
      ("<M-up>" . markdown-move-up)
      ("<M-down>" . markdown-move-down)
      )))

(global-set-key (kbd "<pause>") 'fei-org-time)
(global-set-key (kbd "C-c S") 'fei-org-store-link)

(global-set-key (kbd "M-z") 'fei-org-capture)
(global-set-key (kbd "<f1>") 'fei-org-capture-note)

(global-set-key (kbd "C-c a") (li (org-agenda nil "a")))
(global-set-key (kbd "C-c A") 'org-agenda)

(global-set-key (kbd "C-c c") 'fei-org-capture-note)
(global-set-key (kbd "C-c C") 'fei-org-capture)
(global-set-key (kbd "<f6>") 'fei-org-agenda)
(global-set-key (kbd "<f2>") 'fei-org-capture-SAR)
(global-set-key (kbd "<f9>") 'fei-org-capture-WANT)
(global-set-key (kbd "<f10>") 'fei-org-capture-SAR)

(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "k") 'fei-org-capture)
  (define-key org-agenda-mode-map (kbd "K") 'org-agenda-capture))

;;; Vars

(setq org-adapt-indentation nil)
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
	  ("I" "Inbox" entry
	   (file+headline "~/Nutstore Files/org/notes.org" "Inbox")
	   "* %i%?\nCREATE: %T\n"
	   :empty-lines-before 1 :immediate-finish t)
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
