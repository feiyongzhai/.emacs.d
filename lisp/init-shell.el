;;; init-eshell.el  --- configs for eshell, shell terminal

;;; Code:

;;; *e?shell* buffer display rule
(add-to-list 'display-buffer-alist
	     '("\\*e?shell\\*"
	       (display-buffer-in-side-window)
	       (window-height . 0.25)
	       (side . bottom)
	       (slot . 0)))

;;; eshell 定制
(defun fei-eshell ()
  "这个函数已经过时

如果 *eshell* buffer 存在就跳转到这个 buffer，没有就新建一个，
如果处于 *eshell* 就跳转到上一个 buffer"
  (interactive)
  (let ((buf (buffer-name)))
    (cond ((string-equal buf "*eshell*")
	   (mode-line-other-buffer))
	  ((get-buffer "*eshell*")
	   (switch-to-buffer "*eshell*"))
	  (t
	   (eshell)))))
;; 按键
(define-key global-map (kbd "<C-return>") 'eshell)

;;; quick open terminal in current dir
(cond (*is-linux*
       (global-set-key (kbd "C-c <C-return>")
		       (lambda ()
			 (interactive)
			 (shell-command "gnome-terminal"))))
      (t
       (global-set-key (kbd "C-c <C-return>")
		       (lambda ()
			 (interactive)
			 (if (fboundp 'terminal-here)
			     (terminal-here))))))


(provide 'init-shell)
;;; init-shell.el ends here.