(require 'init-func)

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
