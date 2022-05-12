(setq ahk-indentation 4)

(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook '+fei-prog-hook)
(defun +fei-prog-hook ()
  (display-line-numbers-mode t)
  (company-mode t)
  (hl-line-mode t)
  (yas-minor-mode t))

;; Octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)

(provide 'init-prog)
