;;; windows 平台专属
(require 'fei-funcs)

(setq default-input-method "pyim")

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

;; (tool-bar-add-item "show" 'file-manager-here 'file-manager-here :help "file-manager-here")

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
;; (arrange-frame 84 30 170 20)

(setq browse-url-handlers '(("." . browse-url-default-browser)))

(when (version<= "28.0" emacs-version)

  (add-hook 'minibuffer-setup-hook 'fei-win10-deactivate-ime)
  (add-hook 'minibuffer-exit-hook 'fei-restore-ime-status)

  (defvar fei--ime-status-previous nil)

  (defun fei-win10-deactivate-ime ()
    (setq fei--ime-status-previous (w32-get-ime-open-status))
    (w32-set-ime-open-status nil))

  (defun fei-restore-ime-status ()
    (w32-set-ime-open-status fei--ime-status-previous))
  )

;; ==== windows emoji 字体设置 ====
;; @REF: https://ianyepan.github.io/posts/emacs-emojis/
(when (member "Segoe UI Emoji" (font-family-list))
  (set-fontset-font
   t 'symbol (font-spec :family "Segoe UI Emoji") nil 'prepend))

(add-hook 'server-after-make-frame-hook 'fei-win10-setup-emoji)
(defun fei-win10-setup-emoji ()
  (when (member "Segoe UI Emoji" (font-family-list))
    (set-fontset-font
     t 'emoji (font-spec :family "Segoe UI Emoji") nil 'prepend))
  )

(provide 'init-win10)
