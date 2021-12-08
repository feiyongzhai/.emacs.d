(require 'fei-funcs)
(load-path-add "~/.emacs.d/extensions/move-text")
(require 'move-text)

;;; Kill/Yank
(global-set-key (kbd "M-L") 'fei-duplicate-line-or-region)
(global-set-key (kbd "<C-M-backspace>") 'backward-kill-sexp)
(global-set-key (kbd "C-w") 'backward-kill-word-or-region)

;;; Movement/Navigate
(global-set-key (kbd "M-a") 'beginning-of-defun)
(global-set-key (kbd "M-e") 'end-of-defun)
(global-set-key (kbd "C-'") 'avy-goto-line)
(global-set-key (kbd "M-g M-g") 'goto-line-preview)
;;; Cursor Movement (experimental config)
;; (setq recenter-positions '(top middle bottom))

(setq neo-theme 'ascii)
(global-set-key (kbd "C-c n") 'neotree-toggle)
(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "j") 'neotree-next-line)
  (define-key neotree-mode-map (kbd "k") 'neotree-previous-line)
  (define-key neotree-mode-map (kbd "l") 'neotree-enter)
  (define-key neotree-mode-map (kbd "f") 'neotree-enter)
  )

;;; Scroll
(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)
(global-set-key (kbd "<prior>") 'scroll-down-line)
(global-set-key (kbd "<next>") 'scroll-up-line)
(global-set-key (kbd "M-N") 'scroll-up-line)
(global-set-key (kbd "M-P") 'scroll-down-line)

(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)

;;; Mark
(global-set-key (kbd "C-x C-p") 'mark-paragraph)
(global-set-key (kbd "C-,") 'set-mark-command)

;;; Misc
(global-set-key (kbd "C-x u") 'transient-undo)
(global-set-key (kbd "C-=") 'align-regexp)
(global-set-key (kbd "<f7>") 'scratch)
(global-set-key (kbd "<C-return>") 'fei-newline)
(global-set-key (kbd "M-RET") 'fei-newline)
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

(load-path-add "~/.emacs.d/extensions/duplicate-line/")
(require 'duplicate-line)
(defun fei-duplicate-line-or-region (&optional arg)
  (interactive "P")
  (if arg
      (call-interactively 'duplicate-line-below-comment)
    (call-interactively 'duplicate-line-or-region-below)))

(provide 'init-edit)
