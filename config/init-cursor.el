(add-hook 'post-command-hook 'fei-change-cursor-when-readonly)
(defun fei-change-cursor-when-readonly ()
  (if buffer-read-only
      (setq cursor-type 'box)
    (setq cursor-type 'bar)))

(provide 'init-cursor)
