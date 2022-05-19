;; tricks: =M-s h r= "\w*("

(custom-set-faces
 '(matlab-cellbreak-face ((t (:inherit font-lock-comment-face :weight bold)))))

(setq mlint-programs '("mlint" "glnxa64/mlint" "/usr/local/MATLAB/R2020b/bin/glnxa64/mlint")
      matlab-show-mlint-warnings nil)

;; Matlab
(setq matlab-indent-level 2)
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "M-s") nil)
  (define-key matlab-mode-map (kbd "M-j") nil)
  )

(add-hook 'matlab-mode-hook 'electric-pair-local-mode)
(add-hook 'matlab-mode-hook 'electric-spacing-mode)
(add-hook 'matlab-mode-hook 'hs-minor-mode)
(add-hook 'matlab-mode-hook 'yafolding-mode)
(add-hook 'matlab-mode-hook 'highlight-indentation-mode)
(add-hook 'matlab-mode-hook 'display-line-numbers-mode)
(add-hook 'matlab-mode-hook 'highlight-parentheses-mode)

(provide 'init-matlab)
