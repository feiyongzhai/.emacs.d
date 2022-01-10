(setq ahk-indentation 4)
(add-hook 'c-mode-hook 'electric-pair-local-mode)
(add-hook 'c++-mode-hook 'electric-pair-local-mode)
(add-hook 'python-mode-hook 'electric-pair-local-mode)

;; octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)
;; matlab
(setq matlab-indent-level 2)
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "M-s") nil)
  (define-key matlab-mode-map (kbd "M-j") nil)
  )
(add-hook 'matlab-mode-hook (lambda () (display-line-numbers-mode t)))

(add-hook 'matlab-mode-hook 'electric-pair-local-mode)
(add-hook 'matlab-mode-hook 'electric-spacing-mode)


(provide 'init-prog)
