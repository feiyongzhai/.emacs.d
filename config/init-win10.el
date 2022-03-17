;;; windows 平台专属
(require 'fei-funcs)

(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "start" (file))
                              ("\\.doc\\'" "start" (file))
                              ("\\.docx\\'" "start" (file))))

(setq w32-lwindow-modifier 'super)
(setq w32-pass-lwindow-to-system nil)
(setq w32-apps-modifier 'super)

;;; I do not why, but `w32-register-hot-key' must after `w32-lwindow-modifier' setting
(dolist (keys '([s-0] [s-1] [s-2] [s-3]
		[s-s] [s-u] [s-e]
		[s-return] [M-escape]))
  (w32-register-hot-key keys))

(with-eval-after-load 'python
  ;; simple complie for python
  (define-key python-mode-map (kbd "<f5>") 'fei-python-run)

  (defun fei-python-run ()
    (interactive)
    (save-buffer (current-buffer))
    (start-process "python"
                   "*fei-python*"
                   "cmd" "/c" "start" "cmd" "/k" "python" (buffer-file-name))))

(global-set-key (kbd "s-e") 'file-manager-here)
(global-set-key (kbd "M-s s") 'fei-search)
(global-set-key (kbd "<f12>") 'open-current-file-with-vscode)

(tool-bar-add-item "show" 'file-manager-here 'file-manager-here :help "file-manager-here")

;;; @DOWNLOAD: https://www.voidtools.com/zh-cn/downloads/
(setq locate-command "es.exe")

(defun wt()
  "Open an external Windows cmd in the current directory"
  (interactive)
  (call-process-shell-command "start wt"))

(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    ;; (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))
(arrange-frame 84 30 170 20)

(setq browse-url-handlers '(("." . browse-url-default-browser)))

(provide 'init-win10)
