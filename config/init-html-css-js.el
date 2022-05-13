(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(with-eval-after-load 'emmet-mode
  (define-key emmet-mode-keymap (kbd "C-M-j") 'emmet-expand-yas))

(add-hook 'js-mode-hook 'electric-pair-local-mode)

(provide 'init-html-css-js)
