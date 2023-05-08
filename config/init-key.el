;; 思路：给常用的功能一个短一点的快捷键
;; 不要为自己一时爽的按键很高的优先级，要在实践中总结经验

;; 功能1: 切换 buffer
(global-set-key (kbd "M-e") 'fei/buffer-or-tab-recent)
(define-key minibuffer-mode-map (kbd "M-q") 'minibuffer-keyboard-quit)
(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "M-e") 'vertico-next)
  (define-key vertico-map (kbd "M-a") 'vertico-exit)
  (define-key vertico-map (kbd "M-g") 'minibuffer-keyboard-quit)
  (define-key vertico-map (kbd "M-q") 'minibuffer-keyboard-quit))

(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "M-e") nil)
  (define-key matlab-mode-map (kbd "M-a") nil))

;; 功能2: capture 和 agenda
(global-set-key (kbd "M-`") 'org-agenda-list)

(global-set-key (kbd "M-s a") 'org-agenda-list)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "M-s a") nil))
(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "M-s a") nil))

(with-eval-after-load 'info
  (define-key Info-mode-map (kbd "M-n") nil))


;;;;;;;;;;;;;;;;;;;; leader key begin ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar fei-leader-keymap (make-sparse-keymap)
  "My leader keymap")

(global-unset-key (kbd "`"))
(global-set-key (kbd "`") fei-leader-keymap)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(define-key transient-map (kbd "<escape>") 'transient-quit-one)

(fei-define-key-with-map fei-leader-keymap
  '(
    ("SPC" . fei-org-capture-TODO)
    ("RET" . searchbox-search)
    ("a" . org-agenda-list)
    ("b" . switch-to-buffer)
    ("M-b" . boxes-command-on-region)
    ("c" . fei-org-capture-TODO)	;这组按键不好按
    ("d" . fei/olivetti-truncate)
    ("e" . eshell)
    ("f" . recentf-open-files)
    ("n" . fei-org-capture-note)
    ("s" . searchbox-search)
    ("S" . fei-search-1)
    ("C-s" . webjump)
    ("M-s" . searchbox-refresh-buffer)
    ("g" . fei-vc-dired-jump)
    ("M-g" . magit)
    ("t" . fei-switch-to-treemacs)
    ("h" . fei/buffer-or-tab-recent)
    ("i" . ibuffer)
    ("j" . fei-counsel-recentf-pinyin)
    ("J" . consult-dir)
    ("M-j" . fei/counsel-recentf-dir)
    ("k" . counsel-rg)
    ("M-k" . fei-consult-ripgrep-my-org)
    ("l" . vc-print-root-log)
    ("m" . execute-extended-command)
    ("o" . other-window)
    ("p" . fei-org-capture-private)
    ("q" . quit-window)
    ("M-q" . ,(li (fei-key-mode -1)))
    ("u" . tab-bar-history-back)
    ("v" . vc-next-action)
    ("w" . pwd)
    ("y" . yas-insert-snippet)
    ("z" . fei-compile)
    ("0" . my/delete-window-or-delete-frame)
    ("1" . zygospore-toggle-delete-other-windows)
    ("2" . split-window-below)
    ("3" . split-window-right)
    ("5" . make-frame-command)
    ("7" . counsel-git)
    ("8" . consult-line)
    ("9" . fei/swiper)			;swiper 是动态的 occur
    (";" . fei-swiper-isearch)
    ("'" . fei-swiper-isearch-backward)
    ("/" . rg-project-all-files-no-ask)
    ("\\" . fei-rime-force-enable)
    ("," . embark-act)
    ("=" . calculator)
    ("-" . fei/echo-line)
    ("C-q" . (lambda () (interactive) (insert "`")))
    ("`" . (lambda () (interactive) (insert "`")))
    ("M-i" . tab-to-tab-stop)
    ("M-l" . downcase-dwim)
    ("M-m" . back-to-indentation)
    ))

;; 处理冲突按键
(with-eval-after-load 'org
  (define-key org-cdlatex-mode-map (kbd "`") 'nil)
  (define-key org-cdlatex-mode-map (kbd "M-i") 'cdlatex-math-symbol))

(with-eval-after-load 'cdlatex
  (define-key cdlatex-mode-map (kbd "`") nil)
  (define-key cdlatex-mode-map (kbd "M-i") 'cdlatex-math-symbol))

(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "`") nil)
  (define-key ibuffer-mode-map (kbd "'") 'ibuffer-switch-format))

;; 一些感受：

;; 1. 因为 ` 这个按键位于左边，所以和位于右边的按键配合一起按的时候会
;; 比较舒适，如果 ` 接下来的按键还是做的话，一方面按起来不舒适，一方面
;; 左手负担也会比较重，所以和 SPC 相比，输！

;; 2. 在使用自带的 rime 输入法（系统级别的，不是 emacs 内部的），rime
;; 会在没有候选框的时候读取 ` 这个按键，而 SPC 则不会，所以 ` 会多一步
;; 切换的操作，输！

;; 3. SPC 目前只能很好的在 vim 或者其他模式编辑中使用，而我只在很少数
;; 的情况觉得模式编辑（目前指的就是 evil）有用（目前觉得有用的场景就是
;; 在已有文本上做搜索修改，如果是自己输入和创作大量的文本输入场景，我
;; 觉得模式编辑会有点束缚），所以这也是我考虑用 ` 作为 leader key 的原
;; 因，` 赢！
;;;;;;;;;;;;;;;;;;;; leader key end ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  __^__               __^__
;; ( ___ )-------------( ___ )
;;  | / | Fei Key Begin | \ |
;; (_____)-------------(_____)

(require 'fei-key)

;; (unless *is-termux* (fei-key-mode))
(cua-mode)

(defalias 'k 'fei-key-mode)
(defalias 'l 'counsel-load-theme)

(define-key fei-key-mode-map (kbd "M-l") fei-leader-keymap)
(define-key fei-key-mode-map (kbd "M-u") 'eshell)
(define-key fei-key-mode-map (kbd "C-M-g") 'fei-vc-dired-jump)
(define-key fei-key-mode-map (kbd "C-M-v") 'vc-next-action)
(define-key fei-key-mode-map (kbd "M-q") 'quit-window)
(define-key fei-key-mode-map (kbd "M-g") (kbd "C-g"))

;;  __^__             __^__
;; ( ___ )-----------( ___ )
;;  | / | Fei Key End | \ |
;; (_____)-----------(_____)


(global-set-key (kbd "M--") 'consult-line)

(require 'init-thing-edit)

(global-set-key (kbd "C-c C-=") 'fei/line-spacing-adjust)
(global-set-key (kbd "C-c C--") 'fei/line-spacing-adjust)
(global-set-key (kbd "C-c C-0") 'fei/line-spacing-adjust)

;; 配合这个命令 GTK_IM_MODULE=emacs XMODIFIERS=@im=emacs emacs 使用，
;; 命令的原理不是很清楚，效果是在 emacs 中禁用 fcitx 输入法，这样就实
;; 现了在 emacs 中 C-SPC 激活 emacs 的输入法，在其他程序激活 fcitx 输入法
(linux (global-set-key (kbd "C-SPC") 'toggle-input-method)
       (global-set-key (kbd "C-x C-SPC") 'fei-rime-force-enable))

(global-set-key (kbd "M-j") 'scroll-up-line)
(global-set-key (kbd "M-J") 'fei-rime-force-enable)
(global-set-key (kbd "M-K") 'new-buffer-other-window)
(global-set-key (kbd "M-k") 'scroll-down-line)

(define-key prog-mode-map (kbd "C-c TAB") 'fei-buffer-indent)
(define-key prog-mode-map (kbd "C-c C-l") 'vc-print-root-log)

(global-set-key (kbd "M-s /") 'rg-project-all-files-no-ask)

(global-set-key (kbd "C-S-y") (li (yank '(4))))
(global-set-key (kbd "C-x C-y") (li (yank '(4))))
(global-set-key (kbd "M-s C-y") 'yank-and-indent)
(global-set-key (kbd "C-c C-y") 'yank-and-indent)
(global-set-key (kbd "M-s M-y") 'yank-and-indent)
(global-set-key (kbd "M-s y") 'yank-and-indent)

(global-set-key (kbd "M-w") 'easy-kill)
(with-eval-after-load 'easy-kill
  (define-key easy-kill-base-map (kbd "x") 'easy-kill-exchange-point-and-mark)
  (define-key easy-kill-base-map (kbd "C-w") 'easy-kill-region))

(global-set-key (kbd "M-H") 'my/select-current-line-and-forward-line)
(global-set-key (kbd "C-M-=") 'calculator)
(global-set-key (kbd "<f7>") 'fei-ff-find-other-file-pdf-org)
(global-set-key (kbd "<f5>") 'recompile)  ;<f5> 笔记本电脑更好按
(global-set-key (kbd "<f9>") 'recompile)  ;<f9> 外置的机械键盘更好按
(global-set-key (kbd "C-x c") 'compile)

(global-set-key (kbd "C-x F") 'set-fill-column)
(global-set-key (kbd "C-c H") 'fei-pulse-current-line)

(global-set-key (kbd "M-s j") 'eshell)	;many times eshell is enough
(global-set-key (kbd "M-s M-j") 'fei-eshell-cd-here)
(global-set-key (kbd "C-c SPC") 'fei-switch-to-treemacs)
(global-set-key (kbd "M-s M-e") 'fei-switch-to-treemacs)
(global-set-key (kbd "M-s t") 'fei-switch-to-treemacs)

(add-hook 'eshell-mode-hook 'fei-eshell-setup-key)
(defun fei-eshell-setup-key ()
  (define-key eshell-mode-map (kbd "C-l") (li (recenter 0)))
  (define-key eshell-cmpl-mode-map (kbd "C-c SPC") nil)
  (define-key eshell-mode-map (kbd "C-j") 'eshell-send-input)
  (define-key eshell-mode-map (kbd "C-d") '+eshell/quit-or-delete-char)
  (define-key eshell-hist-mode-map (kbd "<up>") nil)
  (define-key eshell-hist-mode-map (kbd "C-c C-l") 'vc-print-root-log)
  (define-key eshell-hist-mode-map (kbd "<down>") nil)
  (define-key eshell-hist-mode-map (kbd "M-s") nil)
  (define-key eshell-hist-mode-map (kbd "M-r") 'fei-my/ivy-eshell-history))

(global-set-key (kbd "C-c h") 'webjump)
(global-set-key (kbd "C-c M-h") 'webjump)
(global-set-key (kbd "C-c /") 'webjump)
(global-set-key (kbd "C-h C-y") 'engine/search-quword)
(global-set-key (kbd "C-M-<return>") 'engine/search-google)

(global-set-key (kbd "C-x n c") 'narrow-to-line-indirect)
(global-set-key (kbd "C-x n N") 'narrow-to-region-indirect)
(global-set-key (kbd "C-x n l") 'fei/narrow-one-line)

(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-u") 'upcase-dwim)

(global-set-key (kbd "C-x u") 'vundo)
(global-set-key (kbd "C-/") 'undo-only)	;undo-only 不会被打断

(autoload 'move-text-up "move-text" nil t)
(autoload 'move-text-down "move-text" nil t)
(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)
(global-set-key (kbd "M-S-<down>") 'fei-duplicate-line-or-region)
(global-set-key (kbd "M-L") 'fei-duplicate-line-or-region)

(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "M-s ;") 'iedit-mode)

(global-set-key (kbd "C-x i") 'insert-char)
(global-set-key (kbd "C-x I") 'emoji-search)
(global-set-key (kbd "C-x M-i") 'all-the-icons-insert)

;; (global-set-key (kbd "C-c i") 'counsel-imenu)
(global-set-key (kbd "C-c i") 'consult-imenu)

(global-set-key (kbd "M-s `") 'bury-buffer)
(global-set-key (kbd "M-s ,") 'tab-bar-history-back) ; 这个可以处理 quit-window
;; (global-set-key (kbd "M-s ,") 'unbury-buffer)
(global-set-key (kbd "C-c b") 'project-switch-to-buffer)
(global-set-key (kbd "C-x q") 'bury-buffer) ;`kbd-macro-query'
(global-set-key (kbd "C-x Q") 'unbury-buffer)
(global-set-key (kbd "M-s q") 'quit-window)
(global-set-key (kbd "M-s M-q") 'quit-window)

(global-set-key (kbd "M-s M-h") 'highlight-symbol-at-point)

(global-set-key (kbd "C-'") 'new-buffer-other-window)

(global-set-key (kbd "M-s M-o") 'multi-occur-in-this-mode)
(global-set-key (kbd "M-s O") 'fei-occur-at-point)

(global-set-key (kbd "C-w") 'backward-kill-word-or-region)
(global-set-key (kbd "M-Z") 'zap-up-to-char)
(global-set-key (kbd "C-x r p") 'replace-string)
(global-set-key (kbd "M-r") 'replace-string)
(global-set-key (kbd "M-R") 'replace-regexp)

;; 在这个操作之后，再用鼠标左键选 tab-line 会出现标签跳动的情况
;; (global-set-key (kbd "<tab-line> <C-mouse-3>") 'tab-line-kill-this-buffer)

(global-set-key (kbd "S-SPC") 'set-mark-command)
(global-set-key (kbd "C-M-w") 'set-mark-command) ;was `append-next-kill'
(global-set-key (kbd "<f12>") (li (save-buffer) (open-current-file-with-vscode)))

(global-set-key (kbd "C-x <return>") 'execute-extended-command)
(global-set-key (kbd "C-x C-m") 'execute-extended-command) ;was `mule-keymap'

(global-set-key (kbd "C-x M-m") mule-keymap)
(global-set-key (kbd "C-x m") 'execute-extended-command) ;was `compose-mail'
(global-set-key (kbd "C-c m") 'execute-extended-command)
(global-set-key (kbd "C-x M") 'repeat-complex-command)

(global-set-key (kbd "C-4") 'set-selective-display-dwim)
(global-set-key (kbd "C-x C-4") 'set-selective-display)

(global-set-key (kbd "M-s m") 'minimize-window)

(global-set-key (kbd "C-M-;") 'fei/toggle-comment-line)

(global-set-key (kbd "C-M-,") 'marker-stack-pop)
(global-set-key (kbd "C-x L") 'vc-print-root-log)

(global-set-key (kbd "M-s M-i") 'treemacs-dired-jump)
(global-set-key (kbd "M-s C-i") 'treemacs-select-directory)
(global-set-key (kbd "<f8>") 'fei-switch-to-treemacs)
(global-set-key (kbd "M-s e") 'treemacs)

(global-set-key (kbd "C-x g") 'fei-vc-dired-jump)
(global-set-key (kbd "C-x v j") 'fei-vc-dired-jump)

(global-set-key (kbd "C-h M-c") 'describe-char)
(global-set-key (kbd "C-h M-f") 'describe-face)
(global-set-key (kbd "C-h M-k") 'describe-keymap)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-i") 'info-display-manual)

(global-set-key (kbd "M-s-j") 'make-frame-command)

(global-set-key "\M-Q" 'unfill-paragraph)
(global-set-key (kbd "C-S-i") 'insert-register)
(global-set-key (kbd "C-S-m") 'point-to-register)
(global-set-key (kbd "C-x C-u") 'jump-to-register)
(global-set-key (kbd "C-S-j") 'jump-to-register)

(global-set-key (kbd "C-S-b") 'bookmark-bmenu-list)
(global-set-key (kbd "M-'") 'bookmark-jump)
;; (global-set-key (kbd "M-s m") 'bookmark-view-push)
;; (global-set-key (kbd "M-s u") 'bookmark-view-pop)

(global-set-key (kbd "C-l") 'recenter-top-bottom) ;was `recenter-top-bottom'
(global-set-key (kbd "C-M-l") (li (recenter-top-bottom '(4)))) ;was `reposition-window'

(global-set-key (kbd "C-o") 'open-line)
(autoload 'open-newline-below "open-newline" nil t)
(autoload 'open-newline-above "open-newline" nil t)
(global-set-key (kbd "C-S-o") 'open-newline-above)
(global-set-key (kbd "C-S-<return>") 'open-newline-below)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
(when (display-graphic-p)		;终端 M-[ 快捷键有特殊含义
  (global-set-key (kbd "M-]") 'forward-paragraph)
  (global-set-key (kbd "M-[") 'backward-paragraph))
(global-set-key (kbd "C-S-z") 'undo-redo)
(global-set-key (kbd "M-s c") 'fei-clock-count-down)
(global-set-key (kbd "M-s =") 'quick-calc)

(global-set-key (kbd "C-c o") 'consult-line)

(with-eval-after-load 'cc-mode        ; 注意不是 c++-mode 而是 cc-mode
  (define-key c-mode-base-map (kbd "<f5>") #'fei-g++-compile-and-run)
  (define-key c-mode-base-map (kbd "C-c C-r") #'quickrun-shell)
  ;; (define-key c-mode-base-map (kbd "C-c M-m") 'helm-make) ; 备忘
  (define-key c-mode-base-map (kbd "C-c C-c") #'fei-g++-compile-and-run) ;was `comment-region'
  )

(global-set-key (kbd "M-o ,") 'embark-act)
(when (display-graphic-p)		;终端 M-O 快捷键有特殊含义
  (global-set-key (kbd "M-O") 'embark-act))
(global-set-key (kbd "M-.") 'embark-dwim)

;; (global-set-key (kbd "C-x C-p") (li (set-mark-command 4)))
(global-set-key (kbd "C-x C-p") 'goto-last-change)
(global-set-key (kbd "C-c C-o") 'rg-dwim)
(global-set-key (kbd "C-x M-p") 'goto-last-change)
(global-set-key (kbd "C-x M-n") 'goto-last-change-reverse)

(global-set-key (kbd "M-n") 'fei/scroll-up-push-mark)
(global-set-key (kbd "M-p") 'fei/scroll-down-push-mark)

(global-set-key (kbd "M-s u") 'jump-to-register)
(global-set-key (kbd "M-s M-u") 'jump-to-register)

(global-set-key (kbd "C-x M-l") 'switch-to-locked-buffer)
(global-set-key (kbd "C-x M-b") 'switch-to-same-major-mode-buffer)
(global-set-key (kbd "C-c b") 'project-switch-to-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer-jump)
;; (global-set-key (kbd "C-x b") 'fei-counsel-switch-buffer)
(global-set-key (kbd "C-x b") 'switch-to-buffer)

(global-set-key (kbd "M-I") 'symbol-overlay-put)
(global-set-key (kbd "M-N") 'symbol-overlay-switch-forward)
(global-set-key (kbd "M-P") 'symbol-overlay-switch-backward)

(fei-define-key-with-map global-map
  '(
    ("C-h f" . counsel-describe-function)
    ("C-h o" . counsel-describe-symbol)
    ("C-h v" . counsel-describe-variable)
    ("C-h C-l" . find-library)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c j" . fei-counsel-recentf-pinyin)
    ("C-c M-j" . fei/counsel-recentf-dir)
    ("C-x f" . counsel-find-file)
    ))

;; (global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-x") 'execute-extended-command)

(with-eval-after-load 'org
  (global-set-key (kbd "C-c M-l") 'org-store-link)
  (global-set-key (kbd "C-c s") 'org-store-link))

(global-set-key (kbd "M-s n") 'fei-swiper-isearch)
(global-set-key (kbd "M-s M-n") 'fei-swiper-isearch)
(global-set-key (kbd "M-s p") 'fei-swiper-isearch-backward)
(global-set-key (kbd "M-s M-p") 'fei-swiper-isearch-backward)

(global-set-key (kbd "C-M-z") 'fei-compile)
(global-set-key (kbd "M-s z") 'fei-compile)

(cond
 (*is-windows* (global-set-key (kbd "C-c l") 'counsel-locate))
 (t (global-set-key (kbd "C-c l") 'locate)
    (global-set-key (kbd "C-c L") 'counsel-locate)))

(win10
 (global-set-key (kbd "<scroll>") 'scroll-lock-mode)
 (with-eval-after-load 'ibuffer
   (define-key ibuffer-mode-map (kbd "<mouse-5>") 'fei/ibuffer-mouse-visit-buffer))
 (global-set-key (kbd "<mode-line> <mouse-5>") 'ibuffer))

(global-set-key (kbd "<insert>") 'nil)

(global-set-key (kbd "C-c T") 'trashed)

(global-set-key (kbd "M-s d") 'fei/olivetti-truncate)
(global-set-key (kbd "M-s M-d") 'fei/olivetti-truncate)
(global-set-key (kbd "M-s M-a") 'org-agenda-list)
(global-set-key (kbd "M-a") 'org-agenda-list)

(global-set-key (kbd "M-s h a") 'fei-highlight-region)
(global-set-key (kbd "M-s h ,") 'fei-unhighlight-symbol-at-point)

(global-set-key (kbd "<pause>") 'fei-org-time)
(global-set-key (kbd "<C-pause>") 'org-timer-set-timer)
(global-set-key (kbd "<M-pause>") 'fei-pomodoro-timer)
(global-set-key (kbd "ESC <pause>") 'fei-pomodoro-timer)

(global-set-key (kbd "M-s [") 'fei/load-zenburn)
(global-set-key (kbd "M-s ]") 'fei/disable-theme)

(global-set-key (kbd "C-c a") (li (org-agenda nil "a")))
(global-set-key (kbd "C-c A") 'org-agenda)
(global-set-key (kbd "C-c c") 'fei-org-capture-TODO)
(global-set-key (kbd "C-c C") 'fei-org-capture)
(global-set-key (kbd "C-c n c") 'fei-org-capture-canvas)
(global-set-key (kbd "C-c n C") 'fei-org-capture-goto-canvas)
(global-set-key (kbd "C-c n n") 'fei-org-capture-note)
(global-set-key (kbd "C-c n N") 'fei-org-capture-goto-note)
(global-set-key (kbd "C-c n j") 'fei-org-capture-private)
(global-set-key (kbd "C-c n J") 'fei-org-capture-goto-private)
(global-set-key (kbd "C-c n l") 'fei-org-capture-log)
(global-set-key (kbd "C-c n L") 'fei-org-capture-goto-log)
(global-set-key (kbd "C-c n s") 'fei-org-capture-SAR)
(global-set-key (kbd "C-c n S") 'fei-org-capture-goto-SAR)
(global-set-key (kbd "C-c n i") 'fei-org-capture-clock)
(global-set-key (kbd "C-c n w") 'fei-org-capture-WANT)
(global-set-key (kbd "C-c n W") 'fei-org-capture-goto-WANT)
(global-set-key (kbd "C-c n k") 'fei-orgn-capture-Research)
(global-set-key (kbd "C-c n K") 'fei-org-capture-goto-Research)

(global-set-key (kbd "M-s \\") 'fei-rime-force-enable)
(global-set-key (kbd "C-x C-\\") 'fei-rime-force-enable)
(global-set-key (kbd "C-c K") 'fei-consult-ripgrep-my-org)

;; (global-set-key (kbd "M-J") (li (w32-set-ime-open-status nil)))

(global-set-key (kbd "C-9") 'tab-bar-history-back)
(global-set-key (kbd "C-x 9") 'tab-bar-history-back)
(global-set-key (kbd "C-8") 'jetbrains-open-buffer-file)
(global-set-key (kbd "C-M-8") 'jetbrains-create-dir-local-file)

(global-set-key (kbd "M-s r") 'rg-dwim-current-file)
(global-set-key (kbd "M-s R") 'rg-dwim-current-dir)
(global-set-key (kbd "M-s M-r") 'rg-project-all-files-no-ask)

(global-set-key (kbd "C-x <left>") 'tab-line-switch-to-prev-tab)
(global-set-key (kbd "C-x <right>") 'tab-line-switch-to-next-tab)
;; (define-key tab-line-tab-map [tab-line down-mouse-3] 'tab-line-close-tab) ;tab-line-tab-context-menu

(global-set-key (kbd "M-s C-m") 'browse-url)
(global-set-key (kbd "M-G") 'fei-search)
(global-set-key (kbd "M-s M-w") 'fei-search)
(global-set-key (kbd "M-s M-s") 'searchbox-search)
(global-set-key (kbd "M-s s") 'fei-search)
(global-set-key (kbd "M-S") 'fei-search)

(global-set-key (kbd "C-x t i") 'tab-bar-mode)
(global-set-key (kbd "C-x t l") 'tab-recent)
(global-set-key (kbd "C-x t h") 'fei-switch-current-buffer-to-new-tab)
(add-hook 'tab-bar-mode-hook 'fei-tab-bar-define-key)
(defun fei-tab-bar-define-key ()
  (global-set-key (kbd "M-1") 'fei-select-tab)
  (global-set-key (kbd "M-2") 'fei-select-tab)
  )

(global-set-key (kbd "C-=") 'text-scale-adjust)
(global-set-key (kbd "C--") 'text-scale-adjust)
(global-set-key (kbd "M-+") 'big-font)
(global-set-key (kbd "M-_") 'small-font)

(global-set-key (kbd "<f2>") 'list-bookmarks)
(global-set-key (kbd "C-x j") 'new-buffer)
(global-set-key (kbd "C-x M-j") 'new-buffer-other-window)
(global-set-key (kbd "C-x M-h") 'new-buffer)
(global-set-key (kbd "C-x B") 'new-buffer)

(global-set-key (kbd "M-g u") 'jump-to-register)
(global-set-key (kbd "M-g M-u") 'jump-to-register)
(global-set-key (kbd "M-g M-f") 'find-file)
(global-set-key (kbd "M-g f") 'find-file)
(global-set-key (kbd "M-g d") 'dumb-jump-go)
(global-set-key (kbd "M-g b") 'dumb-jump-back)
(global-set-key (kbd "M-g l") 'goto-last-change)
(global-set-key (kbd "M-g M-l") 'goto-last-change)

(global-set-key (kbd "M-s C-n") 'popper-cycle)
(global-set-key (kbd "M-s C-j") 'popper-toggle-latest)
(global-set-key (kbd "M-s l") 'popper-toggle-latest)
(global-set-key (kbd "C-x l") 'popper-toggle-latest)
(global-set-key (kbd "M-s M-l") 'popper-toggle-latest)
(global-set-key (kbd "M-s L") 'popper-toggle-type)
(global-set-key (kbd "C-x C-l") 'popper-toggle-type)
(global-set-key (kbd "M-s C-p") 'popper-toggle-type)

;; (global-set-key (kbd "M-k") 'fei/kill-or-bury-buffer)
;; (global-set-key (kbd "M-K") 'reopen-killed-file)
(global-set-key (kbd "C-x k") 'fei/kill-or-bury-buffer)
(global-set-key (kbd "C-x K") 'reopen-killed-file)

;; (global-set-key (kbd "C-x y") 'consult-yasnippet)
(global-set-key (kbd "C-x y") 'yas-insert-snippet)
(global-set-key (kbd "C-x Y") 'yas-new-snippet)

(global-set-key (kbd "C-c <left>") 'tab-bar-history-back)
(global-set-key (kbd "C-c C-<left>") 'tab-bar-history-back)
(global-set-key (kbd "C-c <right>") 'tab-bar-history-forward)
(global-set-key (kbd "C-c C-<right>") 'tab-bar-history-forward)
(global-set-key (kbd "M-<left>") 'tab-bar-history-back)
(global-set-key (kbd "M-<right>") 'tab-bar-history-forward)

(global-set-key (kbd "C-0") 'my/delete-window-or-delete-frame)
(global-set-key (kbd "C-x 0") 'my/delete-window-or-delete-frame)
(global-set-key (kbd "C-c 0") 'my/delete-window-or-delete-frame)
(global-set-key (kbd "C-1") 'zygospore-toggle-delete-other-windows)
(global-set-key (kbd "C-2") (li (split-window-below) (other-window 1)))
(global-set-key (kbd "C-3") (li (split-window-right) (other-window 1)))
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)
(autoload 'evil-move-window "evil" nil t)
(global-set-key (kbd "C-x w H") (li (evil-move-window 'left)))
(global-set-key (kbd "C-x w L") (li (evil-move-window 'right)))
(global-set-key (kbd "C-x w K") (li (evil-move-window 'above)))
(global-set-key (kbd "C-x w J") (li (evil-move-window 'below)))
(global-set-key (kbd "M-s i") 'fei/fit-window-to-buffer)
(global-set-key (kbd "C-x 4 -") 'fit-window-to-buffer) ;一个 window 的时候和 `fit-window-to-buffer'
(global-set-key (kbd "C-x 5 -") 'fit-frame-to-buffer)
(global-set-key (kbd "C-x _") 'adjust-frame-by-longest-line)
(global-set-key (kbd "C-x w u") 'tab-bar-history-back)
(global-set-key (kbd "C-x w h") 'windmove-left)
(global-set-key (kbd "C-x w l") 'windmove-right)
(global-set-key (kbd "C-x w j") 'windmove-down)
(global-set-key (kbd "C-x w k") 'windmove-up)
(global-set-key (kbd "C-x w s") 'window-swap-states)
(global-set-key (kbd "C-x w M") 'maximize-window)
(global-set-key (kbd "C-x w m") 'minimize-window)
;; ace-window 可以 跳到 side-windows 上面，但是 other-window 不行
(global-set-key (kbd "C-x o") 'other-window)
(global-set-key (kbd "C-x O") 'other-frame)
(global-set-key (kbd "C-x M-o") 'other-frame)

(global-set-key (kbd "M-s b") 'consult-buffer)

(define-key mode-line-buffer-identification-keymap [mode-line mouse-2] 'ibuffer-jump)

;; @REF: http://joaotavora.github.io/yasnippet/snippet-expansion.html
(with-eval-after-load 'yasnippet
  (global-set-key (kbd "C-M-y") 'yas-expand)
  (define-key yas-minor-mode-map (kbd "<tab>") yas-maybe-expand)
  (define-key yas-minor-mode-map (kbd "TAB") yas-maybe-expand)
  (define-key yas-minor-mode-map (kbd "M-i") yas-maybe-expand) ;注意：`yas-maybe-expand' 是一个 variable
  (define-key yas-keymap (kbd "M-n") 'yas-next-field)
  (define-key yas-keymap (kbd "M-p") 'yas-prev-field)
  (define-key yas-keymap (kbd "M-i") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "M-I") 'yas-prev-field)
  )

(with-eval-after-load 'bookmark
  (define-key bookmark-bmenu-mode-map (kbd "SPC") 'bookmark-jump))

(with-eval-after-load 'latex
  (autoload 'er/mark-LaTeX-math "latex-mode-expansions" nil t)
  (autoload 'er/mark-LaTeX-inside-environment "latex-mode-expansions" nil t)
  (define-key LaTeX-mode-map (kbd "C-M-w") 'er/mark-LaTeX-math)
  (define-key LaTeX-mode-map (kbd "C-M-e") 'LaTeX-mark-environment)
  (define-key LaTeX-mode-map (kbd "C-c ,") 'LaTeX-mark-environment)
  (define-key LaTeX-mode-map (kbd "M-=") 'fei/latex-insert-equation)
  (define-key LaTeX-mode-map (kbd "C-s") 'fei-swiper-isearch)
  (define-key LaTeX-mode-map (kbd "C-r") 'fei-swiper-isearch-backward)
  (define-key LaTeX-mode-map (kbd "C-c C-i") 'fei-buffer-indent) ;was `TeX-goto-info-page'
  )

(setq embark-cycle-key ",")
(autoload 'vertico-multiform-posframe "vertico-posframe" nil t)
(define-key vertico-multiform-map (kbd "M-P") 'vertico-multiform-posframe)
(define-key vertico-map (kbd "M-h") 'vertico-exit)
(define-key vertico-map (kbd "C-M-j") 'vertico-exit-input)
(define-key vertico-map (kbd "C-'") 'vertico-quick-exit)
(define-key vertico-map (kbd "M-o") 'embark-act)
(define-key vertico-map (kbd "C-c C-o") 'embark-collect)
(define-key vertico-map (kbd "C-c C-l") 'embark-live)
(with-eval-after-load 'vertico-grid
  (when (display-graphic-p)		;终端 M-[ 快捷键有特殊含义
    (define-key vertico-grid-map (kbd "M-[") 'vertico-grid-scroll-up)
    (define-key vertico-grid-map (kbd "M-]") 'vertico-grid-scroll-down)))


(win10
 (with-eval-after-load 'python
   ;; simple complie for python
   (define-key python-mode-map (kbd "<f5>") 'fei-python-run)
   (define-key python-mode-map (kbd "<C-f5>") (li (fei-python-run 1)))

   (defun fei-python-run (&optional flag)
     (interactive "P")
     (save-buffer (current-buffer))
     (if flag
	 (start-process "python"
			"*fei-python*"
			"cmd" "/c" "start" "cmd" "/k" "python" "-i" (buffer-file-name))
       (start-process "python"
                      "*fei-python*"
                      "cmd" "/c" "start" "cmd" "/k" "python" (buffer-file-name))))))


(fei-define-key-with-map isearch-mode-map
  '(("M-g" . isearch-cancel)
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("<C-return>" . prot-search-isearch-other-end)
    ("C-'" . avy-isearch)
    ("M-'" . avy-isearch)	 ;gnome-terminal 读不到 C-',用这个代替
    ("C-c k" . fei-counsel-rg-from-isearch)
    ("M-s r" . rg-isearch-project)
    ("M-j" . isearch-edit-string)
    ("M-s r" . rg-isearch-project)
    ("C-c C-o" . fei/isearch-occur)
    ))

(add-hook 'term-mode-hook '+fei-term-mode-hook)
(defun +fei-term-mode-hook ()
  (define-key term-mode-map (kbd "M-s") 'nil)
  (define-key term-mode-map (kbd "M-0") 'nil)
  (define-key term-mode-map (kbd "M-1") 'nil)
  (define-key term-mode-map (kbd "M-2") 'nil)
  (define-key term-mode-map (kbd "M-3") 'nil)
  (define-key term-mode-map (kbd "M-4") 'nil)
  (define-key term-mode-map (kbd "M-5") 'nil)
  (define-key term-mode-map (kbd "M-6") 'nil)
  (define-key term-mode-map (kbd "M-7") 'nil)
  (define-key term-mode-map (kbd "M-8") 'nil)
  (define-key term-mode-map (kbd "M-9") 'nil)
  (define-key term-mode-map (kbd "M-`") 'nil))

(define-key tab-switcher-mode-map (kbd "q") 'tab-close)

(with-eval-after-load 'term
  (define-key term-raw-map (kbd "M-s") 'nil))

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "<f5>") (li (compile (concat "python3 " (buffer-file-name)))))
  (define-key python-mode-map (kbd "C-c C-k") 'python-shell-send-buffer)
  (define-key python-mode-map (kbd "C-c C-c") 'fei-python-compile-and-run))

(setq rime-translate-keybindings
      '("C-f" "C-b" "C-n" "C-p" "C-g" "C-h" "C-e" "C-v" "M-v" "M-f" "M-b"
	"C-`" "C-d" "C-k" "C-y" "<tab>" "C-a" "C-u" "M-n" "M-p"
	"<left>" "<right>" "<up>" "<down>" "<prior>" "<next>" "<delete>"))

(with-eval-after-load 'rime
  (global-set-key (kbd "C-`") 'rime-select-schema)
  (define-key rime-active-mode-map (kbd "C-i") 'rime-inline-ascii)
  (define-key rime-active-mode-map (kbd "M-i") 'rime-inline-ascii)
  (define-key rime-active-mode-map (kbd "M-h") 'rime--return)
  (define-key rime-active-mode-map (kbd "C-j") 'rime--return))


;;; Pyim
(with-eval-after-load 'pyim
  (define-key pyim-mode-map (kbd "C-h") 'pyim-delete-backward-char)
  (define-key pyim-mode-map (kbd "M-h") 'pyim-quit-no-clear)
  (define-key pyim-mode-map (kbd "<escape>") 'pyim-quit-clear)
  (define-key pyim-mode-map (kbd "C-v") 'pyim-next-page)
  (define-key pyim-mode-map (kbd "M-v") 'pyim-previous-page)
  (define-key pyim-mode-map (kbd "M-1") (li (pyim-select-subword-by-number 1)))
  (define-key pyim-mode-map (kbd "M-2") (li (pyim-select-subword-by-number 2)))
  (define-key pyim-mode-map (kbd "M-3") (li (pyim-select-subword-by-number 3)))
  (define-key pyim-mode-map (kbd "M-4") (li (pyim-select-subword-by-number 4))))


(define-key prog-mode-map (kbd "C-c C-s") 'fei-vc-dired-jump)
(define-key prog-mode-map (kbd "M-RET") 'hs-toggle-hiding)
(define-key prog-mode-map (kbd "M-S-<return>") 'hs-hide-level)

;;; Helpful
;; (global-set-key (kbd "C-h o") 'helpful-symbol)
;; (global-set-key (kbd "C-h O") 'describe-symbol)
;; (global-set-key (kbd "C-h k") 'helpful-key)

(global-set-key (kbd "<menu>") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "C-h y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-c y") 'fei-youdao-at-point)
(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input)
  (define-key youdao-dictionary-mode-map (kbd "d") 'fei-quword-at-point))

(with-eval-after-load 'symbol-overlay
  (define-key symbol-overlay-map (kbd "o") 'fei-occur-at-point)
  (define-key symbol-overlay-map (kbd "l") 'recenter-top-bottom)
  (define-key symbol-overlay-map (kbd "O") 'symbol-overlay-find-at-point-project)
  (define-key symbol-overlay-map (kbd "M-r") 'rg-dwim-current-dir))

(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "M-d") 'fei/olivetti-truncate)
  (define-key org-agenda-mode-map (kbd "(") 'fei-org-agenda-toggle-done-entry)
  (define-key org-agenda-mode-map (kbd "n") 'fei/org-agenda-next-line)
  (define-key org-agenda-mode-map (kbd "p") 'fei/org-agenda-prev-line)
  (define-key org-agenda-mode-map (kbd "W") 'fei-org-agenda-refile-to-file)
  (define-key org-agenda-mode-map (kbd "k") 'fei-org-capture-TODO)
  (define-key org-agenda-mode-map (kbd "'") 'org-agenda-list)
  (define-key org-agenda-mode-map (kbd "K") 'org-agenda-capture))

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "e") 'fei-eshell-cd-here)
  (define-key treemacs-mode-map (kbd "z") 'fei-compile)
  (define-key treemacs-mode-map (kbd "N") 'treemacs-next-workspace)
  (define-key treemacs-mode-map (kbd "S") 'treemacs-select-directory)
  (define-key treemacs-mode-map (kbd "J") 'fei-treemacs-move-to-left)
  (define-key treemacs-mode-map (kbd "K") 'fei-treemacs-move-to-right)
  (define-key treemacs-mode-map (kbd "v") 'fei-vc-dired-jump))

;; 用得很少
(define-key prog-mode-map (kbd "C-c '") #'separedit)
(define-key minibuffer-local-map (kbd "C-c '") #'separedit)


(when *is-linux*
  ;; (global-set-key (kbd "C-c w") 'counsel-wmctrl)
  ;; (global-set-key (kbd "C-c m") 'counsel-linux-app)
  (global-set-key (kbd "C-c p") 'proced)
  )

(global-set-key (kbd "s-l") 'lsp)
(setq lsp-keymap-prefix "s-l")

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "C-c M-o") 'obsidian-follow-link-at-point)
  (define-key markdown-mode-map (kbd "C-x M-o") 'open-current-file-with-obsidian)

  (fei-define-key-with-map markdown-mode-map
    '(
      ("M-s !" . markdown-insert-header-setext-1)
      ("M-s 1" . markdown-insert-header-atx-1)
      ("M-s 2" . markdown-insert-header-atx-2)
      ("M-s 3" . markdown-insert-header-atx-3)
      ("M-s 4" . markdown-insert-header-atx-4)
      ("M-s 5" . markdown-insert-header-atx-5)
      ("M-s 6" . markdown-insert-header-atx-6)
      ("<M-up>" . markdown-move-up)
      ("<M-down>" . markdown-move-down)
      )))

(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "M-s") nil)
  (define-key matlab-mode-map (kbd "M-j") nil))

(define-key emacs-lisp-mode-map (kbd "<C-right>") 'sp-forward-slurp-sexp)
(define-key emacs-lisp-mode-map (kbd "<C-left>") 'sp-forward-barf-sexp)
(define-key emacs-lisp-mode-map (kbd "M-U") 'sp-splice-sexp)
(define-key emacs-lisp-mode-map (kbd "M-q") 'sp-indent-defun)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key lisp-interaction-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key lisp-interaction-mode-map (kbd "C-c =") 'macrostep-expand)
(define-key lisp-interaction-mode-map (kbd "C-c C-e") 'pp-eval-last-sexp)
(define-key lisp-interaction-mode-map (kbd "C-c M-e") 'pp-macroexpand-last-sexp)
(define-key emacs-lisp-mode-map (kbd "C-c =") 'macrostep-expand)
(define-key emacs-lisp-mode-map (kbd "C-c C-e") 'pp-eval-last-sexp)
(define-key emacs-lisp-mode-map (kbd "C-c M-e") 'pp-macroexpand-last-sexp)


;;; Ibuffer

(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line) ;was `ibuffer-jump-to-buffer'
  (define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line) ;was `ibuffer-kill-line'
  (define-key ibuffer-mode-map (kbd "_") 'fei-remove-ibuffer-tmp-hide-regexps)
  (define-key ibuffer-mode-map (kbd "a") 'ibuffer-toggle-all)
  (define-key ibuffer-mode-map (kbd "z") 'ibuffer-toggle-special)
  (define-key ibuffer-mode-map (kbd "i") 'ibuffer-toggle-emacs)
  (define-key ibuffer-mode-map (kbd "c") 'ibuffer-toggle-notes)
  (define-key ibuffer-mode-map (kbd "SPC") 'switch-to-buffer)
  (define-key ibuffer-mode-map (kbd "M-d") 'fei/olivetti-truncate)
  (define-key ibuffer-mode-map (kbd ";") 'ibuffer-interactive-filter-by-mode))


(with-eval-after-load 'emmet-mode
  (define-key emmet-mode-keymap (kbd "C-M-j") 'emmet-expand-yas))

(with-eval-after-load 'dart-mode
  (define-key dart-mode-map (kbd "C-M-x") #'flutter-run-or-hot-reload))

(with-eval-after-load 'pdf-view
  (define-key pdf-view-mode-map (kbd "j") 'pdf-view-next-line-or-next-page)
  (define-key pdf-view-mode-map (kbd "k") 'pdf-view-previous-line-or-previous-page)
  (linux (define-key pdf-view-mode-map (kbd "e") 'fei-pdf-view-open-pdf-external))
  (define-key pdf-view-mode-map (kbd "<mouse-4>") 'pdf-view-next-page)
  (define-key pdf-view-mode-map (kbd "<mouse-5>") 'pdf-view-previous-page)
  (define-key pdf-view-mode-map (kbd "i") 'pdf-view-themed-minor-mode))

(with-eval-after-load 'elfeed
  (define-key elfeed-search-mode-map (kbd "f") 'elfeed-search-show-entry)
  (define-key elfeed-search-mode-map (kbd "l") 'recenter-top-bottom))

(with-eval-after-load 'vterm
  (define-key vterm-mode-map (kbd "M-s") nil))

;;; Dired
(with-eval-after-load 'dired
  (define-key dired-mode-map [mouse-3] 'fei-dired-mouse-find-file-externally)
  (define-key dired-mode-map [mouse-2] 'dired-mouse-find-file)
  (cond
   (*is-linux*
    (define-key dired-mode-map [mouse-8] 'dired-up-directory))
   (*is-windows*
    (define-key dired-mode-map [mouse-4] 'dired-up-directory)))

  (fei-define-key-with-map dired-mode-map
    `(
      ("b" . dired-up-directory)
      ("h" . dired-up-directory)
      ("K" . dired-do-kill-lines)
      ("C-k" . dired-kill-subdir)
      ("j" . dired-next-line)
      ("J" . fei-counsel-fd-file-jump)
      ("k" . dired-previous-line)
      ("l" . dired-find-file)
      ("e" . wdired-change-to-wdired-mode)
      ("," . browse-url-of-dired-file)
      ("." . fei-dired-toggle-hidden)
      ("'" . fei-eshell-cd-here)
      ("_" . dired-create-empty-file)
      ("SPC" . find-file)
      ("z" . fei-compile)
      ("<left>" . dired-up-directory)
      ("<right>" . dired-find-file)
      ))

  (define-key dired-mode-map (kbd "M-d") 'fei/olivetti-truncate)

  (define-key dired-mode-map (kbd ";f") 'dired-jump-following-symlinks)
  (define-key dired-mode-map (kbd ";c") 'dired-ranger-copy)
  (define-key dired-mode-map (kbd ";v") 'dired-ranger-paste)
  (define-key dired-mode-map (kbd ";V") 'dired-ranger-move)
  (define-key dired-mode-map (kbd ";d") 'dired-duplicate-this-file)
  (define-key dired-mode-map (kbd ";g") 'fei-git-status)
  (define-key dired-mode-map (kbd ";s") 'fei-vc-dired-jump)
  (define-key dired-mode-map (kbd ";w") 'file-manager-here)
  (define-key dired-mode-map (kbd ";l") 'vc-print-root-log))

;;; Dirvish
(with-eval-after-load 'dirvish
  (fei-define-key-with-map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
    '(
      ;; ("a"   . dirvish-quick-access)
      ("f"   . dirvish-file-info-menu)
      ("y"   . dirvish-yank-menu)
      ("N"   . dirvish-narrow)
      ("^"   . dirvish-history-last)
      ("H"   . dirvish-history-jump)	; remapped `describe-mode'
      ("s"   . dirvish-quicksort)	; remapped `dired-sort-toggle-or-edit'
      ("v"   . dirvish-vc-menu)	; remapped `dired-view-file'
      ("TAB" . dirvish-subtree-toggle)
      ("M-n" . dirvish-history-go-forward)
      ("M-p" . dirvish-history-go-backward)
      ("M-l" . dirvish-ls-switches-menu)
      ("M-m" . dirvish-mark-menu)
      ("M-t" . dirvish-layout-toggle)
      ("M-h" . dirvish-layout-toggle)
      ("M-u" . dirvish-setup-menu)
      ("M-E" . dirvish-emerge-menu)
      ("M-S" . dirvish-layout-switch)
      ("/"   . dirvish-narrow)
      )))

;;; Diff
(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "M-o") nil)
  (define-key diff-mode-map (kbd "M-k") nil)
  (define-key diff-mode-map (kbd "M-n") nil)
  (define-key diff-mode-map (kbd "M-p") nil)
  (define-key diff-mode-map (kbd "M-N") nil)
  (define-key diff-mode-map (kbd "M-P") nil)
  (define-key diff-mode-map (kbd "l") 'recenter-top-bottom)
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))

(with-eval-after-load 'dired-x
  (define-key dired-mode-map (kbd "M-G") nil))

;;; Compile
(with-eval-after-load 'compile
  ;; (define-key compilation-shell-minor-mode-map (kbd "C-c C-k") 'compilation-minor-mode) ; 这个方式也不错
  (define-key compilation-shell-minor-mode-map (kbd "C-c C-k") 'fei-kill-compilation)
  (define-key compilation-mode-map (kbd "d") 'fei-cmp-change-dire-recompile)
  (define-key compilation-mode-map (kbd "e") 'compile)
  (define-key compilation-mode-map (kbd "G") 'fei-cmp-change-run)
  (define-key compilation-mode-map (kbd "i") 'fit-window-to-buffer)
  (define-key compilation-mode-map (kbd "l") 'recompile)
  (define-key compilation-mode-map (kbd "m") 'minimize-window)
  (define-key compilation-mode-map (kbd "r") 'compile)
  (define-key compilation-mode-map (kbd "z") 'fei-compile))

;;; Company
(with-eval-after-load 'company
  (define-key company-mode-map (kbd "C-M-i") #'company-complete)
  (fei-define-key-with-map company-active-map
    '(("M-n" . company-select-next)
      ("M-p" . company-select-previous)
      ("C-h" . company-show-doc-buffer)
      ("M-i" . yas-expand)
      ("TAB" . company-complete-selection)
      ("M-h" . company-complete-selection)
      ("M-H" . company-complete-common)
      ("M-w" . company-show-location)
      ("M-s" . company-filter-candidates)
      ("M-/" . company-other-backend)
      ("M-g" . company-abort)
      ("C-w" . nil)
      ))

  (define-key company-search-map (kbd "M-n") 'company-select-next)
  (define-key company-search-map (kbd "M-p") 'company-select-previous)
  (add-to-list 'company-transformers 'delete-dups))



;;; VC
(with-eval-after-load 'vc-dir
  (define-key vc-dir-mode-map (kbd "z") 'fei-compile)
  (define-key vc-dir-mode-map (kbd "e") 'fei-eshell-cd-here) ;default is `vc-find-file'
  (define-key vc-dir-mode-map (kbd "j") 'project-find-file)
  (define-key vc-dir-mode-map (kbd "!") 'shell-command)
  (define-key vc-dir-mode-map (kbd "&") 'async-shell-command))

(with-eval-after-load 'vc-git
  (define-key vc-git-log-edit-mode-map (kbd "C-c C-l") 'vc-print-root-log)
  (define-key vc-git-log-view-mode-map (kbd "z") 'fei-compile)
  (define-key vc-git-log-view-mode-map (kbd "s") 'fei-vc-dired-jump))

(with-eval-after-load 'recentf
  (define-key recentf-dialog-mode-map (kbd "SPC") 'fei/swiper)
  (define-key recentf-dialog-mode-map (kbd "e") 'recentf-edit-list)
  (define-key recentf-dialog-mode-map (kbd "g") 'recentf-open-files))

(provide 'init-key)
