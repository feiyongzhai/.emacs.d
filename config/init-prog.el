(setq ahk-indentation 4)
(add-hook 'c-mode-hook 'electric-pair-local-mode)
(add-hook 'c++-mode-hook 'electric-pair-local-mode)

;; Octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)
;; Matlab
(setq matlab-indent-level 2)
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "M-s") nil)
  (define-key matlab-mode-map (kbd "M-j") nil)
  )
(add-hook 'matlab-mode-hook (lambda () (display-line-numbers-mode t)))

(add-hook 'matlab-mode-hook 'electric-pair-local-mode)
(add-hook 'matlab-mode-hook 'electric-spacing-mode)

;; Python
(add-hook 'python-mode-hook 'electric-pair-local-mode)
(with-eval-after-load 'python
  (define-key python-mode-map (kbd "<f5>")
    (li (compile (concat "python3 " (buffer-file-name))))))


(provide 'init-prog)
