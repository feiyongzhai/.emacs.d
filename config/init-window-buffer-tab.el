;;; init-window-buffer-tab.el  --- configs for Window/Buffer/Tab

(require 'init-func)

;;; Mode

(winner-mode 1)

;;; ==== Buffer ====
(global-set-key (kbd "M-k") 'kill-current-buffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x K") 'fei-kill-current-buffer)	; inspired by protesilaos
(global-set-key (kbd "M-s RET") 'fei-meow-last-buffer)
(global-set-key (kbd "M-s l") 'fei-meow-last-buffer)
(global-set-key (kbd "C-x B") 'bookmark-jump)
(global-set-key (kbd "C-x b") 'consult-buffer)

;;; ==== Window ====
(global-set-key (kbd "M-s m") 'fei-store-window-configuration)
(global-set-key (kbd "M-s u") 'fei-load-window-configuration)
(global-set-key (kbd "M-s M") 'fei-store-file)
(global-set-key (kbd "M-s U") 'fei-load-file)
(global-set-key (kbd "M-s q") 'quit-window)
(global-set-key (kbd "C-x 1") ' zygospore-toggle-delete-other-windows)
(global-set-key (kbd "C-x w u") 'transient-winner-undo)
(global-set-key (kbd "C-x w s") 'window-swap-states)
(global-set-key (kbd "C-S-m") 'maximize-window)		; matlab like keybinding
(global-set-key (kbd "C-x w M") 'maximize-window)
(global-set-key (kbd "C-x w m") 'minimize-window)
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x O") 'other-frame)

;;; ==== Tab bar ====
;;; Funcs

(transient-command winner-undo (winner-undo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

(provide 'init-window-buffer-tab)
;;; init-windows.el ends here.
