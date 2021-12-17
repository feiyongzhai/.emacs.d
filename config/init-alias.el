;; 与其纠结怎么定义一个合理的 keybinding，不如用 alias

(defalias 'tabn 'tab-new)
(defalias 'tabc 'tab-close)
(defalias 'frn 'make-frame)
(defalias 'frc 'delete-frame)

(provide 'init-alias)
