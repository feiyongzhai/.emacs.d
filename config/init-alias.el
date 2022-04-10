;; init-alias.el -- 与其纠结怎么定义一个合理的 keybinding，不如用 alias

(require 'fei-funcs)

;; Designed for `M-x', but it can also be used in `eshell'
(defalias 'tabn 'tab-new)
(defalias 'tabc 'tab-close)
(defalias 'frn 'make-frame)
(defalias 'frc 'delete-frame)



;; Designed for `eshell'

(with-eval-after-load 'eshell
  (require 'eshell-up)
  (defalias 'eshell/u 'eshell-up)
  (defalias 'eshell/up 'eshell-up)
  )

;; 不推荐用 `eshll/alias' 设置 alias，因为会在每次启动的时候重置 eshell/alias 文件

;; (with-eval-after-load 'em-alias
;;   (eshell/alias "tig" "magit")
;;   (eshell/alias "of" "browse-url-default-browser $1")
;;   )

(defalias 'eshell/of 'browse-url-default-browser)
(defalias 'open 'find-file-other-window)
(defalias 'eshell/e 'eshell/edit)
(defalias 'eshell/s 'eshell/eaf-search)
(defalias 'eshell/bash 'fei-ansi-term)
(defalias 'eshell/bashj 'fei-term-cd-here)

(defalias 'eshell/ks 'fei-org-capture-SAR)
(defalias 'eshell/kw 'fei-org-capture-WANT)
(defalias 'eshell/k 'fei-org-capture-note)
(defalias 'eshell/kd 'fei-org-capture-diary)
(defalias 'eshell/j 'samray/eshell-fasd-z)

(provide 'init-alias)
