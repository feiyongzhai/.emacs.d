;; (setq-default cursor-type 'bar)

;; (add-to-list 'load-path "~/.emacs.d/extensions")
;; (require 'cursor-chg)	       ; Load this library
;; 
;; (change-cursor-mode 1)	       ; On for overwrite/read-only/input mode
;; (add-hook 'post-command-hook
;; 	  ;; 让 `change-cursor-mode' 的默认光标颜色根据主题背景更新，
;; 	  ;; 这一行需要在 (change-cursor-mode 1) 后面
;; 	  (lambda ()
;; 	    (setq curchg-default-cursor-color (face-attribute 'cursor :background))
;; 	    (setq curchg-input-method-cursor-color (face-attribute 'cursor :background))))
;; 
;; (curchg-change-cursor-when-idle-interval 5)
;; (toggle-cursor-type-when-idle 1)	; On when idle


(add-hook 'post-command-hook 'fei-change-cursor-when-readonly)
(defun fei-change-cursor-when-readonly ()
  (if buffer-read-only
      (setq cursor-type 'hollow)
    (setq cursor-type 'bar)))

(provide 'init-cursor)
