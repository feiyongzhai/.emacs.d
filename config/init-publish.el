;; Org-publish config
;; @REF: http://www.zhangjiee.com/blog/2019/build-site-with-org-mode.html

(global-set-key (kbd "C-c o p")
		;; load `init-publish.el' 以保证 preamble.html 的修改可以更新
		;; 这个和 elisp 的 backquote 的语法有关
		(li (load "init-publish.el") (call-interactively 'org-publish)))

(require 'ox-publish)
;; (setq org-html-validation-link nil)

(defun read-html-template (template-file)
  (with-temp-buffer
    (insert-file-contents (concat  "~/Repos/feiyongzhai.github.io/templates/" template-file))
    (buffer-string)))

(setq org-publish-project-alist
      `(
        ;; notes component
        ("blog-orgs"
         :base-directory "~/Repos/feiyongzhai.github.io/org"
         :base-extension "org"
         ;; :html-link-home "index.html"
         :publishing-directory "~/Repos/feiyongzhai.github.io/html"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 5
         :auto-preamble t
	 :html-preamble ,(read-html-template "preamble.html")
	 :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/style.css\" />"
         :auto-sitemap t
         ;; :sitemap-filename "sitemap.org"
         ;; :sitemap-title "Sitemap"
         )
        ;; images component
        ("blog-images"
         :base-directory "~/Repos/feiyongzhai.github.io/org/"
         :base-extension "png\\|jpg\\|gif\\|pdf"
         :publishing-directory "~/Repos/feiyongzhai.github.io/html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ;; publish component
        ("blog" :components ("blog-orgs" "blog-images"))
        ))

(provide 'init-publish)
