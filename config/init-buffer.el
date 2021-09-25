(fei-define-key-with-map global-map
  `(
    ("M-k" . fei-kill-current-buffer)
    ("C-x k" . kill-current-buffer)
    ("C-x K" . fei-kill-current-buffer)	; inspired by protesilaos
    ))


(provide 'init-buffer)
