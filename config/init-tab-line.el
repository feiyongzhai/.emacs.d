(require 'tab-line)

(setq tab-line-tab-name-function 'tab-line-tab-name-truncated-buffer)
;;; `face-spec-set' 和 `custom-set-faces' 还是有点区别的
(face-spec-set 'tab-line
	       '((t (:inherit nil :height 0.95))))
;; (custom-set-faces
;;  '(tab-line ((t (:inherit nil :background "grey85" :foreground "black" :height 0.95)))))

(global-set-key (kbd "C-x <left>") 'tab-line-switch-to-prev-tab)
(global-set-key (kbd "C-x <right>") 'tab-line-switch-to-next-tab)
(define-key tab-line-tab-map [tab-line down-mouse-3] 'tab-line-close-tab) ;tab-line-tab-context-menu

;; 在这个操作之后，再用鼠标左键选 tab-line 会出现标签跳动的情况
(global-set-key (kbd "<tab-line> <C-mouse-3>") 'tab-line-kill-this-buffer)

(defun tab-line-kill-this-buffer ()
  (interactive)
  (call-interactively 'tab-line-select-tab)
  (kill-this-buffer))


(provide 'init-tab-line)
