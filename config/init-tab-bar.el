(setq tab-bar-select-tab-modifiers '(meta)) ;这个需要在 tab-bar-mode 启用之前
(setq tab-bar-format
      '(
	tab-bar-format-treemacs-button
	;; tab-bar-format-menu-bar
	;; tab-bar-format-history
	tab-bar-format-tabs
	tab-bar-separator
	tab-bar-format-add-tab
	tab-bar-separator
	;; tab-bar-format-align-right
	;; tab-bar-format-global
	))

(defun tab-bar-format-treemacs-button ()
  "Produce the Menu button for the tab bar that shows the menu bar."
  `((menu-bar menu-item (propertize "📁" 'face 'tab-bar-tab-inactive)
     treemacs :help "Treemacs Side")))

(setq tab-bar-show t)
(tab-bar-history-mode)

(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice nil)	;duplicate tab
(setq tab-bar-close-last-tab-choice nil)
(setq tab-bar-tab-name-function 'tab-bar-tab-name-truncated)

(setq tab-bar-new-tab-to 'rightmost)
(defun fei-tab-duplicate-advisor (orig-fun &rest args)
  (let ((tab-bar-new-tab-to 'right))
    (apply orig-fun args)))
(advice-add 'tab-bar-duplicate-tab :around 'fei-tab-duplicate-advisor)

(defun fei-select-tab (&optional tab-number)
  "抄的 `tab-bar-select-tab'"
  (interactive "P")
  (unless (integerp tab-number)
    (let ((key (event-basic-type last-command-event)))
      (setq tab-number (if (and (characterp key) (>= key ?1) (<= key ?9))
                           (- key ?0)
                         0))))
  (let* ((tabs (funcall tab-bar-tabs-function))
	 (from-index (tab-bar--current-tab-index tabs)))
    (if (> tab-number (length tabs))
	(tab-new)
      (tab-bar-select-tab tab-number))))


(defun fei-switch-current-buffer-to-new-tab ()
  (interactive)
  (let ((cur-buf (current-buffer)))
    (winner-undo)			;切换回上一个状态
    (switch-to-buffer-other-tab cur-buf)))

(provide 'init-tab-bar)
