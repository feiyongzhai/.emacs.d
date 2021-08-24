;;; Keys
(with-eval-after-load 'org
  (fei-define-key-with-map org-mode-map
    '(("C-c s" . org-store-link)
      ("C-c n i" . org-roam-insert)
      ("C-c n I" . org-roam-insert-immediate)
      ))
  )

(setq org-roam-directory (file-truename "~/Nutstore Files/org/roam/"))

(provide 'init-org-roam)
