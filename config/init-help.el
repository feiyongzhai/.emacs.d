(setq help-window-select t)		;always select help window

(global-set-key (kbd "C-h M-c") 'describe-char)
(global-set-key (kbd "C-h M-f") 'describe-face)
(global-set-key (kbd "C-h M-k") 'describe-keymap)
(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-i") 'info-display-manual)

(provide 'init-help)
