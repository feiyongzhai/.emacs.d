;; init-font.el

;; Commentary:

;; 其实我不太知道 EMACS 中的 font 的工作机制，但是我下面的配置可以完成我预期的效果。
;; So, anyway, it works! 🐼🐼🐼

;; SEE ALSO
;; @REF: https://emacs.stackexchange.com/questions/62049/override-the-default-font-for-emoji-characters

;; (setq-default line-spacing 3)		;控制每行之间的间距，和字体配合使用

(custom-set-faces
 ;; '(default ((t (:family "Hack" :foundry "simp" :slant normal :weight normal :height 143 :width normal))))
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight normal :height 110 :width normal))))
 ;; '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight regular :height 128 :width normal))))
 ;; '(default ((t (:family "Fantasque Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 143 :width normal))))
 ;; '(default ((t (:family "Fantasque Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 181 :width normal))))
 ;; '(default ((t (:family "等距更纱黑体 SC" :foundry "????" :slant normal :weight normal :height 158 :width normal))))
 )

(when *is-linux*
  (set-fontset-font t 'symbol "Symbola" nil 'append))

;; (set-fontset-font "fontset-default" 'unicode'("文泉驿等宽微米黑"))
;; @linux: 用 `before-make-frame-hook' 就可以让 emacsclient 和 emacs 的 frame 的字体都能够按照预期设置
(when *is-linux*
  (add-hook 'before-make-frame-hook 'fei-setup-linux-emoji-font))

(defun fei-setup-linux-emoji-font ()
  (set-fontset-font "fontset-default" 'unicode '("文泉驿等宽微米黑"))
  ;; !注意: 下面这行关于 emoji 的配置必须要放到上面这个设置下面才能正常显示 emoji
  (set-fontset-font t 'emoji "Noto Color Emoji" nil 'prepend) ;emacs-28 的特性，原生支持 emoji
  )

(with-eval-after-load 'org
  ;; 关于字体设置，可以多使用 `describe-char' 这个命令，有很多关于字体多信息
  ;; 用 `set-face-attribute' 更换主题的时候，字体会恢复到默认设置，用 `face-spec-set' 就不会
  ;; 关于 `face-spec-set' 的一个简要说明：http://xahlee.info/emacs/emacs/elisp_define_face.html
  (face-spec-set 'org-table '((t (:font "Sarasa Mono SC-12")))))

(face-spec-set 'markdown-table-face '((t (:font "Sarasa Mono SC-12"))))

(provide 'init-font)
