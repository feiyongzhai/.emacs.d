(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Sandbox/Org/roam"))
  :bind (("C-c r l" . org-roam-buffer-toggle)
         ("C-c r f" . org-roam-node-find)
         ("C-c r g" . org-roam-graph)
         ("C-c r i" . org-roam-node-insert)
         ("C-c r c" . org-roam-capture)
         ;; Dailies
         ("C-c r j" . org-roam-dailies-capture-today)
         ("C-c r J" . org-roam-dailies-goto-today)
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
  :bind (("C-c r o" . org-roam-ui-open)))

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
