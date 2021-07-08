;;; Funcs

(defun fei-youdao-dictionary-search-from-input (_arg)
  (interactive "P")
  (message "施工中")
  (when _arg
    ;; TODO: 调用`youdao-dictionary-search-from-input'后自动启用minibuffer的输入法
    (message "施工中")
    ))

(provide 'init-dict)
