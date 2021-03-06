;;; init-evil --- configs for evil

;; (vim)
;; (evil-set-undo-system 'undo-redo)

(setq evil-mode-line-format '(before . mode-line-front-space)) ;move tag to beginning-of-line
(setq evil-insert-state-tag " [I]")
(setq evil-normal-state-tag " [N]")
(setq evil-visual-state-tag " [V]")
(setq evil-motion-state-tag " [M]")
(setq evil-emacs-state-tag " [E]")

;;; Keys

(with-eval-after-load 'evil
  (evil-define-key 'normal messages-buffer-mode-map "q" 'quit-window)
  (evil-global-set-key 'normal "\C-n" 'next-line)
  (evil-global-set-key 'normal "\M-." 'nil)
  (evil-global-set-key 'normal "\C-p" 'previous-line)
  (evil-global-set-key 'insert "\C-v" 'nil)
  (evil-global-set-key 'insert "\C-a" 'nil)
  (evil-global-set-key 'insert "\C-e" 'nil)
  (evil-global-set-key 'insert "\C-k" 'nil)
  (evil-global-set-key 'insert "\C-o" 'nil)
  (evil-global-set-key 'insert "\C-d" 'nil)
  (evil-global-set-key 'insert "\C-y" 'nil)
  (evil-global-set-key 'insert "\C-n" 'nil)
  (evil-global-set-key 'insert "\C-p" 'nil)
  (evil-define-key 'normal org-mode-map
    (kbd "TAB") 'org-cycle
    ">" 'org-shiftmetaright
    "<" 'org-shiftmetaleft)
  )

;;; Leader Key
(general-create-definer fei-space-leader-def
  :prefix "SPC"
  :states '(normal visual))

(fei-space-leader-def
  "SPC" 'counsel-M-x
  "w" 'pwd
  "W" 'whitespace-mode
  "t" 'fei-switch-to-treemacs
  "j" 'fasd-ivy-find-file
  "TAB" 'fei-meow-last-buffer
  "i" 'ibuffer
  "d" 'dired-jump
  "b" 'switch-to-buffer
  "e" 'eshell
  "k" 'counsel-rg
  "K" 'fei-counsel-rg-my-org
  "N" 'fei-org-capture-note
  "n" 'fei-org-capture-private
  "s" 'fei-search-1
  "m" 'execute-extended-command
  "x" 'execute-extended-command
  "z" 'vterm-toggle
  "g" 'magit
  "f" 'counsel-find-file
  "F" 'ffap
  "0" 'delete-window
  "1" 'zygospore-toggle-delete-other-windows
  "2" 'split-window-below
  "3" 'split-window-right
  "o" 'other-window
  "O" 'open-current-file-with-vscode
  )

;;; Initial states

(with-eval-after-load 'evil
  (dolist (p '((minibuffer-inactive-mode . emacs)
	       (calendar-mode . emacs)
	       (youdao-dictionary-mode . emacs)
	       (special-mode . emacs)
	       (grep-mode . emacs)
	       (Info-mode . emacs)
	       (term-mode . emacs)
	       (vterm-mode . emacs)
	       (sdcv-mode . emacs)
	       (telega-chat-mode . emacs)
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

;; Funcs
(defun evil-mode-with-cursor ()
  "?????? message ???????????????????????????????????????"
  (interactive)
  (unless (boundp 'evil-mode)
    (evil-mode -1)
    (message "Now is EMACS")) ;; unless part is for initialization
  (if evil-mode
      (progn
	(evil-mode -1)
	(dolist (buf (buffer-list))
	  (set-buffer buf)
	  (setq cursor-type 'bar))
	(add-hook 'post-command-hook 'fei-change-cursor-when-readonly)
	(message "Now is EMACS ????"))
    (evil-mode 1)
    (remove-hook 'post-command-hook 'fei-change-cursor-when-readonly)
    (message "Now is EVIL ????")))

(defun emacs ()
  (interactive)
  (evil-mode -1)
  (dolist (buf (buffer-list))
    (set-buffer buf)
    (setq cursor-type 'bar))
  (add-hook 'post-command-hook 'fei-change-cursor-when-readonly)
  (message "Now is EMACS ????"))

(defun vim ()
  (interactive)
  (evil-mode 1)
  (remove-hook 'post-command-hook 'fei-change-cursor-when-readonly)
  (message "Now is EVIL ????"))


(provide 'init-evil)
;;; init-evil.el ends here
