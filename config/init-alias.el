;; init-alias.el -- 与其纠结怎么定义一个合理的 keybinding，不如用 alias

;; Commentary:

;; Finally, I find use a meaningful alias is more smoothly to
;; use. smoothly is not directly related to quickly. but I think
;; it is very critical about be a longtime quickly working state.

(require 'fei-funcs)

(setq echo-keystrokes 0.1)
(global-set-key (kbd "C-x M-m") mule-keymap)
(global-set-key (kbd "C-x C-m") 'execute-extended-command) ;`mule-keymap'
(global-set-key (kbd "C-x m") 'execute-extended-command) ;`compose-mail'
(global-set-key (kbd "C-x M") 'repeat-complex-command)

;; Designed for `M-x', but it can also be used in `eshell'
(defalias 'jj (li (find-file "~/Desktop/文献仓库/")))
(defalias 'j0 (li (find-file "~/Desktop/文献仓库/00 基本理论（凸优化&others）")))
(defalias 'j1 (li (find-file "~/Desktop/文献仓库/01 First Pass")))
(defalias 'j2 (li (find-file "~/Desktop/文献仓库/02 Second Pass")))
(defalias 'j3 (li (find-file "~/Desktop/文献仓库/03 Third Pass")))
(defalias 'js (li (find-file "~/Sandbox")))
(defalias 'jr (li (find-file "~/Repos")))
(defalias 'je (li (find-file "~/.emacs.d")))
(defalias 'ja (li (find-file "~/.emacs.d/config/init-alias.el")))
(defalias 'jg (li (find-file "~/Nutstore Files/")))
(defalias 'org (li (find-file "~/Nutstore Files/org")))
(defalias 'dot (li (find-file "~/Repos/dotfiles")))
(defalias 'sc 'scratch)
(defalias 'jl 'fei-meow-last-buffer)

(defalias 'ov 'open-current-file-with-vscode)
(defalias 'oe 'open-current-file-with-emacsq)
(defalias 'og 'open-current-file-with-gedit)
(defalias 'of 'file-manager-here)
(defalias 'ot 'fei-terminal-here)	;ot is not quickly to type

(defalias 'ui 'fei-toggle-ui)
(defalias 'cmp 'compile)
(defalias 'sh 'shell)
(defalias 'ev 'evil-mode-with-cursor)
(defalias 'wh (li (evil-move-window 'left)))
(defalias 'wl (li (evil-move-window 'right)))
(defalias 'wj (li (evil-move-window 'below)))
(defalias 'wk (li (evil-move-window 'above)))
(defalias 'one 'zygospore-toggle-delete-other-windows)
(defalias 'vs 'split-window-below)
(defalias 'hs 'split-window-right)
(defalias 'tn 'tab-new)
(defalias 'tc 'tab-close)
(defalias 't1 'tab-close-other)
(defalias 'fn 'make-frame)
(defalias 'fc 'delete-frame)
(defalias 'ffo 'find-file-other-window)
(defalias 'fft 'find-file-other-tab)
(defalias 'fff 'find-file-other-frame)

;; Designed for `eshell'
(with-eval-after-load 'eshell
  (require 'eshell-up)
  (defalias 'eshell/u 'eshell-up)
  (defalias 'eshell/up 'eshell-up)
  )

(defalias 'eshell/vim 'vim)
(defalias 'eshell/emacs 'emacs)

(defalias 'eshell/of 'browse-url-default-browser)
(defalias 'eshell/e 'eshell/edit)
(defalias 'eshell/j 'samray/eshell-fasd-z)

(defalias 'eshell/k 'fei-org-capture-note)
(defalias 'eshell/ks 'fei-org-capture-SAR)
(defalias 'eshell/kw 'fei-org-capture-WANT)
(defalias 'eshell/kd 'fei-org-capture-diary)

;; 不推荐用 `eshll/alias' 设置 alias，因为会在每次启动的时候重置 eshell/alias 文件

;; (with-eval-after-load 'em-alias
;;   (eshell/alias "tig" "magit")
;;   (eshell/alias "of" "browse-url-default-browser $1")
;;   )

(provide 'init-alias)
