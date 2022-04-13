;;; init-ibuffer.el  --- configs for ibuffer

(add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)

;;; Keys

(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line) ;default is `ibuffer-jump-to-buffer' M-g bind this by default
  (define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line) ;default is `ibuffer-kill-line'
  (define-key ibuffer-mode-map (kbd "M-j") nil)
  )

(provide 'init-ibuffer)
