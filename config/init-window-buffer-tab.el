;;; init-window-buffer-tab.el  --- configs for Window/Buffer/Tab

(require 'init-func)

;;; Mode

(winner-mode 1)

;;; Keys

;;; Buffer
(global-set-key (kbd "M-k") 'fei-kill-current-buffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x K") 'fei-kill-current-buffer)	; inspired by protesilaos
(global-set-key (kbd "<f9>") 'fei-meow-last-buffer)

;;; Window
(global-set-key (kbd "s-u") 'winner-undo)
(global-set-key (kbd "s-0") 'delete-window)
(global-set-key (kbd "s-1") 'delete-other-windows)
(global-set-key (kbd "s-2") (lambda () (interactive) (split-window-below) (other-window 1)))
(global-set-key (kbd "s-3") (lambda () (interactive) (split-window-right) (other-window 1)))
(fei-define-key-with-map global-map
  '(
    ("C-x w u" . transient-winner-undo)
    ("C-x w M" . maximize-window)
    ("C-S-m" . maximize-window)		; matlab like keybinding
    ("C-x w m" . minimize-window)
    ("C-x o" . transient-other-window)
    ))

;;; Tab

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
    ("M-0" . tab-list)
    ("M--" . tab-close)
    ("M-=" . tab-new)
    ("M-+" . tab-bar-switch-to-tab)
    ))

(setq tab-bar-show 1)
(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice nil)	;duplicate
(setq tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
;; (setq tab-bar-new-tab-choice 'eshell)

;;; Funcs

(transient-command winner-undo
  (winner-undo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

(transient-command other-window
  (other-window 1)
  '(("o" . other-window)
    ("O" . other-window-backward)))

(defun fei-kill-current-buffer (arg)
  "智能关闭 windows 和 buffer"
  (interactive "P")
  (cond
   ((minibufferp)
    (keyboard-escape-quit))
   ((or arg (one-window-p))
    (kill-buffer))
   (t (kill-buffer-and-window))))

;;; {{ tab-line
(require 'tab-line)
(global-set-key (kbd "C-c ,") 'transient-tab-line-prev)
(global-set-key (kbd "C-c .") 'transient-tab-line-next)

;;; 添加这一行，主要是因为 org 中占用了 C-c , 和 C-c .
;;; 主要还是用上面那个快捷键（因为更好按）
(global-set-key (kbd "C-c H") 'transient-tab-line-prev)
(global-set-key (kbd "C-c L") 'transient-tab-line-next)


(transient-command tab-line-next
  (call-interactively 'tab-line-switch-to-next-tab)
  '(("," . tab-line-switch-to-prev-tab)
    ("." . tab-line-switch-to-next-tab)
    ("/" . bury-buffer)
    ("h" . tab-line-switch-to-prev-tab)
    ("l" . tab-line-switch-to-next-tab)
    (";" . bury-buffer)
    ))

(transient-command tab-line-prev
  (call-interactively 'tab-line-switch-to-prev-tab)
  '(("," . tab-line-switch-to-prev-tab)
    ("." . tab-line-switch-to-next-tab)
    ("/" . bury-buffer)
    ("h" . tab-line-switch-to-prev-tab)
    ("l" . tab-line-switch-to-next-tab)
    (";" . bury-buffer)
    ))

(add-hook 'term-mode-hook
	  (lambda ()
	    (define-key term-raw-map (kbd "C-c ,") 'transient-tab-line-prev)
	    (define-key term-raw-map (kbd "C-c .") 'transient-tab-line-next)))
;;; tab-line }}

(provide 'init-window-buffer-tab)
;;; init-windows.el ends here.
