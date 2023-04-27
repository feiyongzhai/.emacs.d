;; init-alias.el -- 与其纠结怎么定义一个合理的 keybinding，不如用 alias

;; Commentary:

;; Finally, I find use a meaningful alias is more smoothly to use a
;; keybinding. smoothly is not directly related to quickly. but I
;; think it is very critical about be a longtime quickly working
;; state.

(require 'fei-funcs)

(setq echo-keystrokes 0.1)

(defalias 'fi 'fei-rime-force-enable)
(defalias 'ov 'open-current-file-with-vscode)
(defalias 'code 'open-current-file-with-vscode)
(defalias 'oe 'open-current-file-with-emacsq)
(defalias 'of 'file-manager-here)
(defalias 'ui 'fei-toggle-ui)
(defalias 'cmp 'compile)


;; Designed for `eshell'
(with-eval-after-load 'eshell
  (require 'eshell-up)
  (defalias 'eshell/u 'eshell-up))

(defun eshell/jo () (eshell/cd "~/Nutstore Files/org"))
(defun eshell/je () (eshell/cd "~/.emacs.d"))
(defun eshell/repo () (eshell/cd "~/Repos"))

(defalias 'eshell/vim 'vim)
(defalias 'eshell/emacs 'emacs)

(defalias 'eshell/of 'browse-url-default-browser)
(defalias 'eshell/e 'eshell/edit)
(defalias 'eshell/z 'samray/eshell-zoxide-z)

(defalias 'eshell/S 'searchbox-refresh-buffer)

(defalias 'eshell/y 'youdao-dictionary-search)
(defalias 'eshell/j 'fei-counsel-recentf-pinyin)
(defalias 'eshell/J 'fei/counsel-recentf-dir)

(defalias 'eshell/eh 'find-file-other-frame)
(defalias 'eshell/k 'fei-org-capture-TODO)
(defalias 'eshell/c 'fei-org-capture-TODO)
(defalias 'eshell/note 'fei-org-capture-note)
(defalias 'eshell/n 'fei-org-capture-note)
(defalias 'eshell/p 'fei-org-capture-private)
(defalias 'eshell/todo 'fei-org-capture-TODO)
(defalias 'eshell/ks 'fei-org-capture-SAR)
(defalias 'eshell/kw 'fei-org-capture-WANT)
(defalias 'eshell/kd 'fei-org-capture-diary)

(defun eshell/a () (org-agenda nil "a"))

(defun eshell/desktop () (eshell/cd fei-desktop-dir))
(defun eshell/de () (eshell/cd fei-desktop-dir))


;; 不推荐用 `eshll/alias' 设置 alias，因为会在每次启动的时候重置 eshell/alias 文件

;; (with-eval-after-load 'em-alias
;;   (eshell/alias "tig" "magit")
;;   (eshell/alias "of" "browse-url-default-browser $1")
;;   )

(provide 'init-alias)
