(global-tab-line-mode 1)
(require 'tab-line)

(setq tab-line-close-button-show t)
(setq tab-line-new-button-show nil)
(setq tab-line-tab-name-function 'tab-line-tab-name-truncated-buffer)

(setq tab-line-separator "|")
(custom-set-faces
 ;; 这个配置对 modus-operandi 和 modus-vivendi 这种对 tab-line 有支持的表现得不好
 '(tab-line ((t (:inherit mode-line :height 0.95))))
 '(tab-line-highlight ((t (:inherit tab-line-tab-current))))
 '(tab-line-tab ((t (:inherit tab-line))))
 ;; '(tab-line-tab-current ((t (:inherit default :height 0.9))))
 '(tab-line-tab-current ((t (:inherit tab-line-tab :underline t))))
 '(tab-line-tab-inactive ((t (:inherit tab-line-tab)))))

;; `face-spec-set' 和 `custom-set-faces' 还是有点区别的，
;; `custom-set-faces' 在更换主题后会重新加载，所以更推荐用
;; `custom-set-faces'

;; (face-spec-set 'tab-line '((t (:inherit mode-line :height 0.95))))
;; (face-spec-set 'tab-line '((t (:inherit nil :height 0.95))))
;; (custom-set-faces
;;  '(tab-line ((t (:inherit nil :background "grey85" :foreground "black" :height 0.95)))))

(global-set-key (kbd "C-x <left>") 'tab-line-switch-to-prev-tab)
(global-set-key (kbd "C-x <right>") 'tab-line-switch-to-next-tab)
(define-key tab-line-tab-map [tab-line down-mouse-3] 'tab-line-close-tab) ;tab-line-tab-context-menu

;; 在这个操作之后，再用鼠标左键选 tab-line 会出现标签跳动的情况
(global-set-key (kbd "<tab-line> <C-mouse-3>") 'tab-line-kill-this-buffer)

(global-set-key (kbd "M-s-j") 'previous-buffer)
(global-set-key (kbd "M-s-k") 'next-buffer)


(defun tab-line-kill-this-buffer ()
  (interactive)
  (call-interactively 'tab-line-select-tab)
  (kill-this-buffer))


(provide 'init-tab-line)
