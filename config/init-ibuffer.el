(add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)

(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line) ;was `ibuffer-jump-to-buffer'
  (define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line) ;was `ibuffer-kill-line'
  )

(provide 'init-ibuffer)
