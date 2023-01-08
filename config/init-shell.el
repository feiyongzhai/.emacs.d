;;; init-shell.el  --- configs for shell/terminal

(global-set-key (kbd "M-s z") 'shell)

;; Shell
(with-eval-after-load 'shell
  ;; 实际使用中发现下面这个设置会和 matlab-shell 的补全冲突
  ;; 问题描述：有了下面的配置之后，matlab-shell 中按两次 tab 键无法显示 company 的界面，并会输出一些错误信息
  ;; update: 2021-07-22T23:54:23+08:00
  ;; 问题没有完全解决，当我用emacsclient的方式启动的时候，还会存在高亮不消失的情况。
  ;; (setq comint-prompt-read-only t)
  (remove-hook 'comint-output-filter-functions
	       'comint-postoutput-scroll-to-bottom)
  (when *is-linux*
    (require 'bash-completion)
    (bash-completion-setup))
  )

(with-eval-after-load 'term
  (define-key term-raw-map (kbd "M-s") 'nil))

(when *is-linux*
  ;; Vterm
  ;; @HOME: https://github.com/akermu/emacs-libvterm
  (global-set-key (kbd "C-z") 'vterm-toggle)
  (with-eval-after-load 'vterm
    (define-key vterm-mode-map (kbd "M-s") nil))
  )

(provide 'init-shell)
;;; init-shell.el ends here.
