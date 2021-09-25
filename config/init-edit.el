;;; Keys
;;; Kill/Yank
(global-set-key (kbd "M-L") 'duplicate-current-line)
(global-set-key (kbd "<C-M-backspace>") 'backward-kill-sexp)

;;; Movement/Navigate
(global-set-key (kbd "M-s s") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "M-a") 'beginning-of-defun)
(global-set-key (kbd "M-e") 'end-of-defun)
(global-set-key (kbd "C-'") 'avy-goto-line)

;;; Scroll
(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)
(global-set-key (kbd "M-N") 'scroll-up-line)
(global-set-key (kbd "M-P") 'scroll-down-line)

;;; Misc
(global-set-key (kbd "C-x u") 'transient-undo)
(global-set-key (kbd "C-=") 'align-regexp)
(global-set-key (kbd "<f7>") 'scratch)
(global-set-key (kbd "C-,") 'set-mark-command)
(global-set-key (kbd "<C-return>") 'fei-newline)
(global-set-key (kbd "M-RET") 'fei-newline)

;;; {{ Func

(defun fei-newline ()
  (interactive)
  (end-of-line)
  (newline-and-indent))


;; @see https://www.emacswiki.org/emacs/CopyingWholeLines
;; duplicate current line
(defun duplicate-current-line (&optional n)
  "duplicate current line, make more than 1 copy given a numeric argument"
  (interactive "p")
  (save-excursion
    (let ((nb (or n 1))
    	  (current-line (thing-at-point 'line)))
      ;; when on last line, insert a newline first
      (when (= 1 (forward-line 1))
    	(insert "\n"))
      
      ;; now insert as many time as requested
      (while (> n 0)
    	(insert current-line)
    	(decf n)))))

(defun fei-search-symbol-at-point ()
  (interactive)
  (cond
   ((bounds-of-thing-at-point 'symbol)
    (if ctrlf-local-mode
	(call-interactively 'ctrlf-forward-symbol-at-point)
      (call-interactively 'isearch-forward-symbol-at-point)))
   (t
    (if ctrlf-local-mode
	(ctrlf-forward-default)
      (isearch-forward)))))

;;; }} Func

(provide 'init-edit)
