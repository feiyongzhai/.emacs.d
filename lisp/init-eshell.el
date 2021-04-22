;;; init-eshell.el  --- configs for eshell

;;; Code:

;;; eshell 定制
(defun user/eshell ()
  "如果 *eshell* buffer 存在就跳转到这个 buffer，没有就新建一个，
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
(define-key global-map (kbd "C-t") 'user/eshell)

;; (require 'aweshell)

(provide 'init-eshell)
;;; init-eshell.el ends here.
