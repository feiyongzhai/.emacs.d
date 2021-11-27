;;; octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

(add-hook 'octave-mode-hook
	  (lambda ()
	    (progn
	      (setq octave-comment-char ?%)
	      (setq comment-start "% ")
	      (setq comment-add 0)
	      (setq comment-column 0)
	      )))

;;; matlab {{
(setq matlab-indent-level 2)
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "M-s") nil)
  (define-key matlab-mode-map (kbd "M-j") nil)
  (define-key matlab-mode-map (kbd "<C-return>") nil)
  (define-key matlab-mode-map (kbd "C-c .") nil)
  (define-key matlab-mode-map (kbd "C-c M-.") 'matlab-shell-locate-fcn)
  )
(add-hook 'matlab-mode-hook (lambda () (display-line-numbers-mode t)))

(add-hook 'matlab-mode-hook 'electric-pair-local-mode)
(with-eval-after-load 'matlab-mode
  (define-key matlab-mode-map (kbd "M-j") 'ivy-switch-buffer))

(provide 'init-matlab-octave)
