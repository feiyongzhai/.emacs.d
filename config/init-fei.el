(add-to-list 'load-path "~/.emacs.d/extensions/fei")

(require 'vxref)
;; (require 'tab-bar-mode-indicator)


;; 一行流，哈哈
(defvar pre-frame-height (frame-height))

(defun fei-frame-one-line ()
  (interactive)
  (let ((ch (frame-height)))
    (if (eq ch 5)
	(set-frame-height nil pre-frame-height)
      (setq pre-frame-height ch)
      (set-frame-height nil 5)
      )))

(global-set-key (kbd "C-c 1") 'fei-frame-one-line)

(add-hook 'org-capture-mode-hook (lambda () (set-window-text-height nil 1)))

(provide 'init-fei)
