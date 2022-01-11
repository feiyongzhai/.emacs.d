;;; init-window-buffer-tab.el  --- configs for Window/Buffer/Tab

(require 'init-func)

;;; Mode

(winner-mode 1)

;;; Keys

(global-set-key (kbd "C-0") 'delete-window)
(global-set-key (kbd "C-1") 'delete-other-windows)
(global-set-key (kbd "C-2") 'split-window-below)
(global-set-key (kbd "C-3") 'split-window-right)
(global-set-key (kbd "C-4") 'tab-new)
(global-set-key (kbd "C-5") 'make-frame)
(global-set-key (kbd "C-6") 'nil)
(global-set-key (kbd "C-7") 'delete-frame)
(global-set-key (kbd "C-8") 'tab-close)
(global-set-key (kbd "C-9") 'global-tab-line-mode) ;感觉不太合理

;;; Buffer
(global-set-key (kbd "M-k") 'fei-kill-current-buffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x K") 'fei-kill-current-buffer)	; inspired by protesilaos
(global-set-key (kbd "M-s b") 'fei-meow-last-buffer)

;;; ==== Window ====
(global-set-key (kbd "s-o") 'ace-window)
(global-set-key (kbd "s-O") 'other-frame)
(global-set-key (kbd "s-u") 'winner-undo)
(fei-define-key-with-map global-map
  '(
    ("C-x w u" . transient-winner-undo)
    ("C-S-m" . maximize-window)		; matlab like keybinding
    ("C-x w M" . maximize-window)
    ("C-x w m" . minimize-window)
    ("C-x o" . transient-other-window)
    ("C-x O" . other-frame)
    ))

(setq aw-scope 'frame)
(setq aw-keys '(?j ?k ?l ?h ?g ?f ?d ?s ?a))
(custom-set-faces '(aw-leading-char-face ((t (:foreground "red" :height 1.5)))))
;;; ==== Tab bar ====

(define-key tab-switcher-mode-map (kbd "q") 'tab-close)

(fei-define-key-with-map global-map
  `(
    ("C-x t l" . tab-list)
    ("C-x t t" . tab-bar-select-tab-by-name)
    ("C-x t r" . tab-recent)
    ("C-x t n" . tab-new)
    ("C-x t R" . tab-rename)
    ("C-x t u" . tab-undo)
    ("M-1" . ,(li (tab-bar-select-tab 1)))
    ("M-2" . ,(li (tab-bar-select-tab 2)))
    ("M-3" . ,(li (tab-bar-select-tab 3)))
    ("M-4" . ,(li (tab-bar-select-tab 4)))
    ("M-5" . ,(li (tab-bar-select-tab 5)))
    ("M-6" . ,(li (tab-bar-select-tab 6)))
    ("M-7" . ,(li (tab-bar-select-tab 7)))
    ("M-8" . ,(li (tab-bar-select-tab 8)))
    ("M-9" . ,(li (tab-bar-select-tab 9)))
    ("C-S-w" . tab-close)
    ("C-S-t" . tab-new)
    ))

(setq tab-bar-show 1)
(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice nil)	;duplicate
(setq tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
;; (setq tab-bar-new-tab-choice 'eshell)

;;; Funcs

(transient-command winner-undo (winner-undo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

(transient-command other-window (other-window 1)
  '(("o" . other-window)
    ("O" . other-window-backward)))

;;; ==== Tab-line begin ====
(require 'tab-line)

(setq tab-line-tab-name-function 'tab-line-tab-name-truncated-buffer)
;;; `face-spec-set' 和 `custom-set-faces' 还是有点区别的
(face-spec-set 'tab-line
	       '((t (:inherit nil :height 0.95))))
;; (custom-set-faces
;;  '(tab-line ((t (:inherit nil :background "grey85" :foreground "black" :height 0.95)))))

(global-set-key (kbd "C-x <left>") 'transient-tab-line-prev)
(global-set-key (kbd "C-x <right>") 'transient-tab-line-next)

(transient-command tab-line-next
  (call-interactively 'tab-line-switch-to-next-tab)
  '(("<left>" . tab-line-switch-to-prev-tab)
    ("<right>" . tab-line-switch-to-next-tab)
    ("<down>" . bury-buffer)
    ))

(transient-command tab-line-prev
  (call-interactively 'tab-line-switch-to-prev-tab)
  '(("<left>" . tab-line-switch-to-prev-tab)
    ("<right>" . tab-line-switch-to-next-tab)
    ("<down>" . bury-buffer)
    ))

;;; ==== Tab-line end ====


(provide 'init-window-buffer-tab)
;;; init-windows.el ends here.
