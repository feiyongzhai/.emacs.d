(require 'init-func)

;; Pulse
(global-set-key (kbd "C-c H") 'fei-pulse-current-line)

;; Misc
(global-set-key (kbd "C-M-=") 'calculator)
(global-set-key (kbd "<f7>") 'fei-ff-find-other-file-pdf-org)
(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "<f12>") 'fei-emacs) ;use for quick debug

(global-set-key (kbd "<insert>") 'fei-occur-at-point)
(global-set-key (kbd "<insertchar>") 'fei-occur-at-point)
(global-set-key (kbd "C-x F") 'set-fill-column)

;; (add-hook 'server-after-make-frame-hook 'fei-resize-frame)
;; (defun fei-resize-frame ()
;;   (interactive)
;;   (when (display-graphic-p)
;;     (set-frame-width nil 125)))

(provide 'init-key)
