;;; init-ime.el  --- 中文输入法相关配置

;;; Code:

;;; Add to list `user/package-ensure-installed'
(add-to-list 'user/package-ensure-installed 'pyim)
(add-to-list 'user/package-ensure-installed 'rime)

;;; configs for pyim

(with-eval-after-load 'pyim
  (require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
  (pyim-basedict-enable)	 ; 拼音词库，五笔用户 *不需要* 此行设置
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

;;; configs for rime

;; works on mint 
;; details:
;; emacs-version output:
;; GNU Emacs 27.1 (build 1, x86_64-pc-linux-gnu, GTK+ Version 3.24.20, cairo version 1.16.0) of 2020-09-20
;; linux version :
;; linux mint 20
;; windows 现在可以使用了，参考链接：https://github.com/DogLooksGood/emacs-rime/issues/64

(cond (*is-linux*
       (setq rime-user-data-dir "~/.config/fcitx/rime"))
      (*is-windows*
       (setq rime-user-data-dir "~/Rime/"))
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
