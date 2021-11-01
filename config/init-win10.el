;;; windows 平台专属

(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "start" (file))
                              ("\\.doc\\'" "start" (file))
                              ("\\.docx\\'" "start" (file))))

;;; {{ Keys
(setq w32-lwindow-modifier 'super)
(setq w32-pass-lwindow-to-system nil)
(setq w32-apps-modifier 'super)

;;; I do not why, but `w32-register-hot-key' must after `w32-lwindow-modifier' setting
(dolist (keys '([s-0] [s-1] [s-2] [s-3] [s-o]
		[s-O] [s-s] [s-u] [s-y] [s-Y]
		[s-m] [s-h] [s-e] [s-return]
                [M-escape]))
  (w32-register-hot-key keys))

(with-eval-after-load 'python
  ;; simple complie for python
  (define-key python-mode-map (kbd "<f5>")
    (lambda () (interactive)
      (start-process "python" "*fei-python*" "cmd" "/c" "start" "cmd" "/k" "python" (buffer-file-name)))))

(global-set-key (kbd "s-m") 'toggle-frame-maximized)
(global-set-key (kbd "s-h") 'suspend-frame)
(global-set-key (kbd "s-n") 'suspend-frame)
(global-set-key (kbd "s-e") 'file-manager-here)
(global-set-key (kbd "<f12>") (li (start-process "gvim" nil "gvim" (buffer-file-name))))
(global-set-key (kbd "M-s M-s") 'fei-google-search)

;;; }}

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

(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    ;; (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))
(arrange-frame 84 30 170 20)


(provide 'init-win10)
