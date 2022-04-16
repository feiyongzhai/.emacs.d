;; (tool-bar-add-item "spell" 'global-tab-line-mode 'global-tab-line-mode)

(define-key-after (default-value 'tool-bar-map) [separator-fei] menu-bar-separator)
;; (tool-bar-add-item-from-menu 'previous-buffer "left-arrow" nil :vert-only t)
;; (tool-bar-add-item-from-menu 'next-buffer "right-arrow" nil :vert-only t)
;; (tool-bar-add-item "left-arrow" 'previous-buffer 'previous-buffer :label "")
;; (tool-bar-add-item "right-arrow" 'next-buffer 'next-buffer :label "")

(let ((tool-bar-map (default-value 'tool-bar-map)))
  (tool-bar-add-item "index" (lambda ()
			      (interactive)
			      (popup-menu my-menu-bar-menu))
		     'help
		     :help "Pop up the Help menu"
		     :label ""))

(provide 'init-tool-bar)

