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
         (define-key map (kbd "C-y") #'kill-ring-save) ;这个设置很巧妙
         (define-key map "Y" (lambda
                               (b e)
                               (interactive "r")
                               (kill-new (buffer-substring b e))
                               (message "Region saved")))
	 
         (define-key map "q" #'query-replace)
         (define-key map "Q" #'query-replace-regexp)

	 ;; Navigate
	 (define-key map "n" #'next-line)
	 (define-key map "p" #'previous-line)
	 (define-key map "e" #'end-of-line)
	 (define-key map "a" #'beginning-of-line)
	 (define-key map "b" #'backward-char)
	 (define-key map "f" #'forward-char)

	 (define-key map "g" #'keyboard-quit)

         ;; mark things
         (define-key map "d" #'mark-defun)
         (define-key map "i" #'er/mark-inside-pairs)

         ;; expand-region
         (define-key map (kbd "-") #'er/contract-region)
         (define-key map (kbd "=") #'er/expand-region)
         map))))

(global-set-key (kbd "M-O") 'set-mark-command)
;; 这个命令的影响范围还不熟悉，需要在实际应用中测试
(add-to-list 'emulation-mode-map-alists
             'angel-transient-mode-map-alist t)

(provide 'init-mark)
