(setq help-window-select t)		;always select help window
(global-set-key (kbd "C-h M-f") 'describe-face)
(global-set-key (kbd "C-h M-k") 'describe-keymap)
(global-set-key (kbd "C-h E") 'info-elisp-manual) ;C-h R has the same keybinging
(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-i") 'info-display-manual)

(defun info-elisp-manual ()
  "Display the Emacs manual in Info mode."
  (interactive)
  (info "elisp"))

(provide 'init-help)
