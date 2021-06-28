(require 'init-func)

;;; Keys

(fei-define-key-with-map global-map
  '(("C-c n l" . org-roam)
    ("C-c n f" . org-roam-find-file)
    ("C-c n g" . (lambda () (interactive) (browse-url "http://127.0.0.1:8080")))
    ("C-c n G" . org-roam-graph)))

(with-eval-after-load 'org
  (fei-define-key-with-map org-mode-map
    '(
      ("C-c n i" . org-roam-insert)
      ("C-c n I" . org-roam-insert-immediate)
      )))

;;; Vars

(setq org-roam-directory (file-truename "~/Nutstore Files/org/roam/"))

(provide 'init-org-roam)
