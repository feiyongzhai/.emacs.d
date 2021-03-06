(add-hook 'org-roam-find-file-hook 'fei-org-roam-hook)
(defun fei-org-roam-hook ()
  (activate-input-method 'rime))

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %(substring (current-time-string) 11 16) %?" :target
	 (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

(setq org-roam-directory (file-truename "~/Nutstore Files/org/roam"))

(fei-define-key-with-map global-map
  '(("C-c n l" . org-roam-buffer-toggle)
    ("C-c n f" . org-roam-node-ivy-find)
    ("C-c n g" . org-roam-graph)
    ("C-c n i" . org-roam-node-insert)
    ("C-c n c" . org-roam-capture)
    ("C-c n a" . org-roam-alias-add)
    ("C-c n t" . org-roam-tag-add)
    ("C-c n r" . org-roam-node-random)
    ;; org-id-get-create
    ;; org-roam-refile
    ("C-c n o" . org-roam-ui-open)
    ))

(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
(org-roam-db-autosync-mode)
(require 'org-roam-protocol) ;; If using org-roam-protocol

;;; Funcs
(defun org-roam-node-ivy-find ()
  (interactive)
  (let ((completing-read-function 'ivy-completing-read))
    (call-interactively 'org-roam-node-find)))

;;; Misc

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
