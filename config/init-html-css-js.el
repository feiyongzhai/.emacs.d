;; 使用 web-mode 来编辑 html，比默认的 html-mode 直观好用一点
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-hook 'web-mode-hook 'emmet-mode)

;; 用 js2-mode 来代替 js-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(with-eval-after-load 'emmet-mode
  (define-key emmet-mode-keymap (kbd "C-M-j") 'emmet-expand-yas))

(add-hook 'js-mode-hook 'electric-pair-local-mode)

(provide 'init-html-css-js)
