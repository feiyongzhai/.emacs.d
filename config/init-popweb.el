(add-to-list 'load-path "~/.emacs.d/extensions/popweb/extension/dict/")
(add-to-list 'load-path "~/.emacs.d/extensions/popweb/extension/latex/")
(add-to-list 'load-path "~/.emacs.d/extensions/popweb/")
(require 'popweb-dict-bing)
(require 'popweb-dict-youdao)
(require 'popweb-latex)

(setq popweb-python-command "/usr/bin/python3")
(global-set-key (kbd "C-h u") 'popweb-dict-youdao-pointer)

(provide 'init-popweb)
