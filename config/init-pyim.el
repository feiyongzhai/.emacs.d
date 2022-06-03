;;; init-pyim.el

(require 'fei-funcs)
(require 'pyim)

;; Pyim

;; (pyim-isearch-mode)

;; 这行配置存在性能问题：
;; 1. 当在 minibuffer 中粘贴很长的一个链接的时候，会出现卡死的情况
(require 'pyim-cregexp-utils)
(with-eval-after-load 'ivy
  (setq ivy-re-builders-alist
	'((t . pyim-cregexp-ivy))))

(setq default-input-method "pyim")

(define-key pyim-mode-map (kbd "C-h") 'pyim-delete-backward-char)
(define-key pyim-mode-map (kbd "M-h") 'pyim-quit-no-clear)
(define-key pyim-mode-map (kbd "<escape>") 'pyim-quit-clear)
(define-key pyim-mode-map (kbd "C-v") 'pyim-next-page)
(define-key pyim-mode-map (kbd "M-v") 'pyim-previous-page)

(with-eval-after-load 'pyim
  (require 'pyim-basedict)
  (pyim-basedict-enable)
  (setq pyim-default-scheme 'quanpin)
  (setq pyim-assistant-scheme 'xiaohe-shuangpin)
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-page-style 'vertical)
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
