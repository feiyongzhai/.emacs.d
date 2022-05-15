(setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/.cargo/bin")))
(setq exec-path (append exec-path (list (expand-file-name "~/.cargo/bin"))))
(with-eval-after-load 'eshell
  (setq-default eshell-path-env (concat eshell-path-env ":" (expand-file-name "~/.cargo/bin"))))

(add-hook 'rust-mode-hook 'electric-pair-local-mode)

(provide 'init-rust)
