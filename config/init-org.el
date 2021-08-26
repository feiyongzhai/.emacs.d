;;; init-org.el

;; Keys
(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "k") 'fei-org-capture)
  (define-key org-agenda-mode-map (kbd "K") 'org-agenda-capture))

;;; Vars

;;; 使得 org 中的时间格式变成英文来规避乱码问题
(setq system-time-locale "C")

(setq org-default-notes-file "~/Nutstore Files/org/capture.org")

(setq org-agenda-files '("~/Nutstore Files/org"))

;;; org-capture-templates
(with-eval-after-load 'org-capture
  ;; 为什么我这里用 eval-after-load 就不能按照预期运行
  (setq org-capture-templates
	'(("t" "Task" entry
	   (file+headline "~/Nutstore Files/org/gtd.org" "Tasks") 
	   "* TODO %?\n  CREATE: %T\n"
	   :empty-lines-before 1)
	  ("s" "SAR" entry
	   (file+headline "~/Nutstore Files/org/SAR.org" "Inbox") 
	   "* TODO %?\n  CREATE: %T\n"
	   :empty-lines-before 1)
	  ("w" "Want" entry
	   (file+headline "~/Nutstore Files/org/gtd.org" "Tasks") 
	   "* WANT %?\n  CREATE: %T\n"
	   :empty-lines-before 1)
	  ("i" "Inbox" entry
	   (file+headline "~/Nutstore Files/org/notes.org" "Inbox")
	   "* %?\n  CREATE: %T\n"
	   :empty-lines-before 1)
	  ("d" "Diary" entry
	   (file "~/Nutstore Files/org/diary.org")
	   "* %t\n"
	   :empty-lines-before 1)
	  ("c" "Code Snippets")
	  ("ce" "Code Snippets for Emacs" entry
	   (file+headline "~/Nutstore Files/org/code-snippets.org" "Emacs")
	   "* %?\n  CREATE: %T\n  #+begin_src emacs-lisp\n%c\n  #+end_src"
	   :empty-lines-after 1)
	  ("co" "Code Snippets for Others" entry
	   (file+headline "~/Nutstore Files/org/code-snippets.org" "Others")
	   "* %?\n  CREATE: %T\n  #+begin_src shell\n%c\n  #+end_src"
	   :empty-lines-after 1))))

;;; Funcs

(defun fei-org-capture ()
  (interactive)
  ;; 这个写法可以传递prefix number，之前的不行
  (call-interactively 'org-capture)
  (require 'rime)
  (activate-input-method 'rime)
  (auto-fill-mode)
  (message "RIME输入法已经激活！"))

(when (display-graphic-p)
  (org-agenda nil "a")
  (delete-other-windows))
(add-hook 'server-after-make-frame-hook
	  (lambda () (when window-system
		       (org-agenda nil "a")
		       (delete-other-windows))))

;;; {{ org-download
(setq org-download-display-inline-images nil)
(setq-default org-download-image-dir "./images")
(org-download-enable)
;;; }}

;;; {{ org-roam
;;; Keys
(with-eval-after-load 'org
  (fei-define-key-with-map org-mode-map
    '(("C-c s" . org-store-link)
      ("C-c n i" . org-roam-insert)
      ("C-c n I" . org-roam-insert-immediate)
      )
    ))

(setq org-roam-directory (file-truename "~/Nutstore Files/org/roam/"))
;;; }}

(provide 'init-org)
;;; init-org.el ends here.
