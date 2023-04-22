(add-to-list 'load-path "~/.emacs.d/extensions/fei")

(require 'fei-clock)			;fei-clock
(require 'searchbox)			;searchbox
(require 'vxref)
;; (require 'tab-bar-mode-indicator)



;; (add-hook 'server-after-make-frame-hook 'fei-resize-frame)
;; (defun fei-resize-frame ()
;;   (interactive)
;;   (when (display-graphic-p)
;;     (set-frame-width nil 125)))


;; require `pulse' library
(defun fei-pulse-current-line ()
  (interactive)
  (require 'hl-line)
  (pulse-momentary-highlight-one-line (point) 'hl-line))


;; 一行流，哈哈
(defvar pre-frame-height (frame-height))

(defun fei-frame-one-line ()
  (interactive)
  (let ((ch (frame-height)))
    (if (eq ch 5)
	(set-frame-height nil pre-frame-height)
      (setq pre-frame-height ch)
      (set-frame-height nil 5))))

;; (add-hook 'org-capture-mode-hook (lambda () (set-window-text-height nil 1)))


(defun fei-ff-find-other-file-pdf-org ()
  (interactive)
  (let* ((name (or (buffer-file-name)
		   (buffer-name)))
	 (current-ext (file-name-extension name))
	 (current-name (file-name-sans-extension name)))
    (cond ((string= current-ext "org")
	   (find-file (concat current-name ".pdf")))
	  ((string= current-ext "md")
	   (find-file (concat current-name ".pdf")))
	  ((string= current-ext "pdf")
	   (find-file (concat current-name ".org")))
	  (t (message "当前不支持这个文件")))))



(defun switch-to-same-major-mode-buffer ()
  "切换到和当前 buffer 相同 major-mode 的 buffer"
  (interactive)
  (let (filtered-buf
	(cur-major-mode major-mode))
    (dolist (buf (cdr (buffer-list)))
      ;; 不显示当前 buffer
      (with-current-buffer buf
	(when (eq major-mode cur-major-mode)
	  (push buf filtered-buf))))
    (switch-to-buffer
     (completing-read
      "Switch to buffer with same major-mode: "
      (mapcar (lambda (buf) (buffer-name buf)) filtered-buf)))))

(defun switch-to-locked-buffer ()
  "切换到启用 `emacs-lock-mode' 的 buffer

这样可以把 `emacs-lock-mode' 作为书签来用标记 “重要” buffer 的方法"
  (interactive)
  (let (filtered-buf
	(cur-major-mode major-mode))
    (dolist (buf (cdr (buffer-list)))
      ;; 不显示当前 buffer
      (with-current-buffer buf
	(when (bound-and-true-p emacs-lock-mode)
	  (push buf filtered-buf))))
    (switch-to-buffer
     (completing-read
      "Switch to locked buffer: "
      (mapcar (lambda (buf) (buffer-name buf)) filtered-buf)))))

(provide 'init-fei)
