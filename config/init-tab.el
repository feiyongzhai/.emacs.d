(require 'init-func)

;;; Keys

(fei-define-key-with-map global-map
  '(("C-x t O" . transient-tab-previous)
    ("C-x t o" . transient-tab-next)
    ("C-x t l" . tab-list)
    ("C-x t t" . tab-bar-select-tab-by-name)
    ("C-x t r" . tab-recent)
    ("C-x t n" . tab-new)
    ("C-x t R" . tab-rename)
    ("C-x t u" . tab-undo)
    ))

(define-key tab-switcher-mode-map (kbd "q") 'tab-close)

;;; ivy-view replacement
(global-set-key (kbd "C-c v") 'tab-rename)
(global-set-key (kbd "C-c V") 'tab-bar-select-tab-by-name)

;;; Vars

(setq tab-bar-show 1)
(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice nil)	;duplicate
(setq tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
(setq tab-bar-new-tab-choice 'eshell)

;;; Funcs

(transient-command tab-next
  (tab-next)
  '(("o" . tab-next)
    ("O" . tab-previous)))

(transient-command tab-previous
  (tab-previous)
  '(("o" . tab-next)
    ("O" . tab-previous)))


(provide 'init-tab)
