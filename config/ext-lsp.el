(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(setq lsp-diagnostic-package :none)     ;不自动启用 flymake

(provide 'ext-lsp)
