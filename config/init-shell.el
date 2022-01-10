;;; init-shell.el  --- configs for eshell/shell/terminal

(require 'init-func)
(require 'fei-funcs)

(setq eshell-history-size 500)
(setq eshell-cmpl-ignore-case t)
;; 这个命令总是会引入一些问题：暂时把这个关了，避免自己在日常使用中不
;; 小心启用这个里面的功能
(setq eshell-visual-commands nil)

;;; Keys

(fei-define-key-with-map global-map
  `(
    ("<s-return>" . fei-terminal-here)
    ("<f12>" . open-current-file-with-emacsv)
    ("<f8>" . next-eshell-buffer)
    ("<s-f8>" . ,(li (split-window-below) (other-window 1) (call-interactively 'fei-eshell-cd-here)))
    ("M-s M-j" . fei-eshell-cd-here)
    ("M-s j"  . eshell)
    ))

(global-set-key (kbd "s-\\") 'fei-ansi-term)
(global-set-key (kbd "M-s J") 'fei-ansi-term)
(global-set-key (kbd "C-x M-j") 'fei-eshell-cd-here)
(global-set-key (kbd "C-c M-j") 'fei-term-cd-here)

(add-hook 'eshell-mode-hook
	  (lambda ()
	    (define-key eshell-mode-map (kbd "C-l") (li (recenter 0)))
	    (define-key eshell-mode-map (kbd "C-j") 'eshell-send-input)
	    (define-key eshell-mode-map (kbd "M-r") 'fei-my/ivy-eshell-history)
	    (define-key eshell-mode-map (kbd "C-d") '+eshell/quit-or-delete-char)
	    (define-key eshell-mode-map (kbd "M-s") nil)))
	  
;;; Make eshell don't always scroll to bottom
;; @ref https://emacs.stackexchange.com/questions/28819/eshell-goes-to-the-bottom-of-the-page-after-executing-a-command
;; There are two solution
;; (setq eshell-scroll-show-maximum-output nil)
(add-hook 'eshell-mode-hook
          (defun chunyang-eshell-mode-setup ()
            (remove-hook 'eshell-output-filter-functions
                         'eshell-postoutput-scroll-to-bottom)))
(add-hook 'eshell-mode-hook (lambda ()
			      (toggle-truncate-lines 0)))

(with-eval-after-load 'shell
  ;; 实际使用中发现下面这个设置会和 matlab-shell 的补全冲突
  ;; 问题描述：有了下面的配置之后，matlab-shell 中按两次 tab 键无法显示 company 的界面，并会输出一些错误信息
  ;; update: 2021-07-22T23:54:23+08:00
  ;; 问题没有完全解决，当我用emacsclient的方式启动的时候，还会存在高亮不消失的情况。
  ;; (setq comint-prompt-read-only t)
  (remove-hook 'comint-output-filter-functions
	       'comint-postoutput-scroll-to-bottom))

(provide 'init-shell)
;;; init-shell.el ends here.
