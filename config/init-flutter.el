(add-hook 'dart-mode-hook 'electric-pair-local-mode)
(add-hook 'dart-mode-hook 'subword-mode)
(with-eval-after-load 'dart-mode
  (define-key dart-mode-map (kbd "C-M-x") #'flutter-run-or-hot-reload))
(setq flutter-sdk-path "~/.local/opt/flutter/")
(setq lsp-dart-flutter-sdk-dir "~/.local/opt/flutter/")

(provide 'init-flutter)
