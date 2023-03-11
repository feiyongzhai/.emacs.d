;; init-packages.el == configs for site packages

(require 'fei-funcs)

;;; 百度网盘
(add-to-list 'load-path "~/.emacs.d/extensions/baidupan")
(require 'dupan)

;;; Calendar
(require 'cal-china-x)
(setq calendar-week-start-day 1)

;; 快捷键讲究的就是一个随心所欲，狗屁章法
(global-set-key (kbd "M-s M-p") 'fei-switch-to-treemacs)

;;; Treemacs
(setq treemacs-position 'right)
(global-set-key (kbd "<f8>") 'fei-switch-to-treemacs)

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "J") 'fei-treemacs-move-to-left)
  (define-key treemacs-mode-map (kbd "K") 'fei-treemacs-move-to-right)
  (define-key treemacs-mode-map (kbd "v") 'fei-vc-dired-jump)
  (define-key treemacs-mode-map (kbd "G") 'magit)
  )

(defun fei-switch-to-treemacs ()
  (interactive)
  (catch 'done
    (dolist (w (window-list) (treemacs))
      (with-current-buffer (window-buffer w)
	(when (eq major-mode 'treemacs-mode)
	  (throw 'done (select-window w)))))))

(defun fei-treemacs-move-to-left ()
  (interactive)
  (treemacs-quit)
  (setq treemacs-position 'left)
  (treemacs))

(defun fei-treemacs-move-to-right ()
  (interactive)
  (treemacs-quit)
  (setq treemacs-position 'right)
  (treemacs))

;;; alarm-clock
(global-set-key (kbd "M-s a s") 'alarm-clock-set)
(global-set-key (kbd "M-s a l") 'alarm-clock-list-view)

;;; separedit
(define-key prog-mode-map        (kbd "C-c '") #'separedit)
(define-key minibuffer-local-map (kbd "C-c '") #'separedit)

;;; Imenu-list
(setq imenu-list-focus-after-activation t)

;;; Trashed
(global-set-key (kbd "C-c T") 'trashed)

;; 方便左手在键盘，右手在鼠标上的操作姿势
(global-set-key (kbd "M-s h a") 'fei-highlight-region)
(global-set-key (kbd "M-s M-1") 'highlight-symbol-at-point)
(global-set-key (kbd "M-s 1") 'highlight-symbol-at-point)
(global-set-key (kbd "M-s M-2") 'fei-unhighlight-symbol-at-point)
(global-set-key (kbd "M-s 2") 'fei-unhighlight-symbol-at-point)

(defun fei-unhighlight-symbol-at-point ()
  (interactive)
  (unhighlight-regexp
   (concat "\\_<"
	   (thing-at-point 'symbol)
	   "\\_>")))

(defun fei-highlight-region (b e)
  (interactive "r")
  (highlight-phrase (buffer-substring b e))
  (deactivate-mark))

(global-set-key (kbd "M-I") 'symbol-overlay-put)
(global-set-key (kbd "M-N") 'symbol-overlay-switch-forward)
(global-set-key (kbd "M-P") 'symbol-overlay-switch-backward)
(with-eval-after-load 'symbol-overlay
  (define-key symbol-overlay-map (kbd "o") 'fei-occur-at-point)
  (define-key symbol-overlay-map (kbd "l") 'recenter-top-bottom)
  (define-key symbol-overlay-map (kbd "O") 'symbol-overlay-find-at-point-project)
  (define-key symbol-overlay-map (kbd "M-r") 'rg-dwim-current-dir)
  )

(defun symbol-overlay-find-at-point-project ()
  (interactive)
  (project-find-regexp (thing-at-point 'symbol)))

;;; Registers
(setq register-preview-delay 0.1)

;;; youdao-dictionary
(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input)
  (define-key youdao-dictionary-mode-map (kbd "d") 'fei-quword-at-point))
(global-set-key (kbd "<menu>") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "C-h y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-M-y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-c y") 'fei-youdao-at-point)

(defun fei-quword-at-point ()
  (interactive)
  (engine/search-quword (thing-at-point 'word)))

;;; Helpful
;; (global-set-key (kbd "C-h o") 'helpful-symbol)
;; (global-set-key (kbd "C-h O") 'describe-symbol)
;; (global-set-key (kbd "C-h k") 'helpful-key)


;;; Rg
(rg-define-toggle "--context 3" (kbd "C"))
(rg-define-toggle "-A 5" (kbd "A"))
(rg-define-toggle "-F" (kbd "F"))	;-F / --fixed-strings flag do a literally search
(rg-define-search rg-project-all-files-no-ask
  :dir project :files "all")
(global-set-key (kbd "M-s r") 'rg-dwim-current-file)
(global-set-key (kbd "M-s R") 'rg-dwim-current-dir)
(global-set-key (kbd "M-s M-r") 'rg-project-all-files-no-ask)
(define-key isearch-mode-map (kbd "M-s r") 'rg-isearch-project)


;;; grep-dired
(add-to-list 'load-path "~/.emacs.d/extensions/grep-dired")
(autoload 'grep-dired "grep-dired" nil t) ;emacs 自带了一个相似的命令 `find-name-dired'

;;; jetbrains == Interoperable between emacs with jetbrains IDE
(autoload 'jetbrains-open-buffer-file "jetbrains" nil t)
(autoload 'jetbrains-create-dir-local-file "jetbrains" nil t)
(global-set-key (kbd "C-9") 'jetbrains-open-buffer-file)
(global-set-key (kbd "C-M-9") 'jetbrains-create-dir-local-file)

;;; 自动调整 gc
(gcmh-mode)

;;; interaction-log
(autoload 'interaction-log-mode "interaction-log" nil t)

;;; Funcs

;; youdao-dictionary
(defun fei-youdao-at-point ()
  (interactive)
  (if (display-graphic-p)
      (call-interactively 'youdao-dictionary-search-at-point-tooltip)
    (call-interactively 'youdao-dictionary-search-at-point+)))

;; dumb-jump
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;; zoxide
(add-to-list 'load-path "~/.emacs.d/extensions/zoxide/")
(require 'zoxide)
(global-zoxide-mode)


;; highlight-parentheses
;; 配合 `rainbow-delimiters-mode' 只需要显示一层括号颜色就够了
(setq highlight-parentheses-colors '("Red"))


(auto-dim-other-buffers-mode)

(provide 'init-packages)

;; Local Variables:
;; outline-regexp: ";;;+"
;; End:
