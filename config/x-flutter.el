(add-hook 'dart-mode-hook 'electric-pair-local-mode)
(add-hook 'dart-mode-hook 'subword-mode)

(setq flutter-sdk-path "~/.local/opt/flutter/")
(setq lsp-dart-flutter-sdk-dir "~/.local/opt/flutter/")

(provide 'x-flutter)
