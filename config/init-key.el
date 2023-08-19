(require 'init-thing-edit)
(cua-mode)

(global-set-key (kbd "M-s j") 'eshell)
(global-set-key (kbd "M-s M-j") 'fei-eshell-cd-here)
(global-set-key (kbd "C-\\") 'toggle-input-method)
(global-set-key (kbd "M-J") 'new-buffer-other-window)
(global-set-key (kbd "M-j") 'fei-rime-force-enable)
(global-set-key (kbd "M-k") (li (deactivate-input-method)))
(global-set-key (kbd "C-w") 'backward-kill-word-or-region)
(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-u") 'upcase-dwim)

(global-set-key (kbd "C-c SPC") 'my/select-current-line-and-forward-line)
(global-set-key (kbd "M-s SPC") 'set-mark-command)

(autoload 'move-text-up "move-text" nil t)
(autoload 'move-text-down "move-text" nil t)
(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)
(global-set-key (kbd "M-L") 'fei-duplicate-line-or-region)

(global-set-key (kbd "C-c d s") (li (desktop-save user-emacs-directory)))
(global-set-key (kbd "C-c d r") 'desktop-read)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(define-key transient-map (kbd "<escape>") 'transient-quit-one)

(global-set-key (kbd "C-c C-=") 'fei/line-spacing-adjust)
(global-set-key (kbd "C-c C--") 'fei/line-spacing-adjust)
(global-set-key (kbd "C-c C-0") 'fei/line-spacing-adjust)
(global-set-key (kbd "C-=") 'text-scale-adjust)
(global-set-key (kbd "C--") 'text-scale-adjust)
(global-set-key (kbd "M-+") 'big-font)
(global-set-key (kbd "M-_") 'small-font)

(global-set-key (kbd "M-n") 'scroll-up-line)
(global-set-key (kbd "M-p") 'scroll-down-line)
(with-eval-after-load 'info (define-key Info-mode-map (kbd "M-n") nil))

(global-set-key (kbd "C-S-y") (li (yank '(4))))
(global-set-key (kbd "C-x C-y") 'yank-and-indent)

(global-set-key (kbd "M-s =") 'calculator)
(global-set-key (kbd "C-M-=") 'quick-calc)
(global-set-key (kbd "<f7>") 'fei-ff-find-other-file-pdf-org)
(global-set-key (kbd "<f5>") 'recompile)  ;<f5> 笔记本电脑更好按
(global-set-key (kbd "<f9>") 'recompile)  ;<f9> 外置的机械键盘更好按

(global-set-key (kbd "C-x F") 'set-fill-column)

(add-hook 'eshell-mode-hook 'fei-eshell-setup-key)
(defun fei-eshell-setup-key ()
  (define-key eshell-mode-map (kbd "C-l") (li (recenter 0)))
  (define-key eshell-mode-map (kbd "C-o") 'fei/eshell-bash-commit)
  (define-key eshell-mode-map (kbd "C-j") 'eshell-send-input)
  (define-key eshell-mode-map (kbd "C-d") '+eshell/quit-or-delete-char)
  (define-key eshell-cmpl-mode-map (kbd "C-c SPC") nil)
  (define-key eshell-hist-mode-map (kbd "<up>") nil)
  (define-key eshell-hist-mode-map (kbd "<down>") nil)
  (define-key eshell-hist-mode-map (kbd "M-s") nil)
  (define-key eshell-hist-mode-map (kbd "M-r") 'fei-my/ivy-eshell-history))

(global-set-key (kbd "C-4") 'set-selective-display-dwim)
(global-set-key (kbd "C-x C-4") 'set-selective-display)
(global-set-key (kbd "C-c h h") 'hs-toggle-hiding)
(global-set-key (kbd "C-c h a") 'hs-hide-all)
(global-set-key (kbd "C-c h k") 'hs-show-all)
(global-set-key (kbd "C-c h l") 'hs-hide-level)
(global-set-key (kbd "C-c h o") 'hs-show-block)

(global-set-key (kbd "C-x n c") 'narrow-to-line-indirect)
(global-set-key (kbd "C-x n i") 'narrow-to-region-indirect)
(global-set-key (kbd "C-x n l") 'fei/narrow-one-line)

(global-set-key (kbd "C-x U") 'vundo)   ;更容易记忆
(global-set-key (kbd "C-/") 'undo-only)	;undo-only 不会被打断

(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "M-s ;") 'iedit-mode)

(global-set-key (kbd "M-`") 'fei/buffer-or-tab-recent)
(global-set-key (kbd "C-x RET") 'fei/buffer-or-tab-recent)
(global-set-key (kbd "C-x <return>") 'fei/buffer-or-tab-recent)

(global-set-key (kbd "C-x i") 'insert-char)
(global-set-key (kbd "C-x I") 'all-the-icons-insert)
(global-set-key (kbd "C-x M-i") 'insert-file)

(global-set-key (kbd "M-s ,") 'tab-bar-history-back) ;这个可以处理 quit-window
(global-set-key (kbd "C-x q") 'bury-buffer) ;`kbd-macro-query'
(global-set-key (kbd "C-x Q") 'unbury-buffer)
(global-set-key (kbd "M-s q") 'quit-window)
(global-set-key (kbd "M-s M-q") 'quit-window)

(global-set-key (kbd "M-s M-o") 'multi-occur-in-this-mode)
(global-set-key (kbd "M-s O") 'fei-occur-at-point)

(global-set-key (kbd "M-Z") 'zap-up-to-char)
(global-set-key (kbd "C-S-h") 'replace-string)
(global-set-key (kbd "M-H") 'replace-string-one-line)

(with-eval-after-load 'conf-mode
  (define-key conf-space-mode-map (kbd "C-c SPC") nil))
(global-set-key (kbd "<f12>") (li (save-buffer) (open-current-file-with-vscode)))

(global-set-key (kbd "C-x M-m") mule-keymap)

(global-set-key (kbd "C-x m") 'execute-extended-command)
(global-set-key (kbd "C-x ,") 'vc-print-root-log)

(global-set-key (kbd "M-e") 'treemacs-dired-jump)
(global-set-key (kbd "M-s M-i") 'treemacs-dired-jump)
(global-set-key (kbd "<f8>") 'fei-switch-to-treemacs)

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
(global-set-key (kbd "M-s-k") 'my/delete-window-or-delete-frame)
(global-set-key (kbd "M-s-n") 'fei-scroll-up-line-other-window)
(global-set-key (kbd "M-s-p") 'fei-scroll-down-line-other-window)

(global-set-key "\M-Q" 'unfill-paragraph)
(global-set-key (kbd "C-S-b") 'bookmark-bmenu-list)

(global-set-key (kbd "C-M-l") (li (recenter-top-bottom '(4)))) ;was `reposition-window'

(global-set-key (kbd "C-S-k") 'kill-whole-line)
(autoload 'open-newline-below "open-newline" nil t)
(autoload 'open-newline-above "open-newline" nil t)
(global-set-key (kbd "C-S-o") 'open-newline-above)
(global-set-key (kbd "C-S-<return>") 'open-newline-below)
(global-set-key (kbd "C-S-m") 'open-newline-below)
(global-set-key (kbd "M-s c") 'fei-clock-count-down)

(with-eval-after-load 'cc-mode        ;注意不是 c++-mode 而是 cc-mode
  (define-key c-mode-base-map (kbd "<f5>") #'fei-g++-compile-and-run)
  (define-key c-mode-base-map (kbd "C-c C-c") #'fei-g++-compile-and-run) ;was `comment-region'
  (define-key c-mode-base-map (kbd "C-c C-r") #'quickrun-shell))

(setq embark-cycle-key ",")
(global-set-key (kbd "M-o ,") 'embark-act)
(global-set-key (kbd "M-.") 'embark-dwim)

(global-set-key (kbd "C-x C-u") 'jump-to-register)
(global-set-key (kbd "C-x C-p") 'goto-last-change)
(global-set-key (kbd "C-,") 'goto-last-change)
(global-set-key (kbd "C-M-,") 'marker-stack-pop)
(global-set-key (kbd "C-c C-o") 'rg-dwim)

(global-set-key (kbd "C-x M-l") 'switch-to-locked-buffer)
(global-set-key (kbd "C-x M-b") 'switch-to-same-major-mode-buffer)
(global-set-key (kbd "C-c b") 'project-switch-to-buffer)
(global-set-key (kbd "C-x C-b") 'fei-bs-show)
(define-key mode-line-buffer-identification-keymap [mode-line mouse-2] 'fei-bs-show)

(global-set-key (kbd "M-I") 'symbol-overlay-put)
(global-set-key (kbd "M-N") 'symbol-overlay-switch-forward)
(global-set-key (kbd "M-P") 'symbol-overlay-switch-backward)

(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h o") 'counsel-describe-symbol)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-h C-l") 'find-library)
(global-set-key (kbd "C-c o") 'consult-line)
(global-set-key (kbd "C-c i") 'consult-imenu)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c j") 'fei-counsel-recentf-pinyin)
(global-set-key (kbd "C-c J") 'fei/counsel-recentf-dir)
(global-set-key (kbd "C-x f") 'counsel-find-file)

(global-set-key (kbd "M-s n") 'fei-swiper-isearch)
(global-set-key (kbd "M-s p") 'fei-swiper-isearch-backward)

(global-set-key (kbd "C-c z") 'fei-compile)
(global-set-key (kbd "C-c u") 'fei-compile)

(with-eval-after-load 'org
  (global-set-key (kbd "C-c M-l") 'org-store-link)
  (global-set-key (kbd "C-c s") 'org-store-link))

(cond
 (*is-windows* (global-set-key (kbd "C-c l") 'counsel-locate))
 (t (global-set-key (kbd "C-c l") 'locate)
    (global-set-key (kbd "C-c L") 'counsel-locate)))

(win10
 (global-set-key (kbd "<scroll>") 'scroll-lock-mode)
 (with-eval-after-load 'ibuffer
   (define-key ibuffer-mode-map (kbd "<mouse-5>") 'fei/ibuffer-mouse-visit-buffer)))

(global-set-key (kbd "<insert>") 'nil)
(global-set-key (kbd "C-c t") 'trashed)

(global-set-key (kbd "M-s d") 'fei/olivetti-truncate)
(global-set-key (kbd "M-s M-d") 'fei/olivetti-truncate)
(global-set-key (kbd "M-s a") 'org-agenda-list) ;windows 平台 M-a 和微信的截图快捷键冲突
(global-set-key (kbd "M-a") 'org-agenda-list)
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "M-e") nil)
  (define-key matlab-mode-map (kbd "M-a") nil))

(global-set-key (kbd "C-:") 'pp-eval-expression)
(global-set-key (kbd "M-s h a") 'fei-highlight-region)

(global-set-key (kbd "<pause>") 'fei-org-time)
(global-set-key (kbd "<C-pause>") 'org-timer-set-timer)
(global-set-key (kbd "<M-pause>") 'fei-pomodoro-timer)
(global-set-key (kbd "ESC <pause>") 'fei-pomodoro-timer)

(global-set-key (kbd "M-s [") 'fei/load-zenburn)
(global-set-key (kbd "M-s ]") 'fei/disable-theme)

(global-set-key (kbd "C-c a") 'org-agenda-list)
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
(global-set-key (kbd "C-c n i") 'fei-org-capture-clock)
(global-set-key (kbd "C-c n w") 'fei-org-capture-WANT)
(global-set-key (kbd "C-c n W") 'fei-org-capture-goto-WANT)
(global-set-key (kbd "C-c n k") 'fei-org-capture-work)
(global-set-key (kbd "C-c n K") 'fei-org-capture-goto-work)
(global-set-key (kbd "C-c K") 'fei-consult-ripgrep-my-org)

(global-set-key (kbd "M-s r") 'rg-dwim-current-file)
(global-set-key (kbd "M-s R") 'rg-dwim-current-dir)
(global-set-key (kbd "M-s /") 'rg-project-all-files-no-ask)

(global-set-key (kbd "M-G") 'webjump)
(global-set-key (kbd "M-s C-m") 'browse-url)
(global-set-key (kbd "M-s M-w") 'engine/search-quword)
(global-set-key (kbd "M-s M-s") 'searchbox-search)
(global-set-key (kbd "M-s s") 'searchbox-search)
(global-set-key (kbd "M-s b") 'searchbox-switch-to-buffer)
(global-set-key (kbd "M-s M-b") 'searchbox-switch-to-buffer)

(global-set-key (kbd "C-M-;") 'fei/toggle-comment-line)
(global-set-key (kbd "C-c ;") 'comment-region)

(global-set-key (kbd "C-c <down>") 'fei/store-frameset)
(global-set-key (kbd "C-c <up>") 'fei/load-frameset)

(define-key tab-switcher-mode-map (kbd "q") 'tab-close)
(global-set-key (kbd "C-x t i") 'tab-bar-mode)
(global-set-key (kbd "C-x t l") 'tab-recent)
(add-hook 'tab-bar-mode-hook 'fei-tab-bar-define-key)
(defun fei-tab-bar-define-key ()
  (global-set-key (kbd "M-1") 'fei-select-tab)
  (global-set-key (kbd "M-2") 'fei-select-tab))

(global-set-key (kbd "C-x j") 'new-buffer)
(global-set-key (kbd "C-x M-j") 'new-buffer-same-major-mode)

(global-set-key (kbd "M-g d") 'dumb-jump-go)
(global-set-key (kbd "M-g b") 'dumb-jump-back)

(global-set-key (kbd "C-x l") 'popper-toggle-latest)
(global-set-key (kbd "C-x C-l") 'popper-toggle-type)

(global-set-key (kbd "C-x k") 'fei/kill-or-bury-buffer)
(global-set-key (kbd "C-x K") 'reopen-killed-file)

(global-set-key (kbd "C-x y") 'fei/yas-insert-snippet)
(global-set-key (kbd "C-x Y") 'yas-new-snippet)

(global-set-key (kbd "C-c <left>") 'tab-bar-history-back)
(global-set-key (kbd "C-c C-<left>") 'tab-bar-history-back)
(global-set-key (kbd "C-c <right>") 'tab-bar-history-forward)
(global-set-key (kbd "C-c C-<right>") 'tab-bar-history-forward)
(global-set-key (kbd "M-<left>") 'tab-bar-history-back)
(global-set-key (kbd "M-<right>") 'tab-bar-history-forward)

(autoload 'zygospore-toggle-delete-other-windows "zygospore" t nil)
(global-set-key (kbd "C-0") 'my/delete-window-or-delete-frame)
(global-set-key (kbd "C-x 0") 'my/delete-window-or-delete-frame)
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)
(autoload 'evil-move-window "evil" nil t)
(global-set-key (kbd "C-x w H") (li (evil-move-window 'left)))
(global-set-key (kbd "C-x w L") (li (evil-move-window 'right)))
(global-set-key (kbd "C-x w K") (li (evil-move-window 'above)))
(global-set-key (kbd "C-x w J") (li (evil-move-window 'below)))
(global-set-key (kbd "M-s i") 'fei/fit-window-to-buffer)
(global-set-key (kbd "M-s m") 'minimize-window)
(global-set-key (kbd "C-x 4 -") 'fit-window-to-buffer)
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
(global-set-key (kbd "C-x O") 'other-frame)

;; @REF: http://joaotavora.github.io/yasnippet/snippet-expansion.html
(with-eval-after-load 'yasnippet
  (global-set-key (kbd "C-M-y") 'yas-expand)
  (define-key yas-minor-mode-map (kbd "C-M-j") yas-maybe-expand)
  (define-key yas-minor-mode-map (kbd "C-j") yas-maybe-expand)
  (define-key yas-minor-mode-map (kbd "<tab>") yas-maybe-expand)
  (define-key yas-minor-mode-map (kbd "TAB") yas-maybe-expand)
  (define-key yas-minor-mode-map (kbd "M-i") yas-maybe-expand) ;注意：`yas-maybe-expand' 是一个 variable
  (define-key yas-keymap (kbd "M-i") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "C-j") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "M-I") 'yas-prev-field))

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
  (define-key LaTeX-mode-map (kbd "C-c C-i") 'fei-buffer-indent) ;was `TeX-goto-info-page'
  (define-key LaTeX-mode-map (kbd "C-r") 'fei-swiper-isearch-backward))

(autoload 'vertico-multiform-posframe "vertico-posframe" nil t)
(define-key vertico-multiform-map (kbd "M-P") 'vertico-multiform-posframe)
(define-key vertico-map (kbd "C-M-j") 'vertico-exit-input)
(define-key vertico-map (kbd "C-'") 'vertico-quick-exit)
(define-key vertico-map (kbd "M-o") 'embark-act)
(define-key vertico-map (kbd "C-c C-o") 'embark-collect)
(define-key vertico-map (kbd "C-c C-l") 'embark-live)

(win10
 (with-eval-after-load 'python
   ;; simple complie for python
   (define-key python-mode-map (kbd "<f5>") 'fei-python-run)
   (define-key python-mode-map (kbd "<C-f5>") (li (fei-python-run 1)))))

(fei-define-key-with-map isearch-mode-map
  '(("C-g" . isearch-cancel)
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("<C-return>" . prot-search-isearch-other-end)
    ("C-'" . avy-isearch)
    ("C-c k" . fei-counsel-rg-from-isearch)
    ("M-s r" . rg-isearch-project)
    ("C-c C-o" . fei/isearch-occur)))

(with-eval-after-load 'term (define-key term-raw-map (kbd "M-s") 'nil))
(with-eval-after-load 'vterm (define-key vterm-mode-map (kbd "M-s") nil))
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

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "<f5>") (li (compile (concat "python3 " (buffer-file-name)))))
  (define-key python-mode-map (kbd "C-c C-k") 'python-shell-send-buffer)
  (define-key python-mode-map (kbd "C-c C-c") 'fei-python-compile-and-run))

;;; Pyim
(with-eval-after-load 'pyim
  (define-key pyim-mode-map (kbd "C-h") 'pyim-delete-backward-char)
  (define-key pyim-mode-map (kbd "<escape>") 'pyim-quit-clear)
  (define-key pyim-mode-map (kbd "C-v") 'pyim-next-page)
  (define-key pyim-mode-map (kbd "M-v") 'pyim-previous-page)
  (define-key pyim-mode-map (kbd "M-1") (li (pyim-select-subword-by-number 1)))
  (define-key pyim-mode-map (kbd "M-2") (li (pyim-select-subword-by-number 2)))
  (define-key pyim-mode-map (kbd "M-3") (li (pyim-select-subword-by-number 3)))
  (define-key pyim-mode-map (kbd "M-4") (li (pyim-select-subword-by-number 4))))

(define-key prog-mode-map (kbd "C-c TAB") 'fei-buffer-indent)

;; 翻译
(global-set-key (kbd "<menu>") 'google-translate-at-point)
(global-set-key (kbd "C-h y") 'google-translate-query-translate)
(global-set-key (kbd "C-c y") 'google-translate-at-point)

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
  (define-key treemacs-mode-map (kbd "K") 'fei-treemacs-move-to-right))

(linux (global-set-key (kbd "C-c m") 'counsel-linux-app))
(win10 (global-set-key (kbd "C-c m") 'app-launcher-run-app))
(global-set-key (kbd "C-c p") 'proced)

(global-set-key (kbd "s-l") 'lsp)
(setq lsp-keymap-prefix "s-l")

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "C-c M-o") 'obsidian-follow-link-at-point)
  (define-key markdown-mode-map (kbd "C-x M-o") 'open-current-file-with-obsidian)
  (define-key markdown-mode-map (kbd "<M-up>") 'markdown-move-up)
  (define-key markdown-mode-map (kbd "<M-down>") 'markdown-move-down))

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "<C-right>") 'sp-forward-slurp-sexp)
(define-key emacs-lisp-mode-map (kbd "<C-left>") 'sp-forward-barf-sexp)
(define-key emacs-lisp-mode-map (kbd "M-U") 'sp-splice-sexp)
(define-key emacs-lisp-mode-map (kbd "M-q") 'sp-indent-defun)
(define-key lisp-interaction-mode-map (kbd "C-c C-c") 'eval-buffer)
(define-key lisp-interaction-mode-map (kbd "C-c =") 'macrostep-expand)
(define-key lisp-interaction-mode-map (kbd "C-c C-e") 'pp-eval-last-sexp)
(define-key lisp-interaction-mode-map (kbd "C-c M-e") 'pp-macroexpand-last-sexp)
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

(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "M-s") nil)
  (define-key matlab-mode-map (kbd "M-j") nil))

;;; Dired
(with-eval-after-load 'dired
  (define-key dired-mode-map [mouse-3] 'fei-dired-mouse-find-file-externally)
  (define-key dired-mode-map [mouse-2] 'dired-mouse-find-file)
  (linux (define-key dired-mode-map [mouse-8] 'dired-up-directory))
  (win10 (define-key dired-mode-map [mouse-4] 'dired-up-directory))

  (fei-define-key-with-map dired-mode-map
    `(("b" . dired-up-directory)
      ("K" . dired-do-kill-lines)
      ("C-k" . dired-kill-subdir)
      ("<left>" . dired-up-directory)
      ("<right>" . dired-find-file)
      ("h" . dired-up-directory)
      ("j" . dired-next-line)
      ("k" . dired-previous-line)
      ("l" . dired-find-file)
      ("J" . fei-counsel-fd-file-jump)
      ("e" . wdired-change-to-wdired-mode)
      ("," . browse-url-of-dired-file)
      ("." . fei-dired-toggle-hidden)
      ("_" . dired-create-empty-file)
      ("SPC" . find-file)
      ("z" . fei-compile)
      ))

  (define-key dired-mode-map (kbd "M-d") 'fei/olivetti-truncate)
  (define-key dired-mode-map (kbd ";f") 'dired-jump-following-symlinks)
  (define-key dired-mode-map (kbd ";c") 'dired-ranger-copy)
  (define-key dired-mode-map (kbd ";v") 'dired-ranger-paste)
  (define-key dired-mode-map (kbd ";V") 'dired-ranger-move)
  (define-key dired-mode-map (kbd ";d") 'dired-duplicate-this-file)
  (define-key dired-mode-map (kbd ";w") 'file-manager-here))

;;; Dirvish
(with-eval-after-load 'dirvish
  (fei-define-key-with-map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
    '(("f"   . dirvish-file-info-menu)
      ;; ("a"   . dirvish-quick-access)
      ("y"   . dirvish-yank-menu)
      ("N"   . dirvish-narrow)
      ("/"   . dirvish-narrow)
      ("^"   . dirvish-history-last)
      ("H"   . dirvish-history-jump)	; remapped `describe-mode'
      ("s"   . dirvish-quicksort)	; remapped `dired-sort-toggle-or-edit'
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
      ("M-w" . company-show-location)
      ("M-s" . company-filter-candidates)
      ("M-/" . company-other-backend)
      ("M-g" . company-abort)
      ("C-w" . nil)))
  (define-key company-search-map (kbd "M-n") 'company-select-next)
  (define-key company-search-map (kbd "M-p") 'company-select-previous))

;;; VC
(with-eval-after-load 'vc-dir
  (let ((map vc-dir-mode-map))
    (define-key map (kbd "z") 'fei-compile)
    (define-key map (kbd "e") 'fei-eshell-cd-here)
    (define-key map (kbd "j") 'project-find-file)
    (define-key map (kbd "!") 'shell-command)
    (define-key map (kbd "&") 'async-shell-command)))

(with-eval-after-load 'vc-git
  (define-key vc-git-log-view-mode-map (kbd "z") 'fei-compile)
  (define-key vc-git-log-view-mode-map (kbd "s") 'fei-vc-dired-jump))

(with-eval-after-load 'recentf
  (define-key recentf-dialog-mode-map (kbd "SPC") 'fei/swiper)
  (define-key recentf-dialog-mode-map (kbd "e") 'recentf-edit-list)
  (define-key recentf-dialog-mode-map (kbd "g") 'recentf-open-files))

(with-eval-after-load 'reftex-toc
  (define-key reftex-toc-mode-map (kbd "v") 'reftex-toc-mode-hor-or-ver))

(with-eval-after-load 'web-mode
  (define-key web-mode-map (kbd "C-c C-v") 'browse-url-of-buffer))

(provide 'init-key)
