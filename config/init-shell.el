;;; init-shell.el  --- configs for eshell/shell/terminal

(require 'fei-funcs)

;;; Keys

(fei-define-key-with-map global-map
  `(
    ("<s-return>" . fei-terminal-here)
    ("<f12>" . fei-ansi-term)
    ("<f8>" . next-eshell-buffer)
    ("<C-f8>" . fei-eshell-cd-here)
    ("<s-f8>" . ,(li (split-window-below) (other-window 1) (call-interactively 'fei-eshell-cd-here)))
    ("<M-f8>" . fei-ansi-term)
    ))

(global-set-key (kbd "s-\\") 'fei-ansi-term)
(global-set-key (kbd "M-s J") 'fei-ansi-term)
(global-set-key (kbd "C-x M-j") 'fei-eshell-cd-here)
(global-set-key (kbd "C-c M-j") 'fei-term-cd-here)

(define-key dired-mode-map (kbd "'") 'fei-eshell-cd-here)
(define-key dired-mode-map (kbd "`") 'dired-open-term)

(add-hook 'eshell-mode-hook
	  (lambda ()
	    (define-key eshell-mode-map (kbd "C-l")
	      (lambda () (interactive) (recenter 0)))))
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

;;; Eshell commands and alias

(defalias 'open 'find-file-other-window)
(defalias 'eshell/e 'eshell/edit)

(with-eval-after-load 'eshell
  (require 'eshell-up)
  (defalias 'eshell/u 'eshell-up)
  (defalias 'eshell/up 'eshell-up))

(defalias 'eshell/s 'eshell/eaf-search)

(provide 'init-shell)
;;; init-shell.el ends here.
