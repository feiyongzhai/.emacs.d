;; deno-bridge
(add-to-list 'load-path "~/.emacs.d/extensions/deno-bridge/")
(require 'deno-bridge)

(add-to-list 'load-path "~/.emacs.d/extensions/deno-bridge-jieba/")
(require 'deno-bridge-jieba)
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "M-b") 'deno-bridge-jieba-backward-word)
  (define-key org-mode-map (kbd "M-d") 'deno-bridge-jieba-kill-word)
  (define-key org-mode-map (kbd "M-f") 'deno-bridge-jieba-forward-word)
  (define-key org-mode-map (kbd "M-DEL") 'deno-bridge-jieba-backward-kill-word)
  )

(provide 'init-deno-bridge-jieba)
