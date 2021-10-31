;;; Kill/Yank
(global-set-key (kbd "M-L") 'duplicate-current-line)
(global-set-key (kbd "<C-M-backspace>") 'backward-kill-sexp)

;;; Movement/Navigate
(global-set-key (kbd "M-s s") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "M-a") 'beginning-of-defun)
(global-set-key (kbd "M-e") 'end-of-defun)
(global-set-key (kbd "C-'") 'avy-goto-line)
(global-set-key (kbd "M-g M-g") 'goto-line-preview)
;;; Cursor Movement (experimental config)
(setq recenter-positions '(top middle bottom))

(setq neo-theme 'ascii)
(global-set-key (kbd "C-c n") 'neotree-toggle)
(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "j") 'isearch-forward)
  (define-key neotree-mode-map (kbd "J") 'isearch-backward)
  (define-key neotree-mode-map (kbd "f") 'neotree-enter)
  )

;;; Scroll
(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)
(global-set-key (kbd "M-N") 'scroll-up-line)
(global-set-key (kbd "M-n") 'scroll-up-line)
(global-set-key (kbd "M-P") 'scroll-down-line)
(global-set-key (kbd "M-p") 'scroll-down-line)

;;; Mark
(global-set-key (kbd "C-x C-p") 'mark-paragraph)
(global-set-key (kbd "C-,") 'set-mark-command)

;;; Misc
(global-set-key (kbd "C-x u") 'transient-undo)
(global-set-key (kbd "C-=") 'align-regexp)
(global-set-key (kbd "<f7>") 'scratch)
(global-set-key (kbd "<C-return>") 'fei-newline)
(global-set-key (kbd "M-RET") 'fei-newline)
(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "M-s ;") 'iedit-mode)
(global-set-key (kbd "C-x l") 'ialign)

;;; @REF: https://karthinks.com/software/batteries-included-with-emacs/
(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "C-x C-l") 'consult-focus-lines)
(global-set-key (kbd "C-x C-u") 'undo)


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

;;; }} Func

(provide 'init-edit)
