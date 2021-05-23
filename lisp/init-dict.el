(add-to-list 'fei-package-ensure-installed 'youdao-dictionary)

(global-set-key (kbd "C-c y y") #'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "C-c y i") #'youdao-dictionary-search-from-input)
(defun fei-youdao-dictionary-search-from-input (_arg)
  (interactive "P")
  (message "施工中")
  (when _arg
    ;; TODO: 调用`youdao-dictionary-search-from-input'后自动启用minibuffer的输入法
    (message "施工中")
    ))

(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input))

(provide 'init-dict)
