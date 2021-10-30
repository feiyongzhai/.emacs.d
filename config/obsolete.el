;;; 一些过时的配置和函数，留着给以后做参考

;; {{ `display-line-numbers-cycle'
(defvar display-line-numbers-relative-p nil)

(defun display-line-numbers-cycle ()
  (interactive)
  (if display-line-numbers-relative-p
      (progn (menu-bar--display-line-numbers-mode-absolute)
	     (setq display-line-numbers-relative-p nil))
    (menu-bar--display-line-numbers-mode-relative)
    (setq display-line-numbers-relative-p t)))
;; }} 


;; {{ `next-same-major-mode-buffer'

;; (transient-command next-same-major-mode-buffer
;;   (next-same-major-mode-buffer)
;;   '(("m" . next-same-major-mode-buffer)))

(defun next-same-major-mode-buffer ()
  "Go to next buffer which has same major-mode of current buffer

this command is useful only when current buffer's major mode is
`eshell-mode', `eaf-mode', `term-mode', `shell-mode' or other
special major mode"
  (interactive)
  (let ((current major-mode))
    (catch 'done
      ;; `buffer-list' is changeable variable, the recently visited
      ;; buffer always next to the current buffer, if I do not use
      ;; `reverse', and if there is one buffer having same major mode
      ;; with current buffer, it will back and forth these two buffer,
      ;; despite there potentially are other buffers having the same
      ;; major mode with current buffer.
      (dolist (buf (reverse (cdr (buffer-list))) (message "only one `%s' buffer" current))
	(with-current-buffer buf
	  (when (eq current major-mode)
	    (throw 'done (progn (switch-to-buffer buf)
				(message "next `%s' buffer" current)))))))))
;; }} 


;; {{ ido related config
;;;TODO：ido-mode 下的 minibuffer-complete 对应的是 ido-complete，所以下面的命令需要重新写一下
(define-key minibuffer-local-map (kbd "M-i") 'minibuffer-complete)
;; }} 


;; {{ `fei-search-symbol-at-point'
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
;; }}


;; {{ org-agenda related

;; (when (display-graphic-p)
;;   (org-agenda nil "a")
;;   (delete-other-windows))
;; (add-hook 'server-after-make-frame-hook
;; 	  (lambda () (when window-system
;; 		       (org-agenda nil "a")
;; 		       (delete-other-windows))))

;; }}

;;; {{ vc related config

;; (global-set-key (kbd "s-v") 'vc-prefix-map)
;; (global-set-key (kbd "s-v s-v") 'vc-next-action)

;; (with-eval-after-load 'vc-git
;;   (define-key vc-git-log-edit-mode-map (kbd "M-A") 'vc-git-log-edit-toggle-amend)
;;   (define-key vc-git-log-edit-mode-map (kbd "M-C") 'log-edit-done)
;;   (define-key vc-git-log-edit-mode-map (kbd "M-D") 'log-edit-show-diff))

;;; }}


;;; {{ matlab related
(autoload 'org-ctrl-c-ctrl-c "org" nil t) ; hack for matlab-mode
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "C-c C-c") 'org-ctrl-c-ctrl-c))
;;; }}
