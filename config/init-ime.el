;;; init-ime.el  --- 中文输入法相关配置

;;; Code:

;;; Pyim

(with-eval-after-load 'pyim
  (require 'pyim-basedict)
  (pyim-basedict-enable)
  (setq pyim-default-scheme 'xiaohe-shuangpin)
  (setq pyim-page-tooltip 'posframe)
  ;; (pyim-isearch-mode 1)
  )
;; (setq default-input-method "pyim")
;; (setq-default pyim-english-input-switch-functions
;; 	      '(pyim-probe-dynamic-english
;; 		pyim-probe-isearch-mode
;; 		pyim-probe-program-mode
;; 		pyim-probe-org-structure-template))
;; (setq-default pyim-punctuation-half-width-functions
;; 	      '(pyim-probe-punctuation-line-beginning
;; 		pyim-probe-punctuation-after-punctuation))
;; (global-set-key (kbd "M-j") 'pyim-convert-code-at-point)
;; (global-set-key (kbd "C-;") 'pyim-delete-word-from-personal-buffer)
;; (setq pyim-page-length 5)
;; (setq pyim-page-tooltip 'posframe)

;;; Rime

;; windows可以使用了，参考链接：https://github.com/DogLooksGood/emacs-rime/issues/64

(cond (*is-linux*
       (setq rime-user-data-dir "~/.config/fcitx/rime"))
      (*is-windows*
       (setq rime-user-data-dir "~/.emacs.d/rime"))
      (t (message "无法设置RIME的数据文件夹，请自行设置！")))

(setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            ;; :font "WenQuanYi Micro Hei Mono-14"
            :internal-border-width 10))

(setq default-input-method "rime"
      rime-show-candidate 'minibuffer)

(setq rime-disable-predicates
      '(rime-predicate-after-alphabet-char-p
	;; rime-predicate-evil-mode-p
        rime-predicate-prog-in-code-p))

(provide 'init-ime)
;;; init-ime.el ends here.
