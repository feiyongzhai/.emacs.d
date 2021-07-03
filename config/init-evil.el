;;; init-evil --- configs for evil

;;; Module autoload

(autoload 'evil-local-mode "evil" nil t)

;;; Code:

;;; Keys

(global-set-key (kbd "C-z") 'evil-local-mode-with-cursor)
(with-eval-after-load 'evil
    (define-key evil-normal-state-map (kbd "C-z") 'evil-local-mode-with-cursor))

;;; Vars

;; (add-hook 'find-file-hook #'evil-local-mode)
;; (add-hook 'help-mode-hook #'evil-local-mode)
(setq evil-emacs-state-cursor 'bar)

;;; Funcs

(defvar fei-default-color (cons (face-background 'mode-line)
				  (face-foreground 'mode-line)))
(with-eval-after-load 'evil
  (add-hook 'post-command-hook #'fei-show-evil-state)
  (defun fei-show-evil-state ()
    "Change mode line color to notify user evil current state."
    (let* ((color (cond ((minibufferp) fei-default-color)
			((evil-insert-state-p) '("#e80000" . "#ffffff"))
			((evil-emacs-state-p)  '("#444488" . "#ffffff"))
			((or (eq this-command 'load-theme)
			     (eq this-command 'counsel-load-theme)
			     (eq this-command 'modus-themes-toggle))
			 (setq fei-default-color
			       (cons (face-background 'mode-line)
				     (face-foreground 'mode-line))))
			(t fei-default-color))))
      (set-face-background 'mode-line (car color))
      (set-face-foreground 'mode-line (cdr color)))))

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
