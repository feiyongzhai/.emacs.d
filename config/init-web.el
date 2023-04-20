;; HTML/CSS/JS related configuration

;; 使用 web-mode 来编辑 html，比默认的 html-mode 直观好用一点
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-hook 'web-mode-hook 'emmet-mode)

;;; 缩进相关问题
;; @REF: https://stackoverflow.com/questions/36701024/how-can-i-indent-inline-javascript-in-web-mode
;; web-mode 下 <script> tag 的缩进问题
;; (setq web-mode-script-padding 4)
;; (setq js-indent-level 2)

;; 用 js2-mode 来代替 js-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

(add-hook 'js-mode-hook 'electric-pair-local-mode)


;; CSS
(add-hook 'css-mode-hook 'electric-pair-local-mode)

(provide 'init-web)
