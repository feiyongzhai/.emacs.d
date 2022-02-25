(custom-set-faces
 '(default ((t (:family "Fantasque Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 143 :width normal))))
 ;; '(default ((t (:family "Fantasque Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 181 :width normal))))
 ;; '(default ((t (:family "等距更纱黑体 SC" :foundry "????" :slant normal :weight normal :height 158 :width normal))))
 )
(set-fontset-font t 'symbol "Symbola" nil 'append)

(when *is-linux*
  ;; (set-fontset-font "fontset-default" 'unicode'("文泉驿等宽微米黑"))
  (add-hook 'before-make-frame-hook
	    ;; 用 `before-make-frame-hook' 就可以让 emacsclient 和
	    ;; emacs 的 frame 的字体都能够按照预期设置
	    (lambda ()
	      (set-fontset-font "fontset-default" 'unicode'("文泉驿等宽微米黑")))))


(provide 'init-font)
