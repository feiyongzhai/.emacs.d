(require 'fei-funcs)
(require 'move-text)

(setq shift-select-mode t)		;回归默认行为
(setq mouse-yank-at-point t)		;粘贴于光标处,而不是鼠标指针处
(setq next-screen-context-lines 2)	;default is 2
(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 0 ;此变量会影响到 C-l(recenter-top-bottom) 的行为，用的默认值
      )

;;; Kill/Yank
(global-set-key (kbd "M-L") 'fei-duplicate-line-or-region)
(global-set-key (kbd "C-w") 'backward-kill-word-or-region)
(global-set-key (kbd "M-Z") 'zap-up-to-char)

;;; Movement/Navigate
(global-set-key (kbd "M-s n") (li (switch-to-buffer "*eaf*")))
(global-set-key (kbd "M-s p") (li (switch-to-buffer "*scratch*")))

(global-set-key (kbd "M-s M-o") 'multi-occur-in-this-mode)
(global-set-key (kbd "M-s O") 'fei-occur-at-point)

(global-set-key (kbd "C-'") 'avy-resume)
;;; Cursor Movement (experimental config)
;; (setq recenter-positions '(top middle bottom))

;;; Highlight
(global-set-key (kbd "M-s M-h") 'highlight-symbol-at-point)

(defun fei-scroll-up-line ()
  (interactive)
  (if (or (eq last-command 'fei-scroll-down-line)
	  (eq last-command 'fei-scroll-up-line))
    (scroll-up-line)
    (scroll-up-line)
    (fei-pulse-current-line)))

(defun fei-scroll-down-line ()
  (interactive)
  (if (or (eq last-command 'fei-scroll-down-line)
	  (eq last-command 'fei-scroll-up-line))
    (scroll-down-line)
    (scroll-down-line)
    (fei-pulse-current-line)))

;;; Mark
(global-set-key (kbd "C-,") 'set-mark-command)

;;; Misc
(global-set-key (kbd "C-0") 'delete-window)
(global-set-key (kbd "C-1") 'zygospore-toggle-delete-other-windows)
(global-set-key (kbd "C-2") (li (split-window-below) (other-window 1)))
(global-set-key (kbd "C-3") (li (split-window-right) (other-window 1)))

(global-set-key (kbd "C-x i") 'insert-char)
(global-set-key (kbd "C-x I") 'emoji-search)
(global-set-key (kbd "C-x M-i") 'all-the-icons-insert)

(global-set-key (kbd "S-SPC") 'just-one-space)

(global-set-key (kbd "C-c o o") 'counsel-outline)
(global-set-key (kbd "C-c i") 'counsel-imenu)

(global-set-key (kbd "C-x u") 'transient-undo)
(global-set-key (kbd "C-x l") 'fei-meow-last-buffer)

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

(transient-command undo
  (undo)
  '(("u" . undo)
    ("U" . undo-redo)))

(global-set-key (kbd "C-s-n") 'fei-scroll-up-line)
(global-set-key (kbd "M-s-n") 'fei-scroll-up-line-other-window)
(global-set-key (kbd "C-s-p") 'fei-scroll-down-line)
(global-set-key (kbd "M-s-p") 'fei-scroll-down-line-other-window)

(defun fei-scroll-up-line-other-window ()
  (interactive)
  (with-selected-window (next-window)
    (scroll-up-line)))

(defun fei-scroll-down-line-other-window ()
  (interactive)
  (with-selected-window (next-window)
    (scroll-down-line)))

(provide 'init-edit)
