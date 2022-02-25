;; this config is prepared for `pyvenv-workon'
(setenv "WORKON_HOME" "~/Sandbox/Python/virtualenv")

;; Python
(add-hook 'python-mode-hook 'electric-pair-local-mode)
(with-eval-after-load 'python
  (define-key python-mode-map (kbd "<f5>") (li (compile (concat "python3 " (buffer-file-name)))))
  )

(define-key prog-mode-map (kbd "M-n") 'jump-to-same-indent)
(define-key prog-mode-map (kbd "M-p") 'jump-back-to-same-indent)

;; @REF1: https://superuser.com/questions/1017094/emacs-jump-to-the-next-line-with-same-indentation
;; @REF2: https://emacs.stackexchange.com/questions/20900/navigate-by-indentation

(defun jump-to-same-indent (direction)
  (interactive "P")
  (let ((start-indent (current-indentation)))
    (while
	(and (not (bobp))
             (zerop (forward-line (or direction 1)))
             (or (= (current-indentation) 0)
		 (> (current-indentation) start-indent)))))
  (back-to-indentation))

(defun jump-back-to-same-indent ()
  (interactive)
  (jump-to-same-indent -1))

(provide 'init-python)
