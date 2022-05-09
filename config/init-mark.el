;; 增强 transient-mark-mode

;; @REF: https://archive.casouri.cat/note/2018/easy-bindings-when-region-is-active/
(defconst angel-transient-mode-map-alist
  `((mark-active
     ,@(let ((map (make-sparse-keymap)))
         ;; operations
         (define-key map "p" (lambda (b e)
                               (interactive "r") (delete-region b e) (yank)))
         (define-key map "x" #'exchange-point-and-mark)
         (define-key map "y" #'kill-ring-save)
         (define-key map "w" #'kill-ring-save)
         (define-key map "Y" (lambda
                               (b e)
                               (interactive "r")
                               (kill-new (buffer-substring b e))
                               (message "Region saved")))
	 (define-key map (kbd "o") (lambda
				     (b e)
				     (interactive "r")
				     (occur (buffer-substring b e))))
	 (define-key map (kbd "O") (lambda
				     (b e)
				     (interactive "r")
				     (project-find-regexp (buffer-substring b e))))

         (define-key map "q" #'query-replace)
         (define-key map "Q" #'query-replace-regexp)
	 (define-key map "s" #'fei-search-1)
	 (define-key map "\C-m" #'er/expand-region)

	 ;; Navigate
	 (define-key map "n" #'next-line)
	 (define-key map "p" #'previous-line)
	 (define-key map "e" #'end-of-line)
	 (define-key map "a" #'beginning-of-line)
	 (define-key map "b" #'backward-char)
	 (define-key map "f" #'forward-char)
	 (define-key map "m" #'back-to-indentation)

	 (define-key map "g" #'keyboard-quit)
	 (define-key map " " #'keyboard-quit)

	 ;; Surround
	 (define-key map "9" (lambda (b e)
			       (interactive "r")
			       (surround-region-with "(" b e)))
	 
         ;; mark things
         (define-key map "d" #'mark-defun)
         (define-key map "i" #'er/mark-inside-pairs)

         ;; expand-region
         (define-key map (kbd "-") #'er/contract-region)
         (define-key map (kbd "=") #'er/expand-region)
         map))))

(defun surround-region-with (pair b e)
  (let ((origin-str (buffer-substring b e))
	(pair-right (pcase pair
		      ("(" ")")
		      ("{" "}")
		      ("[" "]"))))
    (delete-active-region)
    (save-excursion
      (insert (concat pair origin-str pair-right))))
  (deactivate-mark))

;; 这个命令的影响范围还不熟悉，需要在实际应用中测试
(add-to-list 'emulation-mode-map-alists
             'angel-transient-mode-map-alist t)

(provide 'init-mark)
