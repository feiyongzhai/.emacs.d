(add-hook 'org-roam-find-file-hook 'fei-org-roam-hook)
(defun fei-org-roam-hook ()
  (activate-input-method 'rime))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Nutstore Files/org/roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today)
         ("C-c n J" . org-roam-dailies-goto-today)
	 )
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

;; (define-key org-roam-mode-map [mouse-1] #'org-roam-visit-thing)

(use-package org-roam-ui
  :ensure t
  :bind (("C-c n o" . org-roam-ui-open)))

;; (use-package org-roam-bibtex
;;   :ensure t
;;   :after org-roam
;;   :config
;;   (require 'org-ref)
;;   )

;; helm-bibtex

;; org-roam v2 的概念还是比较简单的，但是 org-roam-bibtex 的概念就显得
;; 很混乱。文献管理/笔记/引用 这几个功能组织的很乱（文档上可以体现这一点）。
;; 所以对于我来说，还没有到可用的阶段。

(provide 'init-roam)
