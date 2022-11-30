;;; windows 平台专属
(require 'fei-funcs)

(w32-set-ime-open-status nil)
(defvar first-make-frame-flag nil
  "标志信号，保证只在第一次进行修改")

(setq recentf-max-saved-items 200)
(global-set-key (kbd "C-c j") 'counsel-recentf)

(setq default-input-method "pyim")

(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "start" (file))
                              ("\\.doc\\'" "start" (file))
                              ("\\.docx\\'" "start" (file))))

(setq w32-lwindow-modifier 'super)
(setq w32-pass-lwindow-to-system t)
(setq w32-apps-modifier 'super)

;; 控制启动窗口的大小
(add-hook 'server-after-make-frame-hook
	  (lambda ()
	    ;; @REF: http://kimi.im/2019-02-09-emacs-frame-dimention
	    (unless first-make-frame-flag
	      (w32-set-ime-open-status nil)
	      (setq first-make-frame-flag 1))

	    ;; (set-frame-height nil (/ (* 4 (x-display-pixel-height))
	    ;; 			     (* 5 (frame-char-height))))
	    ;; (set-frame-width nil (/ (* 4 (x-display-pixel-width))
	    ;; 			    (* 5 (frame-char-width))))
	    ))

;; ;;; I do not why, but `w32-register-hot-key' must after `w32-lwindow-modifier' setting
;; (dolist (keys '([s-0] [s-1] [s-2] [s-3]
;; 		[s-s] [s-u] [s-e]
;; 		[s-return] [M-escape]))
;;   (w32-register-hot-key keys))

(with-eval-after-load 'python
  ;; simple complie for python
  (define-key python-mode-map (kbd "<f5>") 'fei-python-run)
  (define-key python-mode-map (kbd "<C-f5>") (li (fei-python-run 1)))

  (defun fei-python-run (&optional flag)
    (interactive "P")
    (save-buffer (current-buffer))
    (if flag
	(start-process "python"
                   "*fei-python*"
                   "cmd" "/c" "start" "cmd" "/k" "python" "-i" (buffer-file-name))
      (start-process "python"
                   "*fei-python*"
                   "cmd" "/c" "start" "cmd" "/k" "python" (buffer-file-name))))
  )

(global-set-key (kbd "M-s s") 'fei-search)

;; (tool-bar-add-item "show" 'file-manager-here 'file-manager-here :help "file-manager-here")

;;; @DOWNLOAD: https://www.voidtools.com/zh-cn/downloads/
(setq locate-command "es.exe")

(setq browse-url-handlers '(("." . browse-url-default-browser)))

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

;;; Funcs
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

(global-set-key (kbd "M-J") (li (w32-set-ime-open-status nil)))

(provide 'init-win10)
