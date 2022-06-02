(setq ahk-indentation 4)

;; (global-subword-mode 1)

(add-hook 'prog-mode-hook '+fei-prog-hook)
(defun +fei-prog-hook ()
  (display-line-numbers-mode t)
  (company-mode t)
  (hl-line-mode t)
  (yas-minor-mode t))

;; Octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)

;; Yaml
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)

(provide 'init-prog)
