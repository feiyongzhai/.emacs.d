;; (global-tab-line-mode 1)
;; (require 'tab-line)

(setq tab-line-close-button-show t)
;; (setq tab-line-new-button-show nil)
;; (setq tab-line-tab-name-function 'tab-line-tab-name-truncated-buffer)
;; (setq tab-line-separator "|")

;; `face-spec-set' 和 `custom-set-faces' 还是有点区别的，
;; `custom-set-faces' 在更换主题后会重新加载，所以更推荐用
;; `custom-set-faces'

;; (face-spec-set 'tab-line '((t (:inherit mode-line :height 0.95))))
;; (face-spec-set 'tab-line '((t (:inherit nil :height 0.95))))
;; (custom-set-faces
;;  '(tab-line ((t (:inherit nil :background "grey85" :foreground "black" :height 0.95)))))

(defun tab-line-kill-this-buffer ()
  (interactive)
  (call-interactively 'tab-line-select-tab)
  (kill-this-buffer))

(provide 'init-tab-line)
