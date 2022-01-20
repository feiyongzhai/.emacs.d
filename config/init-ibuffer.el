;;; init-ibuffer.el  --- configs for ibuffer

;;; Keys

(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line)
  (define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line)
  (define-key ibuffer-mode-map (kbd "M-j") nil)
  )

(provide 'init-ibuffer)
