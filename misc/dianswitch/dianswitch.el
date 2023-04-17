(defun dian-switch ()
    "Call dianswitch.exe and get user input from ivy-read"
    (interactive)
    (let ((default-process-coding-system '(gbk . gbk)))
      (let* ((output-lines (process-lines "dianswitch.exe"))
             (selected-line (ivy-read "Select a line: " output-lines)))
        (when selected-line
          (shell-command (concat "dianswitch.exe \"" selected-line "\"")) 
          ))))
