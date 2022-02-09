;; (package-initialize)
;; (evil-mode)
(setq viper-mode t)
(require 'viper)
(ido-mode t)
(setq ido-everywhere t)

(global-set-key (kbd "<mouse-9>") 'neotree-toggle)
(global-set-key (kbd "<mouse-8>") 'fei-occur-at-point)
(global-set-key (kbd "C-M-s-~") 'speedbar)
(with-eval-after-load 'speedbar
  (define-key speedbar-mode-map (kbd "<mouse-8>") (kbd "b"))
  (define-key speedbar-mode-map (kbd "<mouse-9>") (kbd "f")))
