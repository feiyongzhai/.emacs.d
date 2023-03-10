;; prog-mode-hook
(add-hook 'prog-mode-hook '+fei-prog-hook)
(defun +fei-prog-hook ()
  (outline-minor-mode t)
  (display-line-numbers-mode t)
  (company-mode t)
  (hl-line-mode t)
  (yas-minor-mode t))

;; use `add-file-local-variable' to change `outline-regexp' for a single file

(define-key prog-mode-map (kbd "M-RET") 'hs-toggle-hiding)
(define-key prog-mode-map (kbd "M-S-<return>") 'hs-hide-all)

;; Octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)

;; Yaml
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)

;; AHK
(setq ahk-indentation 4)

(provide 'init-prog)

;; Local Variables:
;; outline-regexp: ";;+"
;; End:
