(with-eval-after-load 'w3m
  (define-key w3m-mode-map (kbd "M-s") 'nil) ;default is `w3m-session-select'
  )

(provide 'init-w3m)
