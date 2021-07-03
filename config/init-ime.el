;;; init-ime.el  --- 中文输入法相关配置

;;; Require

(require 'init-var)

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

;;; Keys

(with-eval-after-load 'rime
  (define-key rime-active-mode-map (kbd "M-o") 'rime--backspace))

;;; Vars

(cond (*is-linux*
       (setq rime-user-data-dir "~/.emacs.d/rime/xhup"))
      (t (message "使用默认值：~/.emacs.d/rime/")))

(setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            ;; :font "WenQuanYi Micro Hei Mono-14"
            :internal-border-width 10))

(setq default-input-method "rime"
      rime-show-candidate 'posframe)

(setq rime-disable-predicates
      '(rime-predicate-prog-in-code-p))

;;; Funcs

(defvar rime--flypy-p nil
  "输入法默认的状态是小鹤双拼+posframe的显示格式")

(defun fei-toggle-xhup-flypy ()
  (interactive)
  (if (fboundp 'rime-lib-select-schema)
      (if rime--flypy-p
	  (progn (rime-lib-select-schema "double_pinyin_flypy")
		 (setq rime-show-candidate 'posframe)
		 (setq rime--flypy-p nil))
	(rime-lib-select-schema "flypy")
	(setq rime-show-candidate 'minibuffer)
	(setq rime--flypy-p t))
    (message "Rime has not been required")))

(provide 'init-ime)
;;; init-ime.el ends here.
