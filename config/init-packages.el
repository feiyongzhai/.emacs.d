;; init-packages.el == configs for site packages

(require 'fei-funcs)

;;; 百度网盘
(add-to-list 'load-path "~/.emacs.d/extensions/baidupan")
(require 'dupan)

;;; Calendar
(require 'cal-china-x)
(setq calendar-week-start-day 1)

;;; Treemacs
(setq treemacs-position 'left)

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

;;; Imenu-list
(setq imenu-list-focus-after-activation t)

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

(defun symbol-overlay-find-at-point-project ()
  (interactive)
  (project-find-regexp (thing-at-point 'symbol)))

(defun fei-quword-at-point ()
  (interactive)
  (engine/search-quword (thing-at-point 'word)))


;;; Rg
(rg-define-toggle "--context 3" (kbd "C"))
(rg-define-toggle "-E gbk" (kbd "E"))
(rg-define-toggle "-A 5" (kbd "A"))
(rg-define-toggle "-F" (kbd "F"))	;-F / --fixed-strings flag do a literally search
(rg-define-search rg-project-all-files-no-ask
  :dir project :files "all")


;;; grep-dired
(add-to-list 'load-path "~/.emacs.d/extensions/grep-dired")
(autoload 'grep-dired "grep-dired" nil t) ;emacs 自带了一个相似的命令 `find-name-dired'

;;; jetbrains == Interoperable between emacs with jetbrains IDE
(autoload 'jetbrains-open-buffer-file "jetbrains" nil t)
(autoload 'jetbrains-create-dir-local-file "jetbrains" nil t)

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


;; Dashboard
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
;; known bugs: 在 side 新 tab 的时候会报错
;; (setq tab-bar-new-tab-choice 'dashboard-open)


(setq popper-reference-buffers '("\\*Messages\\*$"
				 "\\*eshell\\*"
				 "\\*vterm\\*"
				 ;; (compilation-mode . hide)
				 compilation-mode
				 ))

(popper-mode)
(popper-echo-mode)


(setq diff-hl-show-staged-changes nil)
(diff-hl-margin-mode)

(setq keyfreq-file "~/.emacs.d/.cache/emacs.keyfreq")


;; 有些时候，我们改变了一些配置导致了 `vertico-posframe' 或者 `ivy-posframe' 等 posframe 相关的
;; 包出现显示异常，可以通过 `posframe-delete-all' command 来尝试解决
(setq vertico-posframe-parameters
      '((left-fringe . 8)
        (right-fringe . 8)))

(provide 'init-packages)

;; Local Variables:
;; outline-regexp: ";;;+"
;; End:
