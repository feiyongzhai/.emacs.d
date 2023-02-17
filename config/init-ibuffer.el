(global-set-key (kbd "C-x C-b") 'ibuffer-jump)
(add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)
(add-hook 'ibuffer-mode-hook 'hl-line-mode)

(setq all-the-icons-ibuffer-formats
      '((mark modified read-only locked " "
	      (icon 2 2 :left :elide)
	      #(" " 0 1
		(display
		 (space :align-to 8)))
	      (name 18 18 :left :elide)
	      " "
	      (size-h 9 -1 :right)
	      " "
	      (mode+ 16 16 :left :elide)
	      " " filename-and-process+)
	(mark " "
	      (icon 2 2 :left :elide)
	      (name 16 -1)
	      " " filename)))

(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line) ;was `ibuffer-jump-to-buffer'
  (define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line) ;was `ibuffer-kill-line'
  (define-key ibuffer-mode-map (kbd "_") 'fei-remove-ibuffer-tmp-hide-regexps)
  )

(defun fei-remove-ibuffer-tmp-hide-regexps ()
  "`ibuffer-add-to-tmp-hide' 的逆向命令"
  (interactive)
  (with-current-buffer "*Ibuffer*"
    (when ibuffer-tmp-hide-regexps
      (setq ibuffer-tmp-hide-regexps
            (remove
             (ivy-read "Pop tmp hide buffer " ibuffer-tmp-hide-regexps)
             ibuffer-tmp-hide-regexps)))))

(provide 'init-ibuffer)
