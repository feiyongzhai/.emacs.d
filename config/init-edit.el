(require 'fei-funcs)

;;; Kill/Yank
(global-set-key (kbd "M-L") 'fei-duplicate-line-or-region)
(global-set-key (kbd "C-w") 'backward-kill-word-or-region)

;;; Movement/Navigate
(global-set-key (kbd "M-s O") 'fei-occur-at-point)
(global-set-key (kbd "C-'") 'avy-goto-line)
(global-set-key (kbd "M-g M-g") 'consult-goto-line)
;;; Cursor Movement (experimental config)
;; (setq recenter-positions '(top middle bottom))

;; Neotree
(setq neo-theme 'ascii)
(setq neo-window-position 'right)
(global-set-key (kbd "C-c N") 'speedbar)
(global-set-key (kbd "C-c n") 'neotree-show)
(global-set-key (kbd "C-c C-n") 'neotree-show)
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
(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 0 ;这个变量会影响到 C-l(recenter-top-bottom) 的行为，用的默认值
      )

;;; Mark
(global-set-key (kbd "M-H") 'mark-defun)
(global-set-key (kbd "C-x C-p") 'mark-paragraph)
(global-set-key (kbd "C-,") 'set-mark-command)

;;; Misc
(global-set-key (kbd "C-c q") 'query-replace)
(global-set-key (kbd "C-c Q") 'query-replace-regexp)

(global-set-key (kbd "C-x M-f") 'sudo-find-this-file)
(global-set-key (kbd "C-c o o") 'consult-outline)
(global-set-key (kbd "M-X") 'consult-mode-command)
(global-set-key (kbd "C-c i") 'counsel-imenu)

(global-set-key (kbd "C-x u") 'transient-undo)
(global-set-key (kbd "C-=") 'align-regexp)
(global-set-key (kbd "C-x l") 'ialign)
(global-set-key (kbd "C-x <mouse-1>") 'open-current-file-with-vscode)
(global-set-key (kbd "<C-f12>") 'open-current-file-with-vscode)

(add-to-list 'load-path "~/.emacs.d/extensions/move-text")
(require 'move-text)

(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)

;; Iedit
(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "M-s ;") 'iedit-mode)

;;; @REF: https://karthinks.com/software/batteries-included-with-emacs/
(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "C-x C-l") nil)
(global-set-key (kbd "C-x C-u") nil)

(transient-command undo (undo) '(("u" . undo)))

(provide 'init-edit)
