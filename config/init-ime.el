;;; init-ime.el  --- 中文输入法相关配置

;;; Require

(require 'init-var)

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

;;; Vars

(with-eval-after-load 'rime
  (face-spec-set 'rime-default-face
		 '((((class color) (background dark))
		    (:background "#333333" :foreground "#dcdccc" :slant italic))
		   (((class color) (background light))
		    (:background "#dcdccc" :foreground "#333333" :slant italic))))

  ;; 目前还不知道是什么原因，下面这个这行设置不能生效，把这行保留是为
  ;; 了下次想追究这个原因的方便回忆

  ;; (set-face-attribute 'rime-default-face nil :slant 'italic)
  )

(cond (*is-linux*
       (setq rime-user-data-dir "~/.emacs.d/rime/xhup"))
      (t (message "使用默认值：~/.emacs.d/rime/")))

(setq rime-posframe-properties
      (list :internal-border-width 4))

(setq default-input-method "rime"
      rime-show-candidate 'posframe
      rime-show-preedit t
      rime-posframe-fixed-position t)

(setq rime-disable-predicates
      '(rime-predicate-prog-in-code-p))

(setq rime-translate-keybindings
      '("C-f" "C-b" "C-n" "C-p" "C-g" "C-h" "C-e" "C-v" "M-v"
	"<left>" "<right>" "<up>" "<down>" "<prior>" "<next>" "<delete>"))


;;; {{ rime mode line indicator

(setq rime-title " ")

(with-eval-after-load 'rime
  ;; 下面是默认的设置，我不想替代默认的信息，只是想添加一个这个指示信
  ;; 息，所以就有了下面的 `fei-rime-lighter'，

  ;; (setq mode-line-mule-info '((:eval (rime-lighter))))

  (add-to-list 'mode-line-mule-info '((:eval (fei-rime-lighter))))
  (setq-default mode-line-mule-info mode-line-mule-info)

  (defun fei-rime-lighter ()
    "rewrite `rime-lighter' "
    (if (and (equal current-input-method "rime")
             (bound-and-true-p rime-mode))
	(if (and (rime--should-enable-p)
		 (not (rime--should-inline-ascii-p)))
            (propertize
             (char-to-string 12563)
             'face
             'rime-indicator-face)
          (propertize
	   (char-to-string 12563)
           'face
           'rime-indicator-dim-face))
      ""))
  )

;;; }}


;;; {{ a switch between xhup & flypy

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

;;; }}

(provide 'init-ime)
;;; init-ime.el ends here.
