(require 'fei-funcs)

(setq mouse-yank-at-point t)		;粘贴于光标处,而不是鼠标指针处

;;; Kill/Yank
(global-set-key (kbd "M-L") 'fei-duplicate-line-or-region)
(global-set-key (kbd "C-w") 'backward-kill-word-or-region)
(global-set-key (kbd "M-Z") 'zap-up-to-char)

;;; Movement/Navigate
(global-set-key (kbd "M-s n") (li (switch-to-buffer "*eaf*")))
(global-set-key (kbd "M-s p") (li (switch-to-buffer "*scratch*")))

(global-set-key (kbd "M-s [") 'point-to-register)
(global-set-key (kbd "M-s ]") 'jump-to-register)

(global-set-key (kbd "M-s M-o") 'multi-occur-in-this-mode)
(global-set-key (kbd "M-s O") 'fei-occur-at-point)
;; (global-set-key (kbd "M-O") 'fei-occur-for-mouse) ;M-O 在终端中用特殊的含义，和 f1-f4 绑定在一起
(global-set-key (kbd "C-'") 'avy-goto-line)
(global-set-key (kbd "M-g M-g") 'consult-goto-line)
;;; Cursor Movement (experimental config)
;; (setq recenter-positions '(top middle bottom))

;; Highlight
(global-set-key (kbd "M-s M-h") 'highlight-symbol-at-point)

;; Neotree
(setq neo-theme 'ascii)
(setq neo-window-position 'right)
(global-set-key (kbd "<tab-line> <mouse-9>") 'neotree)
(global-set-key (kbd "<f8>") 'neotree)
(global-set-key (kbd "<C-f8>") 'speedbar)
(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "j") 'neotree-next-line)
  (define-key neotree-mode-map (kbd "k") 'neotree-previous-line)
  (define-key neotree-mode-map (kbd "J") 'fei-neotree-move-to-left)
  (define-key neotree-mode-map (kbd "K") 'fei-neotree-move-to-right)
  (define-key neotree-mode-map (kbd "l") 'neotree-enter)
  (define-key neotree-mode-map (kbd "f") 'neotree-enter)
  (define-key neotree-mode-map (kbd "<mouse-3>") 'neotree-mouse-open-external)
  )

(defun neotree-mouse-open-external (event)
  (interactive "e")
  (mouse-set-point event)
  (neotree-open-file-in-system-application))

;;; Scroll
(global-set-key (kbd "M-N") 'scroll-up-line)
(global-set-key (kbd "M-P") 'scroll-down-line)
(setq next-screen-context-lines 1)	;default is 2
(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 0 ;这个变量会影响到 C-l(recenter-top-bottom) 的行为，用的默认值
      )

;;; Mark
(global-set-key (kbd "M-H") 'mark-line)
(global-set-key (kbd "C-x C-p") 'mark-paragraph)
(global-set-key (kbd "C-,") 'set-mark-command)
(setq shift-select-mode 'permanent)

;;; Misc

(global-set-key (kbd "S-SPC") 'just-one-space)

(global-set-key (kbd "C-c q") 'query-replace)
(global-set-key (kbd "C-c Q") 'query-replace-regexp)

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
