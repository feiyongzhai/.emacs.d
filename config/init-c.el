(add-hook 'c-mode-hook 'smartparens-strict-mode)
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'smartparens-strict-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)

(defun fei-g++-compile-and-run ()
  (interactive)
  (compile (format "g++ '%s' && ./a.out" (buffer-file-name)) t)
  (pop-to-buffer "*compilation*")
  (with-current-buffer "*compilation*"
    (goto-char (point-max))))

(provide 'init-c)
