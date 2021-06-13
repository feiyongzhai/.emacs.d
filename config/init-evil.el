;;; init-evil --- configs for evil

;;; Code:

(global-set-key (kbd "ESC ESC <M-escape>") #'evil-local-mode-with-cursor)

(autoload 'evil-local-mode "evil" nil t)

;;; Vars

(setq evil-emacs-state-cursor 'bar)

;;; Func

(defun evil-local-mode-with-cursor ()
  (interactive)
  (unless (boundp 'evil-local-mode)
    (evil-local-mode -1)) ;; unless part is for initialization
  (if evil-local-mode
      (progn (evil-local-mode -1)
	     (setq cursor-type 'bar))
    (evil-local-mode 1)))

(provide 'init-evil)
;;; init-evil.el ends here
