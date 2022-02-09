(require 'fei-funcs)
(load-path-add "~/.emacs.d/extensions/move-text")
(require 'move-text)

;;; Kill/Yank
(global-set-key (kbd "M-L") 'fei-duplicate-line-or-region)
(global-set-key (kbd "C-w") 'backward-kill-word-or-region)

;;; Movement/Navigate
(global-set-key (kbd "C-'") 'avy-goto-line)
(global-set-key (kbd "M-g M-g") 'goto-line-preview)
;;; Cursor Movement (experimental config)
;; (setq recenter-positions '(top middle bottom))

(setq neo-theme 'ascii)
(setq neo-window-position 'right)
(global-set-key (kbd "C-c n") 'neotree-show)
(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "j") 'neotree-next-line)
  (define-key neotree-mode-map (kbd "k") 'neotree-previous-line)
  (define-key neotree-mode-map (kbd "J") 'fei-neotree-move-to-left)
  (define-key neotree-mode-map (kbd "K") 'fei-neotree-move-to-right)
  (define-key neotree-mode-map (kbd "l") 'neotree-enter)
  (define-key neotree-mode-map (kbd "f") 'neotree-enter)
  )

;;; Scroll
(global-set-key (kbd "M-N") 'scroll-up-line)
(global-set-key (kbd "M-P") 'scroll-down-line)

;;; Mark
(global-set-key (kbd "C-x C-p") 'mark-paragraph)
(global-set-key (kbd "C-,") 'set-mark-command)

;;; Misc
(global-set-key (kbd "C-c q") 'query-replace)
(global-set-key (kbd "C-c Q") 'query-replace-regexp)

(global-set-key (kbd "C-c J") 'consult-register-store)
(global-set-key (kbd "C-c j") 'consult-register-load)
(global-set-key (kbd "C-c f") 'consult-focus-lines)
(global-set-key (kbd "C-c o o") 'consult-outline)
(global-set-key (kbd "M-X") 'consult-mode-command)
(global-set-key (kbd "C-c i") 'counsel-imenu)

(global-set-key (kbd "C-x u") 'transient-undo)
(global-set-key (kbd "C-=") 'align-regexp)
(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "M-s ;") 'iedit-mode)
(global-set-key (kbd "C-x l") 'ialign)
(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)
(global-set-key (kbd "C-x <mouse-1>") 'open-current-file-with-vscode)
(global-set-key (kbd "<C-f12>") 'open-current-file-with-vscode)

;;; @REF: https://karthinks.com/software/batteries-included-with-emacs/
(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "C-x C-l") nil)
(global-set-key (kbd "C-x C-u") nil)

(transient-command undo (undo) '(("u" . undo)))

(provide 'init-edit)
