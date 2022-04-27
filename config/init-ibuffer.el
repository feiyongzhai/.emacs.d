;;; init-ibuffer.el  --- configs for ibuffer

(add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)

;;; Keys

(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line) ;was `ibuffer-jump-to-buffer'
  (define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line) ;was `ibuffer-kill-line'
  ;; (define-key ibuffer-mode-map (kbd "M-j") nil)
  )

(provide 'init-ibuffer)
