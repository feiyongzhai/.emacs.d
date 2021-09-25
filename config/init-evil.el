;;; init-evil --- configs for evil

;;; autoload
(autoload 'evil-local-mode "evil" nil t)

;;; Keys

(global-set-key (kbd "C-z") 'evil-mode-with-cursor)
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (define-key evil-insert-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (define-key evil-visual-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (define-key evil-motion-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (define-key evil-emacs-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (evil-define-key 'normal messages-buffer-mode-map "q" 'quit-window)

  ;; inspired by emacs-china post
  (define-key evil-normal-state-map (kbd "RET") 'fei-meow-last-buffer)
  )

;;; Leader Key
;;; {{ need feature `general`
;;; Evil related keys
(general-create-definer fei-space-leader-def
  :prefix "SPC"
  :states '(normal visual))

(fei-space-leader-def
  "SPC" 'counsel-M-x
  "tt" 'modus-themes-toggle
  "ts" 'counsel-load-theme
  ;; "gg" 'browse-stackoverflow-search
  "g" 'engine-mode-prefixed-map
  "ss" 'eshell
  "se" 'shell
  "jj" 'scroll-other-window
  "kk" 'scroll-other-window-down
  )
;;; }}

;;; Vars

;; (add-hook 'find-file-hook #'evil-local-mode)
;; (add-hook 'help-mode-hook #'evil-local-mode)
(setq evil-emacs-state-cursor 'bar)

;;; Funcs

(with-eval-after-load 'evil
  (dolist (p '((minibuffer-inactive-mode . emacs)
	       (calendar-mode . emacs)
	       (special-mode . emacs)
	       (grep-mode . emacs)
	       (Info-mode . emacs)
	       (term-mode . emacs)
	       (sdcv-mode . emacs)
	       (anaconda-nav-mode . emacs)
	       (log-edit-mode . emacs)
	       (vc-log-edit-mode . emacs)
	       (magit-log-edit-mode . emacs)
	       (git-commit-mode . emacs)
	       (erc-mode . emacs)
	       (neotree-mode . emacs)
	       (w3m-mode . emacs)
	       (gud-mode . emacs)
	       ;; (help-mode . emacs)
	       (eshell-mode . emacs)
	       (shell-mode . emacs)
	       (xref--xref-buffer-mode . emacs)
	       ;;(message-mode . emacs)
	       (epa-key-list-mode . emacs)
	       (fundamental-mode . emacs)
	       (weibo-timeline-mode . emacs)
	       (weibo-post-mode . emacs)
	       (woman-mode . emacs)
	       (sr-mode . emacs)
	       (profiler-report-mode . emacs)
	       (dired-mode . emacs)
	       (compilation-mode . emacs)
	       (speedbar-mode . emacs)
	       (ivy-occur-mode . emacs)
	       (ffip-file-mode . emacs)
	       (ivy-occur-grep-mode . normal)
	       (messages-buffer-mode . normal)
	       (eaf-mode . emacs)
	       (diff-mode . emacs)
	       (js2-error-buffer-mode . emacs)))
    (evil-set-initial-state (car p) (cdr p)))
  )

(defun evil-local-mode-with-cursor ()
  (interactive)
  (unless (boundp 'evil-local-mode)
    (evil-local-mode -1)) ;; unless part is for initialization
  (if evil-local-mode
      (progn (evil-local-mode -1)
	     (setq cursor-type 'bar))
    (evil-local-mode 1)))

(defun evil-mode-with-cursor ()
  (interactive)
  (unless (boundp 'evil-mode)
    (evil-mode -1)) ;; unless part is for initialization
  (if evil-mode
      (progn (evil-mode -1)
	     (dolist (buf (buffer-list))
	       (set-buffer buf)
	       (setq cursor-type 'bar)))
    (evil-mode 1)))

(provide 'init-evil)
;;; init-evil.el ends here
