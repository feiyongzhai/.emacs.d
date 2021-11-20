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
    ("C-1" . ,(li (tab-bar-select-tab 1)))
    ("C-2" . ,(li (tab-bar-select-tab 2)))
    ("C-3" . ,(li (tab-bar-select-tab 3)))
    ("C-4" . ,(li (tab-bar-select-tab 4)))
    ("C-5" . ,(li (tab-bar-select-tab 5)))
    ("C-6" . ,(li (tab-bar-select-tab 6)))
    ("C-7" . ,(li (tab-bar-select-tab 7)))
    ("C-8" . ,(li (tab-bar-select-tab 8)))
    ("C-9" . ,(li (tab-bar-select-tab 9)))
    ("C-0" . tab-list)
    ("C-S-w" . tab-close)
    ("C-S-t" . tab-new)
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

;;; `face-spec-set' 和 `custom-set-faces' 还是有点区别的
(face-spec-set 'tab-line
	       '((t (:inherit nil :height 0.95))))
;; (custom-set-faces
;;  '(tab-line ((t (:inherit nil :background "grey85" :foreground "black" :height 0.95)))))
(global-tab-line-mode t)

(global-set-key (kbd "C-c ,") 'transient-tab-line-prev)
(global-set-key (kbd "C-c .") 'transient-tab-line-next)

;;; 添加这一行，主要是因为 org 中占用了 C-c , 和 C-c .
(with-eval-after-load 'org
  (fei-define-key-with-map org-mode-map
    '(
      ("C-c ," . nil)
      ("C-c ." . nil)
      ("C-c M-," . org-priority)
      ("C-c M-." . org-time-stamp)
      )))

(transient-command tab-line-next
  (call-interactively 'tab-line-switch-to-next-tab)
  '(("," . tab-line-switch-to-prev-tab)
    ("." . tab-line-switch-to-next-tab)
    ("/" . bury-buffer)
    ))

(transient-command tab-line-prev
  (call-interactively 'tab-line-switch-to-prev-tab)
  '(("," . tab-line-switch-to-prev-tab)
    ("." . tab-line-switch-to-next-tab)
    ("/" . bury-buffer)
    ))

(add-hook 'term-mode-hook
	  (lambda ()
	    (define-key term-raw-map (kbd "C-c ,") 'transient-tab-line-prev)
	    (define-key term-raw-map (kbd "C-c .") 'transient-tab-line-next)))

;;; tab-line }}

(provide 'init-window-buffer-tab)
;;; init-windows.el ends here.