;;; init-evil --- configs for evil

;;; Keys

(with-eval-after-load 'evil
  (evil-define-key 'normal messages-buffer-mode-map "q" 'quit-window)
  (define-key evil-normal-state-map (kbd "<tab>") 'ace-window)
  )

;;; Leader Key
(general-create-definer fei-space-leader-def
  :prefix "SPC"
  :states '(normal visual))

(fei-space-leader-def
  ;; "gg" 'browse-stackoverflow-search
  "g" 'engine-mode-prefixed-map
  "ff" 'ido-find-file
  "fo" 'ido-find-file-other-window
  )

;;; Vars

(setq evil-undo-system 'undo-redo)

;; (add-hook 'find-file-hook #'evil-local-mode)
;; (add-hook 'help-mode-hook #'evil-local-mode)

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
               ;; (fundamental-mode . emacs)
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


(provide 'init-evil)
;;; init-evil.el ends here
