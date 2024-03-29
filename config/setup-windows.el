;; @REF: https://github.com/karthink/.emacs.d/blob/5c9bb4102e53a60a7f6df2d3fb1cad5086114d1b/lisp/setup-windows.el

;;;###autoload
(defun buffer-mode (&optional buffer-or-name)
  "Returns the major mode associated with a buffer.
If buffer-or-name is nil return current buffer's mode."
  (buffer-local-value 'major-mode
                      (if buffer-or-name
                          (get-buffer buffer-or-name)
                        (current-buffer))))

(defvar my/occur-grep-modes-list '(occur-mode
                                   grep-mode
                                   xref--xref-buffer-mode
                                   ivy-occur-grep-mode
                                   ivy-occur-mode
                                   locate-mode
                                   flymake-diagnostics-buffer-mode
                                   rg-mode)
  "List of major-modes used in occur-type buffers")

(defvar my/help-modes-list '(helpful-mode
                             help-mode
                             pydoc-mode
                             TeX-special-mode)
  "List of major-modes used in documentation buffers")

(defvar my/message-modes-list '(compilation-mode
                                edebug-eval-mode)
  "List of major-modes used in message buffers")

;; display-buffer-action-functions are:
;;  `display-buffer-same-window' -- Use the selected window.
;;  `display-buffer-reuse-window' -- Use a window already showing the buffer.
;;  `display-buffer-in-previous-window' -- Use a window that did show the buffer before.
;;  `display-buffer-use-some-window' -- Use some existing window.
;;  `display-buffer-pop-up-window' -- Pop up a new window.
;;  `display-buffer-below-selected' -- Use or pop up a window below the selected one.
;;  `display-buffer-at-bottom' -- Use or pop up a window at the bottom of the selected frame.
;;  `display-buffer-pop-up-frame' -- Show the buffer on a new frame.
;;  `display-buffer-in-child-frame' -- Show the buffer in a child frame.
;;  `display-buffer-no-window' -- Do not display the buffer and have `display-buffer' return nil immediately.

;; Action alist entries are:
;;  `inhibit-same-window' -- A non-nil value prevents the same
;;     window from being used for display.
;;  `inhibit-switch-frame' -- A non-nil value prevents any frame
;;     used for showing the buffer from being raised or selected.
;;  `reusable-frames' -- The value specifies the set of frames to
;;     search for a window that already displays the buffer.
;;     Possible values are nil (the selected frame), t (any live
;;     frame), visible (any visible frame), 0 (any visible or
;;     iconified frame) or an existing live frame.
;;  `pop-up-frame-parameters' -- The value specifies an alist of
;;     frame parameters to give a new frame, if one is created.
;;  `window-height' -- The value specifies the desired height of the
;;     window chosen and is either an integer (the total height of
;;     the window), a floating point number (the fraction of its
;;     total height with respect to the total height of the frame's
;;     root window) or a function to be called with one argument -
;;     the chosen window.  The function is supposed to adjust the
;;     height of the window; its return value is ignored.  Suitable
;;     functions are `shrink-window-if-larger-than-buffer' and
;;     `fit-window-to-buffer'.
;;  `window-width' -- The value specifies the desired width of the
;;     window chosen and is either an integer (the total width of
;;     the window), a floating point number (the fraction of its
;;     total width with respect to the width of the frame's root
;;     window) or a function to be called with one argument - the
;;     chosen window.  The function is supposed to adjust the width
;;     of the window; its return value is ignored.
;;  `preserve-size' -- The value should be either (t . nil) to
;;     preserve the width of the chosen window, (nil . t) to
;;     preserve its height or (t . t) to preserve its height and
;;     width in future changes of the window configuration.
;;  `window-parameters' -- The value specifies an alist of window
;;     parameters to give the chosen window.
;;  `allow-no-window' -- A non-nil value means that `display-buffer'
;;     may not display the buffer and return nil immediately.

(setq display-buffer-alist
      '(
        ("^\\*julia\\*"
         (display-buffer-reuse-window
          display-buffer-in-direction
          display-buffer-in-side-window)
         (window-height . .35)
         (window-width .  .40)
         ;; (preserve-size . (nil . t))
         (direction . below)
         (side . bottom)
         (slot . 1))
        ;; ----------------------------------------------------------------
        ;; Windows on top
        ;; ----------------------------------------------------------------

        ("\\*\\(?:Org Select\\|Agenda Commands\\)\\*"
         (display-buffer-in-side-window)
         (body-function . select-window)
         (window-height . (lambda (win) (fit-window-to-buffer win)))
         (side . top)
         (slot . -2)
         (preserve-size . (nil . t))
         (window-parameters . ((mode-line-format . nil))))

        ((lambda (buf act) (member (buffer-mode buf) my/occur-grep-modes-list))
         (display-buffer-reuse-mode-window
          display-buffer-in-direction
          display-buffer-in-side-window)
         (side . top)
         (slot . 5)
         (window-height . (lambda (win) (fit-window-to-buffer win 20 10)))
         (direction . above)
         ;; (body-function . select-window)
	 ;; 这个参数会影响 isearch-occur ，因为默认是不选择的
	 )

        ("\\*\\(Flycheck\\|Package-Lint\\).*"
         (display-buffer-in-direction display-buffer-in-side-window)
         (direction . above)
         (window-height . shrink-window-if-larger-than-buffer)
         ;; (window-height . 0.16)
         (side . top)
         (slot . 1)
         (window-parameters . (
                               (no-other-window . t))))

        ;; ----------------------------------------------------------------
        ;; Windows on the side
        ;; ----------------------------------------------------------------

        ("\\*Faces\\*" (display-buffer-in-side-window)
         (window-width . 0.25)
         (side . right)
         (slot . -2)
         (window-parameters . ((no-other-window . t)
                               )))

        ;; ----------------------------------------------------------------
        ;; Windows at the bottom
        ;; ----------------------------------------------------------------

        ("\\*Backtrace\\*" (display-buffer-in-side-window)
         (window-height . 0.20)
         (side . bottom)
         (slot . -9)
         )

        ("\\*RefTex" (display-buffer-in-side-window)
         (window-height . 0.25)
         (side . bottom)
         (slot . -9)
         )

        ((lambda (buf act) (member (buffer-mode buf) my/message-modes-list))
         (display-buffer-at-bottom display-buffer-in-side-window)
         (window-height . 0.25)
         (side . bottom)
         (slot . -6)
         )

        ("\\*\\(?:Warnings\\|Compile-Log\\|Messages\\)\\*" ;\\|Tex Help\\|TeX errors
         (display-buffer-at-bottom display-buffer-in-side-window display-buffer-in-direction)
         (window-height . (lambda (win) (fit-window-to-buffer
                                         win
                                         (floor (frame-height) 5))))
         (side . bottom)
         (direction . below)
         (slot . -5)
         ;; (preserve-size . (nil . t))
         (window-parameters . ((split-window . #'ignore)
                               )))

        ("\\(?:[Oo]utput\\)\\*" display-buffer-in-side-window
         (window-height . (lambda (win)
                            (fit-window-to-buffer win (floor (frame-height) 2.5))))
         (side . bottom)
         (slot . -4)
         )

        ("\\*Async Shell Command\\*" display-buffer-in-side-window
         (window-height . 0.20)
         (side . bottom)
         (slot . -4)
         ;; (preserve-size . (nil . t))
         (window-parameters . ((no-other-window . t)
                               )))

        ("\\*\\(Register Preview\\).*" (display-buffer-in-side-window)
         (window-height . 0.20)       ; See the :hook
         (side . bottom)
         (slot . -3)
         (window-parameters . ((no-other-window . t)
                               )))

        ("\\*Completions\\*" (display-buffer-in-side-window)
         (window-height . 0.20)
         (side . bottom)
         (slot . 2) ;这个里面有一点黑魔法， popper-mode 默认的 slot 是 1 这个是会有复用的表现，体验很奇妙
         )

	;; 备忘
	;; ((lambda (buf act) (with-current-buffer buf (eq major-mode 'pdf-view-mode)))
	;;  (display-buffer-in-direction
	;;   ;; 用 `display-buffer-in-side-window' 会 `dirvish-side' 纠缠，出现我不能理解的行为
	;;   )
        ;;  (window-width . 0.4)		;配合窗口最大化使用
        ;;  (direction . right)
	;;  (window-parameters . (
	;; 		       (preserve-size . (t . nil))
	;; 		       (no-delete-other-windows . t)
        ;;                        ))
        ;;  (slot . 0)
        ;;  )

	("CAPTURE-.*" (display-buffer-in-direction)
         (window-height . 0.20)
         (direction . bottom)
         (slot . 0)
         )

	("\\*vc-dir\\*.*" (display-buffer-in-direction)
         (window-height . 0.5)
         (direction . bottom)
         (slot . 0)
         )

        ("\\*Apropos\\*" (display-buffer-in-side-window)
         ;; (window-height . 0.40)
         (window-width . 65)
         (side . right)
         (slot . -2)
         (window-parameters . (;; (no-other-window . t)
                               )))

        ((lambda (buf act) (member (buffer-mode buf) my/help-modes-list))
         (display-buffer-reuse-window
          display-buffer-in-direction
          display-buffer-in-side-window)
         (body-function . select-window)
         ;; (direction . bottom)
         (window-width . 77 ;; (lambda (win) (fit-window-to-buffer win nil nil 75 65))
                       )
         (direction . below)
         (side . right)
         (slot . 2)
         (window-parameters . ((split-window . #'ignore)
                               )))

        ("^\\*eldoc\\*$"
         (display-buffer-reuse-window
          display-buffer-in-direction
          display-buffer-in-side-window)
         (body-function . select-window)
         ;; (direction . bottom)
         ;; (window-height . (lambda (win) (fit-window-to-buffer win 25 14)))
         (window-width . 82 ;; (lambda (win) (fit-window-to-buffer win nil nil 75 65))
                       )
         (direction . below)
         (side . below)
         (slot . 2)
         (window-parameters . ((split-window . #'ignore)
                               )))

        ((lambda (buf act) (member (buffer-mode buf) '(ibuffer-mode bookmark-bmenu-mode)))
         (;; display-buffer-reuse-window
          ;; display-buffer-in-side-window
          ;;display-buffer-at-bottom
          display-buffer-below-selected)
         (body-function . select-window)
         (direction . below)
         (window-height . (lambda (win) (fit-window-to-buffer win 30 7)))
         ;; (dedicated . t)
         ;; (window-width . (lambda (win) (fit-window-to-buffer win nil nil 85 55)))
         ;; (direction . right)
         (side . bottom)
         (slot . 2))

        ))

(setq window-combination-resize t
      even-window-sizes 'height-only
      window-sides-vertical nil
      fit-window-to-buffer-horizontally t
      window-resize-pixelwise t
      fit-frame-to-buffer t
      )

;;;###autoload
(defun my/display-buffer-at-bottom ()
  "Move the current buffer to the bottom of the frame.  This is
useful to take a buffer out of a side window.

The window parameters of this function are provided mostly for
didactic purposes."
  (interactive)
  (let ((buffer (current-buffer)))
    (with-current-buffer buffer
      (delete-window)
      (display-buffer-at-bottom
       buffer '((window-height . (lambda (win)
                                   (fit-window-to-buffer
                                    win (/ (frame-height) 3)))))))))

(eval-after-load 'org
  (progn
    (defun +org-fix-delete-other-windows-a (orig-fn &rest args)
      "docstring"
      (interactive "P")
      (if popper-mode
          (cl-letf (((symbol-function #'delete-other-windows)
                     (symbol-function #'ignore))
                    ((symbol-function #'delete-window)
                     (symbol-function #'ignore)))
            (apply orig-fn args))
        (apply orig-fn args)))

    (dolist (org-function '(org-add-log-note
                            org-capture-place-template
                            org-export--dispatch-ui
                            org-agenda-get-restriction-and-command
                            org-fast-tag-selection
                            org-fast-todo-selection))

      (advice-add org-function :around #'+org-fix-delete-other-windows-a))))

;; @REF: https://github.com/karthink/.emacs.d/blob/5c9bb4102e53a60a7f6df2d3fb1cad5086114d1b/lisp/better-buffers.el#L75
(defun my/delete-window-or-delete-frame (&optional window)
  "Delete WINDOW using `delete-window'.
If this is the sole window run `delete-frame' instead. WINDOW
must be a valid window and defaults to the selected one. Return
nil."
  (interactive)
  (condition-case nil
      (progn
        (bury-buffer)
        (delete-window window))
    (error (cond ((minibufferp)
		  (keyboard-escape-quit))
		 ((and tab-bar-mode
                       (> (length (funcall tab-bar-tabs-function)) 1))
		  (tab-bar-close-tab))
		 (t
		  (delete-frame))
		 ))))

(provide 'setup-windows)
