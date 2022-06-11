;; prog-mode-hook
(add-hook 'prog-mode-hook '+fei-prog-hook)
(defun +fei-prog-hook ()
  (outline-minor-mode t)
  (display-line-numbers-mode t)
  (company-mode t)
  (hl-line-mode t)
  (yas-minor-mode t))

(with-eval-after-load 'outline
  ;; use `add-file-local-variable' to change `outline-regexp' for a single file
  (global-set-key (kbd "C-c o") outline-mode-prefix-map)
  (global-set-key (kbd "C-c 2") outline-mode-prefix-map)
  (define-key outline-mode-prefix-map (kbd "o") 'counsel-outline))

(define-key prog-mode-map (kbd "M-RET") 'hs-toggle-hiding)
(define-key prog-mode-map (kbd "M-S-<return>") 'hs-show-block)

;; (global-subword-mode 1)

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
