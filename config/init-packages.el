;; init-packages.el == configs for site packages

(require 'fei-funcs)

;;; 百度网盘
(add-to-list 'load-path "~/.emacs.d/extensions/baidupan")
(require 'dupan)

;;; Calendar
(require 'cal-china-x)
(setq calendar-week-start-day 1)

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

;;; Neotree
(setq neo-theme 'ascii)
(setq neo-window-position 'right)
(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "j") 'neotree-next-line)
  (define-key neotree-mode-map (kbd "k") 'neotree-previous-line)
  (define-key neotree-mode-map (kbd "J") 'fei-neotree-move-to-left)
  (define-key neotree-mode-map (kbd "K") 'fei-neotree-move-to-right)
  (define-key neotree-mode-map (kbd "l") 'neotree-enter)
  (define-key neotree-mode-map (kbd "f") 'neotree-enter)
  (define-key neotree-mode-map (kbd "<mouse-3>") 'neotree-mouse-open-external)
  )

(defun fei-neotree-move-to-left ()
  (interactive)
  (neotree-hide)
  (setq neo-window-position 'left)
  (neotree-show))

(defun fei-neotree-move-to-right ()
  (interactive)
  (neotree-hide)
  (setq neo-window-position 'right)
  (neotree-show))

(defun neotree-mouse-open-external (event)
  (interactive "e")
  (mouse-set-point event)
  (neotree-open-file-in-system-application))

;;; alarm-clock
(global-set-key (kbd "M-s a s") 'alarm-clock-set)
(global-set-key (kbd "M-s a l") 'alarm-clock-list-view)

;;; separedit
(define-key prog-mode-map        (kbd "C-c '") #'separedit)
(define-key minibuffer-local-map (kbd "C-c '") #'separedit)

;;; Imenu-list
(setq imenu-list-focus-after-activation t)

;;; Trashed
(global-set-key (kbd "C-c t") 'trashed)

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

(global-set-key (kbd "M-s [") 'point-to-register)
(global-set-key (kbd "M-s ]") 'jump-to-register)

(global-set-key (kbd "C-c J") (li (fei-counsel-fd-file-jump nil "~/Desktop/文献仓库")))

;;; youdao-dictionary
(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input)
  (define-key youdao-dictionary-mode-map (kbd "b") 'fei-quword-at-point))
(global-set-key (kbd "<menu>") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "C-h y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-c y") 'fei-youdao-at-point)

(defun fei-quword-at-point ()
  (interactive)
  (engine/search-quword (thing-at-point 'word)))

;;; Helpful
;; (global-set-key (kbd "C-h o") 'helpful-symbol)
;; (global-set-key (kbd "C-h O") 'describe-symbol)
;; (global-set-key (kbd "C-h k") 'helpful-key)

;; helm-org-rifle 搜索的 org 文件需要打开。不过 org-agenda 会默认打开
;; 一些 org 文件，所以配合起来使用也能接受
(global-set-key (kbd "C-c h o") 'helm-org-rifle)
(global-set-key (kbd "C-c h b") 'helm-chrome-bookmarks)
(with-eval-after-load 'helm
  (global-set-key (kbd "C-c h o") 'helm-org-rifle)
  (global-set-key (kbd "C-c h b") 'helm-chrome-bookmarks))

(setq helm-command-prefix-key (kbd "C-c h"))

;;; Rg
(global-set-key (kbd "M-s r") 'rg-dwim-current-file)
(global-set-key (kbd "M-s R") 'rg-dwim-current-dir)
(global-set-key (kbd "M-s M-r") 'rg-dwim-project-dir)
(define-key isearch-mode-map (kbd "M-s r") 'rg-isearch-project)

;;; grep-dired
(add-to-list 'load-path "~/.emacs.d/extensions/grep-dired")
(autoload 'grep-dired "grep-dired" nil t) ;emacs 自带了一个相似的命令 `find-name-dired'

;;; jetbrains == Interoperable between emacs with jetbrains IDE
(autoload 'jetbrains-open-buffer-file "jetbrains" nil t)
(autoload 'jetbrains-create-dir-local-file "jetbrains" nil t)
(global-set-key (kbd "C-9") 'jetbrains-open-buffer-file)
(global-set-key (kbd "C-M-9") 'jetbrains-create-dir-local-file)

;;; flutter
(add-hook 'dart-mode-hook 'electric-pair-local-mode)
(add-hook 'dart-mode-hook 'subword-mode)
(with-eval-after-load 'dart-mode
  (define-key dart-mode-map (kbd "C-M-x") #'flutter-run-or-hot-reload))
(setq flutter-sdk-path "~/.local/opt/flutter/")
(setq lsp-dart-flutter-sdk-dir "~/.local/opt/flutter/")

;;; 自动调整 gc
(gcmh-mode)

;;; Funcs

;; youdao-dictionary
(defun fei-youdao-at-point ()
  (interactive)
  (if (display-graphic-p)
      (call-interactively 'youdao-dictionary-search-at-point-tooltip)
    (call-interactively 'youdao-dictionary-search-at-point+)))


(provide 'init-packages)

;; Local Variables:
;; outline-regexp: ";;;+"
;; End:
