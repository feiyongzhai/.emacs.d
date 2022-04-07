;; @REF: https://emacs.stackexchange.com/questions/62049/override-the-default-font-for-emoji-characters

;; Commentary:
;; 其实我不太知道 EMACS 中的 font 的工作机制，但是我下面的配置可以完成我预期的效果。
;; So, anyway, it works! 🐼🐼🐼

;; (setq-default line-spacing 3)		;控制每行之间的间距，和字体配合使用

(custom-set-faces
 ;; '(default ((t (:family "Hack" :foundry "simp" :slant normal :weight normal :height 143 :width normal))))
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight normal :height 143 :width normal))))
 ;; '(default ((t (:family "Fantasque Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 143 :width normal))))
 ;; '(default ((t (:family "Fantasque Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 181 :width normal))))
 ;; '(default ((t (:family "等距更纱黑体 SC" :foundry "????" :slant normal :weight normal :height 158 :width normal))))
 )

(when *is-linux*
  (set-fontset-font t 'symbol "Symbola" nil 'append)
  ;; (set-fontset-font "fontset-default" 'unicode'("文泉驿等宽微米黑"))
  ;; 用 `before-make-frame-hook' 就可以让 emacsclient 和 emacs 的 frame 的字体都能够按照预期设置
  (add-hook 'before-make-frame-hook '+fei-before-make-frame-hook)
  )

(defun +fei-before-make-frame-hook ()
  (set-fontset-font "fontset-default" 'unicode '("文泉驿等宽微米黑"))
  ;;XXX: 下面这行关于 emoji 的配置必须要放到上面这个设置下面才能正常显示 emoji
  (set-fontset-font t 'emoji "Noto Color Emoji" nil 'prepend) ;emacs-28 的特性，原生支持 emoji
  )

(provide 'init-font)
