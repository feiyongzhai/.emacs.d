;;; init-evil --- configs for evil

;;; Module autoload

(autoload 'evil-local-mode "evil" nil t)

;;; Code:

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
