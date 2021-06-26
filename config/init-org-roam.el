(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      (after-init . org-roam-server-mode)
      :custom
      (org-roam-directory (file-truename "~/Nutstore Files/org/roam/"))
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . (lambda () (interactive) (browse-url "http://127.0.0.1:8080")))
	       ("C-c n G" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(provide 'init-org-roam)
