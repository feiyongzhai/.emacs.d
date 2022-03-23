;;; init-shell.el  --- configs for eshell/shell/terminal

(require 'init-func)
(require 'fei-funcs)
(require 'eshell-hacks)

(setq eshell-banner-message "")
(setq eshell-list-files-after-cd t)
(setq eshell-history-size 500)
(setq eshell-cmpl-ignore-case t)
;; 这个命令总是会引入一些问题：暂时把这个关了，避免自己在日常使用中不
;; 小心启用这个里面的功能
(setq eshell-visual-commands nil)

;;; Make eshell don't always scroll to bottom
;; @REF: https://emacs.stackexchange.com/questions/28819/eshell-goes-to-the-bottom-of-the-page-after-executing-a-command
;; There are two solutions
(setq eshell-scroll-show-maximum-output nil)
;; (add-hook 'eshell-mode-hook
;;           (defun chunyang-eshell-mode-setup ()
;;             (remove-hook 'eshell-output-filter-functions
;;                          'eshell-postoutput-scroll-to-bottom)))

;;; Keys

(global-set-key (kbd "<s-return>") 'fei-terminal-here)
(global-set-key (kbd "M-s j") 'eshell)
(global-set-key (kbd "M-s M-j") 'fei-eshell-cd-here)
(global-set-key (kbd "M-s k") 'fei-ansi-term)
(global-set-key (kbd "M-s M-k") 'fei-term-cd-here)

(add-hook 'eshell-mode-hook '+fei-eshell-mode-hook)
(defun +fei-eshell-mode-hook ()
  (define-key eshell-mode-map (kbd "C-l") (li (recenter 0)))
  (define-key eshell-mode-map (kbd "C-j") 'eshell-send-input)
  (define-key eshell-mode-map (kbd "C-d") '+eshell/quit-or-delete-char)
  (define-key eshell-hist-mode-map (kbd "M-r") 'fei-my/ivy-eshell-history)
  (define-key eshell-hist-mode-map (kbd "M-s") nil)
  ;; `substring' style is very useful for eshell completion
  (setq-local completion-styles '(basic partial-completion substring emacs22))
  (toggle-truncate-lines 0))

;; Shell
(with-eval-after-load 'shell
  ;; 实际使用中发现下面这个设置会和 matlab-shell 的补全冲突
  ;; 问题描述：有了下面的配置之后，matlab-shell 中按两次 tab 键无法显示 company 的界面，并会输出一些错误信息
  ;; update: 2021-07-22T23:54:23+08:00
  ;; 问题没有完全解决，当我用emacsclient的方式启动的时候，还会存在高亮不消失的情况。
  ;; (setq comint-prompt-read-only t)
  (remove-hook 'comint-output-filter-functions
	       'comint-postoutput-scroll-to-bottom)
  (require 'bash-completion)
  (bash-completion-setup)
  )

(global-set-key (kbd "C-z") 'eshell)

(with-eval-after-load 'term
  (define-key term-raw-map (kbd "M-s") 'nil))

(provide 'init-shell)
;;; init-shell.el ends here.
