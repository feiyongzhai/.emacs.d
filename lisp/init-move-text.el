(require 'move-text)
(define-key paredit-mode-map (kbd "<M-down>") nil)
(define-key paredit-mode-map (kbd "<M-up>") nil)

(define-key global-map (kbd "<M-up>") #'move-text-up)
(define-key global-map (kbd "<M-down>") #'move-text-down)

(provide 'init-move-text)
