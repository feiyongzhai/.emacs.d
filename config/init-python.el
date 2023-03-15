(when *is-linux*
  ;; based on the conda install location
  (setq conda-env-home-directory "~/.conda/")
  (setq conda-anaconda-home "/opt/miniconda")

  ;; this config is prepared for `pyvenv-workon'
  (setenv "WORKON_HOME" "~/Sandbox/Python/virtualenv")
  )

;; 看网上的讨论 yafolding-mode 只是单纯的根据缩进折叠，所以只在 python 中启用了
(add-hook 'python-mode-hook 'yafolding-mode)
(add-hook 'python-mode-hook 'highlight-indentation-mode)
(add-hook 'python-mode-hook 'electric-pair-local-mode)
(add-hook 'inferior-python-mode-hook 'electric-pair-local-mode)

;; 发现下面的需求可以用 set-goal-column 巧妙解决

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
