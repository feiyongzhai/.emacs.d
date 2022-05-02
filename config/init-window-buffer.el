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
(global-set-key (kbd "M-s L") (li (fei-meow-last-buffer 1)))
(global-set-key (kbd "C-x B") 'bookmark-jump)

;;; ==== Window ====
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)
(global-set-key (kbd "M-s m") 'window-configuration-to-register)
(global-set-key (kbd "M-s u") 'jump-to-register)
(global-set-key (kbd "M-s q") 'quit-window)
(global-set-key (kbd "M-s M-q") 'unbury-buffer)
(global-set-key (kbd "C-x w u") 'transient-winner-undo)
(global-set-key (kbd "C-x w s") 'window-swap-states)
(global-set-key (kbd "C-x w M") 'maximize-window)
(global-set-key (kbd "C-x w m") 'minimize-window)
;; (global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x O") 'other-frame)

;; These two keybindings is inspired by `C-x -'
(global-set-key (kbd "C-x 4 -") 'fit-window-to-buffer)
(global-set-key (kbd "C-x 5 -") 'fit-frame-to-buffer)

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

(global-set-key (kbd "M-K") 'reopen-killed-file)
;; @REF https://emacs.stackexchange.com/questions/3330/how-to-reopen-just-killed-buffer-like-c-s-t-in-firefox-browser
(defvar killed-file-list nil
  "List of recently killed files.")

(defun add-file-to-killed-file-list ()
  "If buffer is associated with a file name, add that file to the
`killed-file-list' when killing the buffer."
  (when buffer-file-name
    (push buffer-file-name killed-file-list)))

(add-hook 'kill-buffer-hook #'add-file-to-killed-file-list)

(defun reopen-killed-file ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (when killed-file-list
    (find-file (pop killed-file-list))))

(provide 'init-window-buffer)
;;; init-windows.el ends here.
