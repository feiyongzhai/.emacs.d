;; live-completions
(add-to-list 'load-path "~/Repos/live-completions")
(require 'live-completions)
(live-completions-mode)
(setq temp-buffer-max-height 10)
(temp-buffer-resize-mode)

(define-key minibuffer-local-map (kbd "C-M-i") 'switch-to-completions)
(define-key completion-list-mode-map (kbd "C-M-i") 'switch-to-minibuffer)

(provide 'init-live-completions)
