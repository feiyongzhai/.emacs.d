(setq all-the-icons-ibuffer-color-icon nil)

(custom-set-faces
 '(all-the-icons-ibuffer-mode-face ((t nil)))
 '(all-the-icons-ibuffer-size-face ((t nil)))
 '(all-the-icons-ibuffer-file-face ((t nil)))
 '(all-the-icons-ibuffer-icon-face ((t nil)))
 )

(add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)
(add-hook 'ibuffer-mode-hook 'hl-line-mode)
(autoload 'ibuffer-bs-toggle-all "ibuf-ext" nil t)

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
	      " " filename)
	(mark
         (mode+ 2 15 :left :elide)
	 " "
	 #(" " 0 1
	   (display
	    (space :align-to 18)))
	 (name 18 -1 :left)
	 " "
	 )))

(defun fei-remove-ibuffer-tmp-hide-regexps ()
  "`ibuffer-add-to-tmp-hide' 的逆向命令"
  (interactive)
  (with-current-buffer "*Ibuffer*"
    (when ibuffer-tmp-hide-regexps
      (setq ibuffer-tmp-hide-regexps
            (remove
             (ivy-read "Pop tmp hide buffer " ibuffer-tmp-hide-regexps)
             ibuffer-tmp-hide-regexps)))))

(defun ibuffer-toggle-notes ()
  "抄的 `ibuffer-bs-toggle-all'"
  (interactive)
  (if ibuffer-filtering-qualifiers
      (if (equal ibuffer-filtering-qualifiers '((filename . "Nutstore Files/org/")))
	  (ibuffer-pop-filter)
	(ibuffer-pop-filter)
	(ibuffer-push-filter '(filename . "Nutstore Files/org/"))
	(ibuffer-update nil t)
	)
    (progn (ibuffer-push-filter '(filename . "Nutstore Files/org/"))
	   (ibuffer-update nil t))))

(defun ibuffer-toggle-emacs ()
  "抄的 `ibuffer-bs-toggle-all'"
  (interactive)
  (if ibuffer-filtering-qualifiers
      (if (equal ibuffer-filtering-qualifiers '((filename . "\\.emacs\\.d")))
	  (ibuffer-pop-filter)
	(ibuffer-pop-filter)
	(ibuffer-push-filter '(filename . "\\.emacs\\.d"))
	(ibuffer-update nil t)
	)
    (progn (ibuffer-push-filter '(filename . "\\.emacs\\.d"))
	   (ibuffer-update nil t))))

(defun ibuffer-toggle-all ()
  "抄的 `ibuffer-bs-toggle-all'"
  (interactive)
  (if ibuffer-filtering-qualifiers
      (if (equal ibuffer-filtering-qualifiers '((filename . ".*")))
	  (ibuffer-pop-filter)
	(ibuffer-pop-filter)
	(ibuffer-push-filter '(filename . ".*"))
	(ibuffer-update nil t)
	)
    (progn (ibuffer-push-filter '(filename . ".*"))
	   (ibuffer-update nil t))))

(provide 'init-ibuffer)
