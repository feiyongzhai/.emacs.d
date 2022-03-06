;; -*- lexical-binding: t; -*-

(fido-mode)
(fido-vertical-mode)
(setq icomplete-compute-delay 0.01)
(define-key icomplete-fido-mode-map (kbd "C-M-j") 'icomplete-fido-exit)

(provide 'init-icomplete)
