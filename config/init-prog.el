(setq ahk-indentation 4)

(add-hook 'prog-mode-hook '+fei-prog-hook)
(defun +fei-prog-hook ()
  (display-line-numbers-mode t)
  (company-mode t)
  (yas-minor-mode t))

;; Octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)
(global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)


(provide 'init-prog)
