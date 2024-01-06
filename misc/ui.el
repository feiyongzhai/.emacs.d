;; 根据时间切换主题
(let ((current-hour (string-to-number (format-time-string "%H"))))
  (if (and (> current-hour 7)
           (< current-hour 17))
      (load-theme 'spacemacs-light t)
    (load-theme 'spacemacs-dark t)))

;;;;;;;;;;;; mode-line ;;;;;;;;;;;;

;; == 修改 mode-line 的一个示例 ==

(setq mode-line-format
      `(:propertize (:eval (buffer-name))
            help-echo "Major mode\n\
mouse-1: Display major mode menu\n\
mouse-2: Show help for major mode\n\
mouse-3: Toggle minor modes"
	    face bold
            mouse-face highlight
            local-map ,(make-mode-line-mouse-map 'mouse-1 my-menu-bar-menu)))

;; 把 modeline 到顶部
(setq-default header-line-format mode-line-format) ; Copy mode-line
(setq-default mode-line-format nil) ; Remove mode-line

;;;;;;;;;;;; Tool-bar ;;;;;;;;;;;;
(tool-bar-add-item "spell" 'global-tab-line-mode 'global-tab-line-mode)

(define-key-after (default-value 'tool-bar-map) [separator-fei] menu-bar-separator)

(tool-bar-add-item-from-menu 'previous-buffer "left-arrow" nil :vert-only t)
(tool-bar-add-item-from-menu 'next-buffer "right-arrow" nil :vert-only t)
(tool-bar-add-item "left-arrow" 'previous-buffer 'previous-buffer :label "")
(tool-bar-add-item "right-arrow" 'next-buffer 'next-buffer :label "")

(let ((tool-bar-map (default-value 'tool-bar-map)))
  (tool-bar-add-item "index" (lambda ()
			       (interactive)
			       (popup-menu my-menu-bar-menu))
		     'help
		     :help "Pop up the Help menu"
		     :label ""))

;;;;;;;;;;;; tab-line ;;;;;;;;;;;;

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
