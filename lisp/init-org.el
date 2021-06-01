;;; init-org.el

;;; Code(Myself):

;;; 使得 org 中的时间格式变成英文来规避乱码问题
(setq system-time-locale "C")

;; relocate the org default notes file, which make it easily control
(setq org-default-notes-file "~/Nutstore Files/org/capture.org")

(setq org-agenda-files '("~/Nutstore Files/org"))
;; 按键
(global-set-key (kbd "C-c a") 'org-agenda)

;;; org-capture-templates
(with-eval-after-load 'org-capture
  ;; 为什么我这里用 eval-after-load 就不能按照预期运行
  (setq org-capture-templates
	'(("t" "Task" entry
	   (file+headline "~/Nutstore Files/org/gtd.org" "Tasks") 
	   "* TODO %?\n  CREATE: %T\n  %a"
	   :empty-lines-before 1)
	  ("i" "Idea" entry
	   (file+headline "~/Nutstore Files/org/notes.org" "Ideas")
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
;; 按键
(global-set-key (kbd "C-c c") 'fei-org-capture)
(define-key global-map (kbd "<f5>") 'fei-org-capture)

(defun fei-org-capture ()
  (interactive)
  (org-capture)
  (activate-input-method 'rime)
  (message "RIME输入法已经激活！"))

;;; config for org-bullets
(add-hook 'org-mode-hook #'org-bullets-mode)

;;; Code(Copy):

;;; 参考链接：https://guidao.github.io/emacs_blog.html#org38eccd7
(setq org-publish-project-alist
        '(
          ;; ... add all the components here (see below)...
          ("org-notes"
           :base-directory "~/feiyongzhai.github.io/org/" ;org文件的目录
           :base-extension "org" ;扩展名
           :publishing-directory "~/feiyongzhai.github.io/" ;导出目录
           :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"./css/org-css.css\"/>";自定义样式
           :recursive t
           :publishing-function org-html-publish-to-html
           :headline-levels 4             ; Just the default for this project.
           :auto-preamble t
           :timestamp nil
           :author nil
           )
          ("org" :components ("org-notes"))
          ))

(setq org-html-validation-link nil) ; 去掉validation显示
(setq org-html-link-home "index.html"); 设置home超链接
(setq org-html-link-up "index.html")

(provide 'init-org)
;;; init-org.el ends here.
