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
     treemacs-dired-jump :help "Treemacs Side")))

(setq tab-bar-show t)
(tab-bar-history-mode)

(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice nil)	;duplicate tab
(setq tab-bar-close-last-tab-choice nil)
(setq tab-bar-tab-name-function 'tab-bar-tab-name-truncated)
(setq tab-bar-tab-name-format-function 'fei/tab-bar-tab-name-format-default)

(setq tab-bar-new-tab-to 'rightmost)
(defun fei-tab-duplicate-advisor (orig-fun &rest args)
  (let ((tab-bar-new-tab-to 'right))
    (apply orig-fun args)))
(advice-add 'tab-bar-duplicate-tab :around 'fei-tab-duplicate-advisor)

(defun fei/tab-bar-tab-name-format-default (tab i)
  (let ((current-p (eq (car tab) 'current-tab)))
    (propertize
     (concat (if tab-bar-tab-hints (format "工作区 %d " i) "")
             ;; (alist-get 'name tab)
             (or (and tab-bar-close-button-show
                      (not (eq tab-bar-close-button-show
                               (if current-p 'non-selected 'selected)))
                      tab-bar-close-button)
                 ""))
     'face (funcall tab-bar-tab-face-function tab))))

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
    (tab-bar-history-back)		;切换回上一个状态
    (switch-to-buffer-other-tab cur-buf)))


(with-eval-after-load 'tab-bar
  (defun tab-bar-mouse-context-menu (event)
    "魔改Pop up the context menu for the tab on which you click."
    (interactive "e")
    (let* ((item (tab-bar--event-to-item (event-start event)))
           (tab-number (tab-bar--key-to-number (nth 0 item)))
           (menu (make-sparse-keymap (propertize "Context Menu" 'hide t))))

      (cond
       ((eq tab-number t)
	(define-key-after menu [new-tab]
          '(menu-item "New tab" tab-bar-new-tab
                      :help "Create a new tab"))
	(when tab-bar-closed-tabs
          (define-key-after menu [undo-close]
            '(menu-item "Reopen closed tab" tab-bar-undo-close-tab
			:help "Undo closing the tab"))))

       (t
	(define-key-after menu [open-in-vscode]
          `(menu-item "Open in vscode" code
                      :help "Open in vscode"))
	(define-key-after menu [duplicate-tab]
          `(menu-item "Duplicate" (lambda () (interactive)
                                    (tab-bar-duplicate-tab
                                     nil ,tab-number))
                      :help "Clone the tab"))
	(define-key-after menu [detach-tab]
          `(menu-item "Detach" (lambda () (interactive)
				 (tab-bar-detach-tab
                                  ,tab-number))
                      :help "Move the tab to new frame"))
	(define-key-after menu [close]
          `(menu-item "Close" (lambda () (interactive)
				(tab-bar-close-tab ,tab-number))
                      :help "Close the tab"))
	(define-key-after menu [close-other]
          `(menu-item "Close other tabs"
                      (lambda () (interactive)
			(tab-bar-close-other-tabs ,tab-number))
                      :help "Close all other tabs"))))

      (popup-menu menu event))))

(provide 'init-tab-bar)
