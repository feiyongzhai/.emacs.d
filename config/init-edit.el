;;; Kill/Yank
(global-set-key (kbd "M-L") 'fei-duplicate-line-or-region)
(global-set-key (kbd "<C-M-backspace>") 'backward-kill-sexp)
(global-set-key (kbd "C-w") 'backward-kill-word-or-region)

;;; Movement/Navigate
(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
(global-set-key (kbd "M-s s") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "M-a") 'beginning-of-defun)
(global-set-key (kbd "M-e") 'end-of-defun)
(global-set-key (kbd "C-'") 'avy-goto-line)
(global-set-key (kbd "M-g M-g") 'goto-line-preview)
;;; Cursor Movement (experimental config)
(setq recenter-positions '(top middle bottom))

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
(global-set-key (kbd "M-N") 'scroll-up-line)
(global-set-key (kbd "M-n") 'scroll-up-line)
(global-set-key (kbd "M-P") 'scroll-down-line)
(global-set-key (kbd "M-p") 'scroll-down-line)

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

;;; @REF: https://karthinks.com/software/batteries-included-with-emacs/
(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "C-x C-l") 'consult-focus-lines)
(global-set-key (kbd "C-x C-u") nil)

;;; {{ Func

(defun back-to-indentation-or-beginning () (interactive)
       (if (= (point) (progn (back-to-indentation) (point)))
	   (beginning-of-line)))

(defun backward-kill-word-or-region (&optional arg)
  "Kill word backwards unless region is active,
kill region instead"
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning)
		   (region-end))
    (backward-kill-word (or arg 1))))

(defun fei-newline ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(load-path-add "~/.emacs.d/extensions/duplicate-line/")
(require 'duplicate-line)
(defun fei-duplicate-line-or-region (&optional arg)
  (interactive "P")
  (if arg
      (call-interactively 'duplicate-line-below-comment)
    (call-interactively 'duplicate-line-or-region-below)))

;;; }} Func

(provide 'init-edit)
