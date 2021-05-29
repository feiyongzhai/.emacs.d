
(transient-command transient-tab-next
		   (tab-next)
		   '(("o" . tab-next)
		     ("O" . tab-previous)))

(transient-command transient-tab-previous
		   (tab-previous)
		   '(("o" . tab-next)
		     ("O" . tab-previous)))

(global-set-key (kbd "C-x t O") #'transient-tab-previous)
(global-set-key (kbd "C-x t o") #'transient-tab-next)

(global-set-key (kbd "C-x t l") #'tab-list)
(global-set-key (kbd "C-x t t") #'tab-bar-select-tab-by-name)
(global-set-key (kbd "C-x t r") #'tab-recent)
(global-set-key (kbd "C-x t R") #'tab-rename)
(global-set-key (kbd "C-x t u") #'tab-undo)

(provide 'init-tab)
