;;; Linux 专用配置

(require 'fei-funcs)

(unless *is-termux*
  (require 'ext-pdf-tools))


;; @REF: https://oremacs.com/page32/
(defun dired-open-term ()
  "Open an `ansi-term' that corresponds to current directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (if (get-buffer "*ansi-term*")
	(switch-to-buffer "*ansi-term*")
      (ansi-term "/bin/bash"))
    (term-send-string
     (get-buffer-process "*ansi-term*")
     (if (file-remote-p current-dir)
         (let ((v (tramp-dissect-file-name current-dir t)))
           (format "ssh %s@%s\n"
                   (aref v 1) (aref v 2)))
       (format "cd '%s'\n" current-dir)))))

(defun fei-term-cd-here ()
  "Open an `ansi-term' that corresponds to current directory."
  (interactive)
  (let ((current-dir default-directory))
    (if (get-buffer "*ansi-term*")
	(switch-to-buffer "*ansi-term*")
      (ansi-term "/bin/bash"))
    (term-send-string
     (get-buffer-process "*ansi-term*")
     (if (file-remote-p current-dir)
         (let ((v (tramp-dissect-file-name current-dir t)))
           (format "ssh %s@%s\n"
                   (aref v 1) (aref v 2)))
       (format "cd %s\n" (shell-quote-wildcard-pattern current-dir))))
    (term-send-left)
    (term-send-right)))

(defun fei-ansi-term ()
  (interactive)
  (if (and (get-buffer "*ansi-term*")
	   (term-check-proc "*ansi-term*"))
      (switch-to-buffer "*ansi-term*")
    (ansi-term (getenv "SHELL")))
  ;; Workaround: 避免在 term 中用 back 之后，再在 eshell 中用
  ;; bash(fei-term-cd-here) 会出现光标位置出现在不期望的地方的情况
  (term-send-left)
  (term-send-right)
  nil)

(provide 'init-linux)
