;;; init-pyim.el

(require 'fei-funcs)
(require 'pyim)

;; Pyim

;; (pyim-isearch-mode)

;; 这行配置存在性能问题：
;; 1. 当在 minibuffer 中粘贴很长的一个链接的时候，会出现卡死的情况
;; 2. windows平台，使用下面的代码会出现很多我不想要的搜索结果（counsel-rg的时候），故不用【关键原因】

;; (require 'pyim-cregexp-utils)
;; (with-eval-after-load 'ivy
;;   (setq ivy-re-builders-alist
;; 	'((t . pyim-cregexp-ivy))))

(setq pyim-indicator-modeline-string '("中 " "英 "))

(setq pyim-indicator-list
      ;; 不用光标颜色来指示输入法状态，因为在切换主题的时候，光标颜色的恢复逻辑有异常。
      ;; 具体点就是，会恢复上一个主题的光标颜色，但是我已经切换主题了，不应该把颜色切换到上一个主题颜色上
      '(pyim-indicator-with-modeline))

(with-eval-after-load 'pyim
  (require 'pyim-basedict)
  (pyim-basedict-enable)
  (setq pyim-default-scheme 'quanpin)
  (setq pyim-assistant-scheme 'xiaohe-shuangpin)
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-page-style 'two-line)
  ;; 使用云输入法会有不习惯：候选栏的更新比较慢，就是有点不跟手，输入体验还不如没有云拼音
  ;; (setq pyim-cloudim 'baidu)
  )
(setq-default pyim-english-input-switch-functions
	      '(pyim-probe-auto-english
		pyim-probe-isearch-mode
		pyim-probe-program-mode
		pyim-probe-org-structure-template))

(defvar fei-pyim-force-enable nil)
(defun fei-pyim-force-enable () fei-pyim-force-enable)
(with-eval-after-load 'pyim
  (add-to-list 'pyim-force-input-chinese-functions 'fei-pyim-force-enable))

(defun fei-activate-pyim ()
  "暂时无法实现像 rime 中那个样子的强制启用一次输入中文的功能，只能做成这个样子，不过也挺好用的"
  (interactive)
  ;; (pyim-convert-string-at-point)
  (if fei-pyim-force-enable
      (setq fei-pyim-force-enable nil)
    (setq fei-pyim-force-enable t))
  (activate-input-method 'pyim))


(provide 'init-pyim)
;;; init-pyim.el ends here.
