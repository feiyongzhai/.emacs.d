(load-path-add "~/.emacs.d/extensions/insert-translated-name")

(autoload 'insert-translated-name-insert "insert-translated-name" nil t)
(autoload 'evil-local-mode "evil" nil t)
(autoload 'eaf-open-browser "eaf" nil t)
(autoload 'eaf--bookmark-restore "eaf" nil t)
(autoload 'org-ctrl-c-ctrl-c "org" nil t)
(autoload 'eaf-open-browser-with-history "eaf" nil t)
(autoload 'eaf-open-this-buffer "eaf" nil t)

(provide 'init-autoload)