;; init-alias.el -- 与其纠结怎么定义一个合理的 keybinding，不如用 alias

;; Commentary:

;; Finally, I find use a meaningful alias is more smoothly to use a
;; keybinding. smoothly is not directly related to quickly. but I
;; think it is very critical about be a longtime quickly working
;; state.

(require 'fei-funcs)

(setq echo-keystrokes 0.1)
(global-set-key (kbd "C-x M-m") mule-keymap)
(global-set-key (kbd "C-x C-m") 'execute-extended-command) ;was `mule-keymap'
(global-set-key (kbd "C-x m") 'execute-extended-command) ;was `compose-mail'
(global-set-key (kbd "C-x M") 'repeat-complex-command)

(global-set-key (kbd "C-x j c") (li (find-file "~/.config")))
(global-set-key (kbd "C-x j e") (li (find-file "~/.emacs.d")))
(global-set-key (kbd "C-x j f") (li (browse-url "https://feiyongzhai.github.io")))
(global-set-key (kbd "C-x j g") (li (find-file "~/Nutstore Files/")))
(global-set-key (kbd "C-x j h") (li (find-file "~")))
(global-set-key (kbd "C-x j l") (li (find-file fei-local-config)))
(global-set-key (kbd "C-x j o") (li (find-file "~/Nutstore Files/org")))
(global-set-key (kbd "C-x j O") (li (find-file "~/Nutstore Files/org/obsidian")))
(global-set-key (kbd "C-x j q") (li (browse-url "https://quword.com")))
(global-set-key (kbd "C-x j r") (li (find-file "~/Repos")))
(global-set-key (kbd "C-x j s") (li (find-file "~/Sandbox")))

(defalias 'ov 'open-current-file-with-vscode)
(defalias 'code 'open-current-file-with-vscode)
(defalias 'oe 'open-current-file-with-emacsq)
(defalias 'of 'file-manager-here)
(defalias 'ui 'fei-toggle-ui)
(defalias 'cmp 'compile)


;; Designed for `eshell'
(with-eval-after-load 'eshell
  (require 'eshell-up)
  (defalias 'eshell/u 'eshell-up)
  )

(defun eshell/jo () (eshell/cd "~/Nutstore Files/org"))
(defun eshell/je () (eshell/cd "~/.emacs.d"))
(defun eshell/repo () (eshell/cd "~/Repos"))

(defalias 'eshell/vim 'vim)
(defalias 'eshell/emacs 'emacs)

(defalias 'eshell/of 'browse-url-default-browser)
(defalias 'eshell/e 'eshell/edit)
(defalias 'eshell/z 'samray/eshell-zoxide-z)

(defalias 'eshell/k 'fei-org-capture-TODO)
(defalias 'eshell/note 'fei-org-capture-note)
(defalias 'eshell/todo 'fei-org-capture-TODO)
(defalias 'eshell/ks 'fei-org-capture-SAR)
(defalias 'eshell/kw 'fei-org-capture-WANT)
(defalias 'eshell/kd 'fei-org-capture-diary)

(defun eshell/a () (org-agenda nil "a"))


;; 不推荐用 `eshll/alias' 设置 alias，因为会在每次启动的时候重置 eshell/alias 文件

;; (with-eval-after-load 'em-alias
;;   (eshell/alias "tig" "magit")
;;   (eshell/alias "of" "browse-url-default-browser $1")
;;   )

(provide 'init-alias)
