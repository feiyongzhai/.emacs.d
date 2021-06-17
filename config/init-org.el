;;; init-org.el

;;; Code(Myself):

;;; Keys

(global-set-key (kbd "C-c c") 'fei-org-capture)
(global-set-key (kbd "<f5>") 'fei-org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)

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
	  ("i" "Inbox" entry
	   (file+headline "~/Nutstore Files/org/notes.org" "Inbox")
	   "* %?\n  CREATE: %T\n"
	   :empty-lines-before 1)
	  ("s" "Code Snippets")
	  ("se" "Code Snippets for Emacs" entry
	   (file+headline "~/Nutstore Files/org/code-snippets.org" "Emacs")
	   "* %?\n  CREATE: %T\n  #+begin_src emacs-lisp\n%c\n  #+end_src"
	   :empty-lines-after 1)
	  ("so" "Code Snippets for Others" entry
	   (file+headline "~/Nutstore Files/org/code-snippets.org" "Others")
	   "* %?\n  CREATE: %T\n  #+begin_src shell\n%c\n  #+end_src"
	   :empty-lines-after 1))))

;;; Funcs

(defun fei-org-capture ()
  (interactive)
  ;; 这个写法可以传递prefix number，之前的不行
  (call-interactively 'org-capture)
  (activate-input-method 'rime)
  (auto-fill-mode)
  (message "RIME输入法已经激活！"))



(provide 'init-org)
;;; init-org.el ends here.
