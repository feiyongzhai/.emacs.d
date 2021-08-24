;;; windows 平台专属

;;; @REF https://emacs.stackexchange.com/questions/63733/launch-an-external-command-prompt-cmd-exe-in-a-specific-folder
(defun file-manager-here()
  "Open an external Windows cmd in the current directory"
  (interactive)
  (let ((default-directory
	  (if (buffer-file-name)
              (file-name-directory (buffer-file-name))
            default-directory))))
  (call-process-shell-command "start explorer ."))

(defun wt()
  "Open an external Windows cmd in the current directory"
  (interactive)
  (let ((default-directory
      (if (buffer-file-name)
               (file-name-directory (buffer-file-name))
               default-directory))))
    (call-process-shell-command "start wt"))

(provide 'init-win10)
