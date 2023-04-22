(require 'fei-funcs)

(global-subword-mode)

(setq shift-select-mode t)		;回归默认行为
(setq mouse-yank-at-point t)		;粘贴于光标处,而不是鼠标指针处
(setq next-screen-context-lines 2)
(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 0 ;此变量会影响到 C-l(recenter-top-bottom) 的行为，用的默认值
      )
;; @REF: https://emacs-china.org/t/word/19878
;; (setq sentence-end "\\([。！？:：]\\)[ \t\n]*")
(setq sentence-end "\\([.?!…‽][]\"'”’)}»›]*\\($\\|[  ]$\\|\t\\|[  ][  ]\\)\\|[。．？！:：]+\\)[  \t\n]*")

;; (setq recenter-positions '(top middle bottom)) ;备忘

(defun fei-scroll-up-line ()
  (interactive)
  (if (or (eq last-command 'fei-scroll-down-line)
	  (eq last-command 'fei-scroll-up-line))
      (scroll-up-line)
    (scroll-up-line)
    (fei-pulse-current-line)))

(defun fei-scroll-down-line ()
  (interactive)
  (if (or (eq last-command 'fei-scroll-down-line)
	  (eq last-command 'fei-scroll-up-line))
      (scroll-down-line)
    (scroll-down-line)
    (fei-pulse-current-line)))

(autoload 'duplicate-line-below-comment "duplicate-line" nil t)
(autoload 'duplicate-line-or-region-below "duplicate-line" nil t)
(defun fei-duplicate-line-or-region (&optional arg)
  (interactive "P")
  (if arg
      (call-interactively 'duplicate-line-below-comment)
    (call-interactively 'duplicate-line-or-region-below)))

(defun fei-scroll-up-line-other-window ()
  (interactive)
  (with-selected-window (next-window)
    (scroll-up-line)))

(defun fei-scroll-down-line-other-window ()
  (interactive)
  (with-selected-window (next-window)
    (scroll-down-line)))

(defun narrow-to-region-indirect (start end)
  "Restrict editing in this buffer to the current region, indirectly."
  (interactive "r")
  (deactivate-mark)
  (let ((buf (clone-indirect-buffer nil 'display)))
    (with-current-buffer buf
      (narrow-to-region start end))))

(defun yank-and-indent ()
  (interactive)
  (yank)
  (call-interactively 'indent-region))

(defun fei-buffer-indent ()
  "Indent all buffer. Copied from `web-mode-buffer-indent'"
  (interactive)
  (let ((debug t) (ts (current-time)) (sub nil))
    (indent-region (point-min) (point-max))
    (when debug
      (setq sub (time-subtract (current-time) ts))
      (message "缩进 buffer 花费时间 %Ss %9Sµs" (nth 1 sub) (nth 2 sub)))
    (delete-trailing-whitespace)))

(defun my/select-current-line-and-forward-line (arg)
  "Select the current line and move the cursor by ARG lines IF
no region is selected.

If a region is already selected when calling this command, only move
the cursor by ARG lines."
  (interactive "p")
  (when (not (use-region-p))
    (forward-line 0)
    (set-mark-command nil))
  (forward-line arg))

(provide 'init-edit)
