(add-hook 'c-mode-hook 'smartparens-strict-mode)
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'smartparens-strict-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)

(defun fei-g++-compile-and-run ()
  (interactive)
  (save-buffer (current-buffer))
  (compile
   (format
    ;; 不知道在 windows 平台为什么必须是双引号，单引号不行；但在 powershell 或 eshell 中单双引号都可以。
    ;; 目前猜测是 compile 中对于单双引号在不同系统的解析方式不同。
    (cond (*is-linux* "%s '%s' && ./a.out")
          (*is-windows* "%s \"%s\" && a.exe"))
    (if (eq major-mode 'c-mode) "gcc" "g++")
    (buffer-file-name))
   t)
  (pop-to-buffer "*compilation*" '(nil (window-height . 0.3)))
  (with-current-buffer "*compilation*"
    (goto-char (point-max))))

(provide 'init-c)
