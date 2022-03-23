;;; init-window-buffer-tab.el  --- configs for Window/Buffer/Tab

(require 'init-func)
(autoload 'zygospore-toggle-delete-other-windows "zygospore" t nil)

;;; Mode

(winner-mode 1)

;;; ==== Buffer ====
(global-set-key (kbd "M-k") 'kill-current-buffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x K") 'fei-kill-current-buffer)	; inspired by protesilaos

(global-set-key (kbd "M-s l") 'fei-meow-last-buffer)
(global-set-key (kbd "C-x B") 'bookmark-jump)
(global-set-key (kbd "C-x b") 'consult-buffer)

;;; ==== Window ====
(global-set-key (kbd "M-s m") 'fei-store-window-configuration)
(global-set-key (kbd "M-s u") 'fei-load-window-configuration)
(global-set-key (kbd "M-s M") 'fei-store-file)
(global-set-key (kbd "M-s U") 'fei-load-file)
(global-set-key (kbd "M-s q") 'quit-window)
(global-set-key (kbd "M-s M-q") 'unbury-buffer)
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)
(global-set-key (kbd "C-x w u") 'transient-winner-undo)
(global-set-key (kbd "C-x w s") 'window-swap-states)
(global-set-key (kbd "C-S-m") 'maximize-window)		; matlab like keybinding
(global-set-key (kbd "C-x w M") 'maximize-window)
(global-set-key (kbd "C-x w m") 'minimize-window)
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x O") 'other-frame)

(autoload 'evil-move-window "evil" nil t)
(global-set-key (kbd "C-x w H") (li (evil-move-window 'left)))
(global-set-key (kbd "C-x w L") (li (evil-move-window 'right)))
(global-set-key (kbd "C-x w K") (li (evil-move-window 'above)))
(global-set-key (kbd "C-x w J") (li (evil-move-window 'below)))

;; ace-window
(setq aw-ignore-current nil)
(setq aw-dispatch-when-more-than 2)
(setq aw-scope 'frame)
(setq aw-keys '(?j ?k ?l ?h ?g ?f ?d ?s ?a))
(setq aw-char-position 'top-left)
(custom-set-faces '(aw-leading-char-face ((t (:foreground "red" :height 1.5)))))

(transient-command winner-undo (winner-undo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

(provide 'init-window-buffer)
;;; init-windows.el ends here.
