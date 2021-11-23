;;; init-ime.el  --- 中文输入法相关配置

;;; Keys

(fei-define-key-with-map global-map
  `(
    ("M-s-i" . ,(li (require 'rime) (toggle-input-method)))
    ("C-s-i" . fei-toggle-xhup-flypy)
    ))

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

;;; 输入方案相关链接
;; 小鹤双拼方案地址：https://github.com/cnfeat/Rime
;; 小鹤音形方案地址：http://flypy.ys168.com/ 这个链接中的“小鹤音形挂接第三方平台”文件夹 linux对应的是macos，win10对应的就是win10
;; 小鹤音形连写方案地址：https://github.com/brglng/rime-xhup

;;; 动态链接相关地址
;;;; Linux平台折腾这两个动态链接 librime 和 librime-emacs 

;;;; win10
;; librime 动态链接下载地址：https://github.com/DogLooksGood/emacs-rime/issues/64#issuecomment-605436317

;;; 一些说明，最近更新的rime需要重新编译 librime-emacs.dll，但我的
;;; windows编译环境没有配好，之前是用的上面连接编译好的。目前发现一个
;;; workaround，就是修改rime源码相应部分，不让它重新编译。所以就采用了
;;; submodule的方法

;;; 需要说明的一点就是windows平台暂时还没有自己编译成功过，所以下次出问题，这是一个可以尝试的途径
;;; 另外一个可以尝试的途径是使用pyim提供的librime作为替代品

(load-path-add "~/.emacs.d/extensions/emacs-rime/")

;;; Keys
(with-eval-after-load 'rime
  (define-key rime-active-mode-map (kbd "<tab>") 'rime-inline-ascii)
  (define-key rime-active-mode-map (kbd "C-i") 'rime-inline-ascii)
  (define-key rime-active-mode-map (kbd "M-i") 'rime-inline-ascii)
  (define-key rime-active-mode-map (kbd "M-h") 'rime--return)
  (define-key rime-mode-map (kbd "C-c M-j") 'rime-force-enable)
  )

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
       (setq rime-user-data-dir "~/.emacs.d/rime/linux/xhup"))
      (*is-windows*
       (setq rime-user-data-dir "~/.emacs.d/rime/win10"))
      (t (message "使用默认值：~/.emacs.d/rime/")))

(setq rime-posframe-properties
      (list :internal-border-width 4))

(setq default-input-method "rime"
      rime-show-candidate 'posframe
      rime-show-preedit t
      rime-posframe-fixed-position t)

(setq rime-disable-predicates
      '(rime-predicate-prog-in-code-p
        rime-predicate-space-after-cc-p
        rime-predicate-after-alphabet-char-p
	rime-predicate-tex-math-or-command-p))

(setq rime-translate-keybindings
      '("C-f" "C-b" "C-n" "C-p" "C-g" "C-h" "C-e" "C-v" "M-v"
	"<left>" "<right>" "<up>" "<down>" "<prior>" "<next>" "<delete>"))

;;; {{ rime mode line indicator

(setq rime-title " ")
(autoload 'rime-lighter "rime" nil nil nil)
(autoload 'rime-activate "rime" nil nil nil)
(register-input-method "rime" "euc-cn" 'rime-activate rime-title)

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
