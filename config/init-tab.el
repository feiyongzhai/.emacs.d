(require 'init-func)

;;; Keys

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

;;; Vars

(setq tab-bar-show t)
(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice nil)	;duplicate
(setq tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
;; (setq tab-bar-new-tab-choice 'eshell)


(provide 'init-tab)
