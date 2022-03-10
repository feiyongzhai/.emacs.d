(setq ahk-indentation 4)
(add-hook 'c-mode-hook 'electric-pair-local-mode)
(add-hook 'c++-mode-hook 'electric-pair-local-mode)

(add-hook 'prog-mode-hook '+fei-prog-hook)

(defun +fei-prog-hook ()
  (company-mode t)
  (yas-minor-mode t))

;; Octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)
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
(add-hook 'matlab-mode-hook 'highlight-indent-guides-mode)

(global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)

(setq mlint-programs '("mlint" "glnxa64/mlint" "/usr/local/MATLAB/R2020b/bin/glnxa64/mlint")
      matlab-show-mlint-warnings nil)

(provide 'init-prog)
