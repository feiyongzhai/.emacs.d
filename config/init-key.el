(require 'init-thing-edit)

(define-key transient-map (kbd "<escape>") 'transient-quit-one)

;; @REF: http://joaotavora.github.io/yasnippet/snippet-expansion.html
(with-eval-after-load 'yasnippet
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "M-i") yas-maybe-expand) ;注意：`yas-maybe-expand' 是一个 variable
  (define-key yas-keymap (kbd "M-n") 'yas-next-field)
  (define-key yas-keymap (kbd "M-p") 'yas-prev-field)
  (define-key yas-keymap (kbd "M-i") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "M-I") 'yas-prev-field)
  )

(global-set-key (kbd "C-|") 'fei-rime-force-enable)

(define-key global-map "\M-Q" 'unfill-paragraph)

(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
(global-set-key (kbd "M-s TAB") 'window-toggle-side-windows)

(define-key lisp-interaction-mode-map (kbd "C-c =") 'macrostep-expand)
(define-key lisp-interaction-mode-map (kbd "C-c C-e") 'pp-macroexpand-last-sexp)
(define-key emacs-lisp-mode-map (kbd "C-c =") 'macrostep-expand)
(define-key emacs-lisp-mode-map (kbd "C-c C-e") 'pp-macroexpand-last-sexp)

(global-set-key (kbd "M-s C-n") 'popper-cycle)
(global-set-key (kbd "M-s M-n") 'popper-toggle-latest)
(global-set-key (kbd "M-s C-p") 'popper-toggle-type)

(define-key global-map (kbd "M-m") 'store-register-dwim)
(define-key global-map (kbd "M-'") 'use-register-dwim)
(autoload 'open-newline-below "open-newline" nil t)
(autoload 'open-newline-above "open-newline" nil t)
(global-set-key (kbd "C-<return>") 'open-newline-below)
(global-set-key (kbd "C-o") 'open-newline-above)
(global-set-key (kbd "C-S-<return>") 'open-newline-above)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
(global-set-key (kbd "M-]") 'forward-paragraph)
(global-set-key (kbd "M-[") 'backward-paragraph)
(global-set-key (kbd "C-z") 'undo-only)
(global-set-key (kbd "C-S-z") 'undo-redo)
(global-set-key (kbd "M-s c") 'fei-clock-count-down)
(define-key mode-line-buffer-identification-keymap [mode-line mouse-2] 'ibuffer)
(global-set-key (kbd "M-s =") 'calculator)
(global-set-key (kbd "C-c b") 'project-switch-to-buffer)
(global-set-key (kbd "M-O") 'embark-act)
(global-set-key (kbd "M-.") 'embark-dwim)

(global-set-key (kbd "C-=") 'text-scale-adjust)
(global-set-key (kbd "C--") 'text-scale-adjust)

(global-set-key (kbd "<f2>") 'fei-compile) ;笔记本上 C-M-z 不好按
(global-set-key (kbd "C-x y") 'yas-insert-snippet)
(global-set-key (kbd "C-x Y") 'yas-new-snippet)

(global-set-key (kbd "M-s m") 'marker-stack-push)
(global-set-key (kbd "M-s u") 'marker-stack-pop)

(global-set-key (kbd "C-x w H") (li (evil-move-window 'left)))
(global-set-key (kbd "C-x w L") (li (evil-move-window 'right)))
(global-set-key (kbd "C-x w K") (li (evil-move-window 'above)))
(global-set-key (kbd "C-x w J") (li (evil-move-window 'below)))
(global-set-key (kbd "C-x 4 -") 'fit-window-to-buffer)
(global-set-key (kbd "C-x 5 -") 'fit-frame-to-buffer)
(global-set-key (kbd "C-x _") 'adjust-frame-by-longest-line)

(autoload 'evil-move-window "evil" nil t)
(global-set-key (kbd "C-x w h") 'windmove-left)
(global-set-key (kbd "C-x w l") 'windmove-right)
(global-set-key (kbd "C-x w j") 'windmove-down)
(global-set-key (kbd "C-x w k") 'windmove-up)
(global-set-key (kbd "C-x w s") 'window-swap-states)
(global-set-key (kbd "C-x w M") 'maximize-window)
(global-set-key (kbd "C-x w m") 'minimize-window)
(global-set-key (kbd "C-x w u") 'transient-winner-undo)
(global-set-key (kbd "C-x o") 'ace-window) ;ace-window 可以 跳到 side-windows 上面，但是 other-window 不行
(global-set-key (kbd "C-x O") 'other-frame)
(global-set-key (kbd "M-<left>") 'winner-undo)
(global-set-key (kbd "C-x C-/") 'winner-undo)
(global-set-key (kbd "C-x C-?") 'winner-redo)
(global-set-key (kbd "C-v") 'my/scroll-up-half)
(global-set-key (kbd "M-v") 'my/scroll-down-half)

(global-set-key (kbd "M-s q") 'quit-window)
(global-set-key (kbd "M-s M-q") 'unbury-buffer)

(global-set-key (kbd "C-x C-p") (li (set-mark-command 4)))

(global-set-key (kbd "M-k") 'kill-current-buffer)
(global-set-key (kbd "M-K") 'reopen-killed-file)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x K") 'reopen-killed-file)

(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)

(global-set-key (kbd "C-x M-n") 'transient-tab-line-switch-to-next-tab)
(global-set-key (kbd "C-x M-p") 'transient-tab-line-switch-to-prev-tab)

(define-key vertico-map (kbd "C-M-j") 'vertico-exit-input)
(define-key vertico-map (kbd "C-'") 'vertico-quick-exit)
(define-key vertico-map (kbd "M-o") 'embark-act)


;; win10
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
                      "cmd" "/c" "start" "cmd" "/k" "python" (buffer-file-name))))
   ))

(global-set-key (kbd "M-s k") 'shell)
(global-set-key (kbd "M-s M-k") 'shell)



;; (global-set-key (kbd "M-J") (li (w32-set-ime-open-status nil)))

(global-set-key (kbd "C-c K") 'fei-consult-ripgrep-my-org)

(define-key vertico-map "\M-V" #'vertico-multiform-vertical)
(define-key vertico-map "\M-G" #'vertico-multiform-grid)
(define-key vertico-map "\M-F" #'vertico-multiform-flat)
(define-key vertico-map "\M-R" #'vertico-multiform-reverse)
(define-key vertico-map "\M-U" #'vertico-multiform-unobtrusive)

;; 在这个操作之后，再用鼠标左键选 tab-line 会出现标签跳动的情况
;; (global-set-key (kbd "<tab-line> <C-mouse-3>") 'tab-line-kill-this-buffer)

(global-set-key (kbd "C-x <left>") 'tab-line-switch-to-prev-tab)
(global-set-key (kbd "C-x <right>") 'tab-line-switch-to-next-tab)
;; (define-key tab-line-tab-map [tab-line down-mouse-3] 'tab-line-close-tab) ;tab-line-tab-context-menu

(fei-define-key-with-map isearch-mode-map
  '(("M-g" . isearch-cancel)
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("<C-return>" . prot-search-isearch-other-end)
    ("C-'" . avy-isearch)
    ("M-'" . avy-isearch)	 ;gnome-terminal 读不到 C-',用这个代替
    ("C-c k" . fei-counsel-rg-from-isearch)
    ("M-s r" . rg-isearch-project)
    ))

(with-eval-after-load 'ctrlf
  (define-key ctrlf-minibuffer-mode-map (kbd "C-p") 'ctrlf-previous-match)
  (define-key ctrlf-minibuffer-mode-map (kbd "C-n") 'ctrlf-next-match)
  )

(global-set-key (kbd "M-s z") 'shell)

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
  (define-key term-mode-map (kbd "M-`") 'nil)
  )

(global-set-key [remap tab-bar-select-tab] 'fei-select-tab)
(global-set-key (kbd "M-0") 'tab-close)
(global-set-key (kbd "M--") 'tab-undo)
(global-set-key (kbd "M-`") 'tab-recent)
(global-set-key (kbd "C-x t i") 'tab-bar-mode)
(global-set-key (kbd "C-x t l") 'tab-recent)
(global-set-key (kbd "C-x t h") 'fei-switch-current-buffer-to-new-tab)

(define-key tab-switcher-mode-map (kbd "q") 'tab-close)

(with-eval-after-load 'term
  (define-key term-raw-map (kbd "M-s") 'nil))

(global-set-key (kbd "M-s C-m") 'browse-url)
(global-set-key (kbd "M-G") 'fei-search)
(global-set-key (kbd "M-s M-w") 'fei-search)
(global-set-key (kbd "M-s M-s") 'fei-search)
(global-set-key (kbd "M-s s") 'fei-search)
(global-set-key (kbd "M-S") 'fei-search)

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "<f5>") (li (compile (concat "python3 " (buffer-file-name))))))

(define-key isearch-mode-map (kbd "M-j") 'isearch-edit-string)

(setq rime-translate-keybindings
      '("C-f" "C-b" "C-n" "C-p" "C-g" "C-h" "C-e" "C-v" "M-v" "M-f" "M-b"
	"C-`" "C-d" "C-k" "C-y" "<tab>" "C-a" "C-u"
	"<left>" "<right>" "<up>" "<down>" "<prior>" "<next>" "<delete>"))

(with-eval-after-load 'rime
  (global-set-key (kbd "C-`") 'rime-select-schema)
  (define-key rime-active-mode-map (kbd "C-i") 'rime-inline-ascii)
  (define-key rime-active-mode-map (kbd "M-h") 'rime--return)
  (define-key rime-active-mode-map (kbd "C-j") 'rime--return)
  )

(global-set-key (kbd "M-j") 'fei-rime-force-enable)
(global-set-key (kbd "M-J") (li (deactivate-input-method)))


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
  (define-key pyim-mode-map (kbd "M-4") (li (pyim-select-subword-by-number 4)))
  )


(define-key prog-mode-map (kbd "C-c RET") 'er/expand-region)
(define-key prog-mode-map (kbd "C-c m") 'er/expand-region)
(define-key prog-mode-map (kbd "C-c TAB") 'fei-buffer-indent)
(define-key prog-mode-map (kbd "C-c C-l") 'vc-print-root-log)
(define-key prog-mode-map (kbd "C-c C-s") 'fei-vc-dired-jump)
(define-key prog-mode-map (kbd "M-RET") 'hs-toggle-hiding)
(define-key prog-mode-map (kbd "M-S-<return>") 'hs-hide-all)

(global-set-key (kbd "C-9") 'jetbrains-open-buffer-file)
(global-set-key (kbd "C-M-9") 'jetbrains-create-dir-local-file)

(global-set-key (kbd "M-s r") 'rg-dwim-current-file)
(global-set-key (kbd "M-s R") 'rg-dwim-current-dir)
(global-set-key (kbd "M-s M-r") 'rg-project-all-files-no-ask)
(define-key isearch-mode-map (kbd "M-s r") 'rg-isearch-project)

;;; Helpful
;; (global-set-key (kbd "C-h o") 'helpful-symbol)
;; (global-set-key (kbd "C-h O") 'describe-symbol)
;; (global-set-key (kbd "C-h k") 'helpful-key)

;;; youdao-dictionary
(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input)
  (define-key youdao-dictionary-mode-map (kbd "d") 'fei-quword-at-point))
(global-set-key (kbd "<menu>") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "C-h y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-M-y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-c y") 'fei-youdao-at-point)

(global-set-key (kbd "M-I") 'symbol-overlay-put)
(global-set-key (kbd "M-N") 'symbol-overlay-switch-forward)
(global-set-key (kbd "M-P") 'symbol-overlay-switch-backward)
(with-eval-after-load 'symbol-overlay
  (define-key symbol-overlay-map (kbd "o") 'fei-occur-at-point)
  (define-key symbol-overlay-map (kbd "l") 'recenter-top-bottom)
  (define-key symbol-overlay-map (kbd "O") 'symbol-overlay-find-at-point-project)
  (define-key symbol-overlay-map (kbd "M-r") 'rg-dwim-current-dir)
  )

;; 快捷键只是用户习惯

(global-set-key (kbd "<pause>") 'fei-org-time)
(global-set-key (kbd "<C-pause>") 'org-timer-set-timer)
(global-set-key (kbd "<M-pause>") 'fei-pomodoro-timer)
(global-set-key (kbd "ESC <pause>") 'fei-pomodoro-timer)
(global-set-key (kbd "C-S-y") 'org-download-clipboard)

(global-set-key (kbd "C-c a") (li (org-agenda nil "a")))
(global-set-key (kbd "C-c A") 'org-agenda)
(global-set-key (kbd "C-c c") 'fei-org-capture-TODO)
(global-set-key (kbd "C-c C") 'fei-org-capture)
(global-set-key (kbd "C-c n t") 'fei-org-capture-TODO)
(global-set-key (kbd "C-c n n") 'fei-org-capture-note)
(global-set-key (kbd "C-c n N") 'fei-org-capture-goto-note)
(global-set-key (kbd "C-c n j") 'fei-org-capture-private)
(global-set-key (kbd "C-c n J") 'fei-org-capture-goto-private)
(global-set-key (kbd "C-c n s") 'fei-org-capture-SAR)
(global-set-key (kbd "C-c n S") 'fei-org-capture-goto-SAR)
(global-set-key (kbd "C-c n w") 'fei-org-capture-WANT)
(global-set-key (kbd "C-c n W") 'fei-org-capture-goto-WANT)
(global-set-key (kbd "C-c n k") 'fei-org-capture-Research)
(global-set-key (kbd "C-c n K") 'fei-org-capture-goto-Research)

(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "k") 'fei-org-capture)
  (define-key org-agenda-mode-map (kbd "K") 'org-agenda-capture))

(global-set-key (kbd "M-s M-p") 'fei-switch-to-treemacs)
(global-set-key (kbd "<f8>") 'fei-switch-to-treemacs)

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "J") 'fei-treemacs-move-to-left)
  (define-key treemacs-mode-map (kbd "K") 'fei-treemacs-move-to-right)
  (define-key treemacs-mode-map (kbd "v") 'fei-vc-dired-jump)
  (define-key treemacs-mode-map (kbd "G") 'magit)
  )

(global-set-key (kbd "M-s a s") 'alarm-clock-set)
(global-set-key (kbd "M-s a l") 'alarm-clock-list-view)

(define-key prog-mode-map        (kbd "C-c '") #'separedit)
(define-key minibuffer-local-map (kbd "C-c '") #'separedit)

(global-set-key (kbd "C-c T") 'trashed)

(global-set-key (kbd "M-s h a") 'fei-highlight-region)
(global-set-key (kbd "M-s M-1") 'highlight-symbol-at-point)
(global-set-key (kbd "M-s 1") 'highlight-symbol-at-point)
(global-set-key (kbd "M-s M-2") 'fei-unhighlight-symbol-at-point)
(global-set-key (kbd "M-s 2") 'fei-unhighlight-symbol-at-point)


(when *is-linux*
  (global-set-key (kbd "C-c w") 'counsel-wmctrl)
  (global-set-key (kbd "C-c m") 'counsel-linux-app)
  (global-set-key (kbd "C-c p") 'proced)
  )

(global-set-key (kbd "M-s l") 'counsel-load-theme)



(fei-define-key-with-map global-map
  '(
    ("C-h f" . counsel-describe-function)
    ("C-h o" . counsel-describe-symbol)
    ("C-h v" . counsel-describe-variable)
    ("C-h C-l" . counsel-find-library)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c j" . fei-counsel-recentf-pinyin)
    ("C-x f" . counsel-find-file)
    ("M-x" . counsel-M-x)
    ("M-s y" . counsel-yank-pop)
    ))


(cond
 (*is-windows* (global-set-key (kbd "C-c l") 'counsel-locate))
 (t (global-set-key (kbd "C-c l") 'locate)
    (global-set-key (kbd "C-c L") 'counsel-locate)
    ))

(with-eval-after-load 'ivy
  (define-key ivy-minibuffer-map (kbd "M-j") 'fei-rime-force-enable)
  )

(global-set-key (kbd "M-s n") 'fei-swiper-isearch)
(global-set-key (kbd "M-s p") 'fei-swiper-isearch-backward)

(global-set-key (kbd "C-M-z") 'fei-compile)

(global-set-key (kbd "M-s k") 'fei-ansi-term)
(global-set-key (kbd "M-s M-k") 'fei-term-cd-here)

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
      ("M-s @" . markdown-insert-header-setext-2)
      ("<M-up>" . markdown-move-up)
      ("<M-down>" . markdown-move-down)
      )))


(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "M-s") nil)
  (define-key matlab-mode-map (kbd "M-j") nil)
  )

(with-eval-after-load 'org
  (global-set-key (kbd "C-c M-l") 'org-store-link)
  (global-set-key (kbd "C-c s") 'org-store-link)
  )

(define-key emacs-lisp-mode-map (kbd "<C-right>") 'sp-forward-slurp-sexp)
(define-key emacs-lisp-mode-map (kbd "<C-left>") 'sp-forward-barf-sexp)
(define-key emacs-lisp-mode-map (kbd "M-U") 'sp-splice-sexp)
(define-key emacs-lisp-mode-map (kbd "M-q") 'sp-indent-defun)


;;; Ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer-jump)

(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line) ;was `ibuffer-jump-to-buffer'
  (define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line) ;was `ibuffer-kill-line'
  (define-key ibuffer-mode-map (kbd "_") 'fei-remove-ibuffer-tmp-hide-regexps)
  (define-key ibuffer-mode-map (kbd "a") 'ibuffer-toggle-all)
  (define-key ibuffer-mode-map (kbd "i") 'ibuffer-toggle-emacs)
  (define-key ibuffer-mode-map (kbd "c") 'ibuffer-toggle-notes)
  (define-key ibuffer-mode-map (kbd "SPC") 'switch-to-buffer)
  )



(with-eval-after-load 'emmet-mode
  (define-key emmet-mode-keymap (kbd "C-M-j") 'emmet-expand-yas))

(with-eval-after-load 'dart-mode
  (define-key dart-mode-map (kbd "C-M-x") #'flutter-run-or-hot-reload))

(global-set-key (kbd "C-x M-b") 'switch-to-same-major-mode-buffer)
(global-set-key (kbd "C-c 1") 'fei-frame-one-line)

;; Misc
(global-set-key (kbd "C-M-=") 'calculator)
(global-set-key (kbd "<f7>") 'fei-ff-find-other-file-pdf-org)
(global-set-key (kbd "<f5>") 'recompile)  ;<f5> 笔记本电脑更好按
(global-set-key (kbd "<f9>") 'recompile)  ;<f9> 外置的机械键盘更好按

(global-set-key (kbd "C-x F") 'set-fill-column)

(global-set-key (kbd "C-c H") 'fei-pulse-current-line)

(global-set-key (kbd "M-s j") 'eshell)	;many times eshell is enough
(global-set-key (kbd "M-s M-j") 'fei-eshell-cd-here)
(global-set-key (kbd "C-x r p") 'replace-string)

(global-set-key (kbd "C-c /") 'webjump)
(global-set-key (kbd "C-h C-y") 'engine/search-quword)
(global-set-key (kbd "C-M-<return>") 'engine/search-google)

(with-eval-after-load 'elfeed
  (define-key elfeed-search-mode-map (kbd "f") 'elfeed-search-show-entry))

(global-set-key (kbd "C-x n c") 'narrow-to-region-indirect)

;;; @REF: https://karthinks.com/software/batteries-included-with-emacs/
(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "C-x C-u") nil)

(global-set-key (kbd "C-x u") 'vundo)
(global-set-key (kbd "C-/") 'undo-only)	;undo-only 不会被打断

(global-set-key (kbd "C-s-n") 'fei-scroll-up-line)
(global-set-key (kbd "M-s-n") 'fei-scroll-up-line-other-window)
(global-set-key (kbd "C-s-p") 'fei-scroll-down-line)
(global-set-key (kbd "M-s-p") 'fei-scroll-down-line-other-window)

(autoload 'move-text-up "move-text" nil t)
(autoload 'move-text-down "move-text" nil t)
(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)

(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "M-s ;") 'iedit-mode)

(global-set-key (kbd "C-0") 'delete-window)
(global-set-key (kbd "C-1") 'zygospore-toggle-delete-other-windows)
(global-set-key (kbd "C-2") (li (split-window-below) (other-window 1)))
(global-set-key (kbd "C-3") (li (split-window-right) (other-window 1)))

(global-set-key (kbd "C-x i") 'insert-char)
(global-set-key (kbd "C-x I") 'emoji-search)
(global-set-key (kbd "C-x M-i") 'all-the-icons-insert)

(global-set-key (kbd "C-c o o") 'counsel-outline)
(global-set-key (kbd "C-c i") 'counsel-imenu)

(global-set-key (kbd "C-x u") 'transient-undo)
(global-set-key (kbd "C-x l") 'fei-meow-last-buffer)
(global-set-key (kbd "C-x C-l") 'fei-meow-last-buffer)

(global-set-key [remap goto-line] 'avy-goto-line)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;; Navigate
(global-set-key (kbd "C-c b") 'project-switch-to-buffer)

(global-set-key (kbd "M-p") 'goto-last-change)
(global-set-key (kbd "M-n") 'goto-last-change-reverse)

;;; Highlight
(global-set-key (kbd "M-s M-h") 'highlight-symbol-at-point)

(global-set-key (kbd "C-'") 'avy-resume)

(global-set-key (kbd "M-s M-o") 'multi-occur-in-this-mode)
(global-set-key (kbd "M-s O") 'fei-occur-at-point)

;;; Kill/Yank
(global-set-key (kbd "M-S-<down>") 'fei-duplicate-line-or-region)
(global-set-key (kbd "M-L") 'fei-duplicate-line-or-region)
(global-set-key (kbd "C-w") 'backward-kill-word-or-region)
(global-set-key (kbd "M-Z") 'zap-up-to-char)
(global-set-key (kbd "M-r") 'replace-string)
(global-set-key (kbd "M-R") 'replace-regexp)

(global-set-key (kbd "S-SPC") 'set-mark-command)
(global-set-key (kbd "C-M-w") 'set-mark-command) ;was `append-next-kill'
(global-set-key (kbd "<f12>") (li (save-buffer) (open-current-file-with-vscode)))

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

(global-set-key (kbd "M-,") 'my/backward-forward-previous-location)
(global-set-key (kbd "C-M-,") 'my/backward-forward-next-location)

(global-set-key (kbd "M-s M-i") 'dirvish-side)

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
      ("`" . fei-eshell-cd-here)
      ("_" . dired-create-empty-file)
      ("SPC" . find-file)
      ("z" . fei-compile)
      ))

  (define-key dired-mode-map (kbd ";f") 'dired-jump-following-symlinks)
  (define-key dired-mode-map (kbd ";c") 'dired-ranger-copy)
  (define-key dired-mode-map (kbd ";v") 'dired-ranger-paste)
  (define-key dired-mode-map (kbd ";V") 'dired-ranger-move)
  (define-key dired-mode-map (kbd ";d") 'dired-duplicate-this-file)
  (define-key dired-mode-map (kbd ";g") 'fei-git-status)
  (define-key dired-mode-map (kbd ";s") 'fei-vc-dired-jump)
  (define-key dired-mode-map (kbd ";w") 'file-manager-here)
  (define-key dired-mode-map (kbd ";l") 'vc-print-root-log)
  )

;;; Dirvish
(with-eval-after-load 'dirvish
  (fei-define-key-with-map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
    '(("a"   . dirvish-quick-access)
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
      ("M-e" . dirvish-emerge-menu)
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
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))

(with-eval-after-load 'dired-x
  (define-key dired-mode-map (kbd "M-G") nil))

;;; Compile
(with-eval-after-load 'compile
  (define-key compilation-mode-map (kbd "d") 'fei-cmp-change-dire-recompile)
  (define-key compilation-mode-map (kbd "e") 'compile)
  (define-key compilation-mode-map (kbd "r") 'compile)
  )

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
  (add-to-list 'company-transformers 'delete-dups)
  )


;;; Help
(global-set-key (kbd "C-h M-c") 'describe-char)
(global-set-key (kbd "C-h M-f") 'describe-face)
(global-set-key (kbd "C-h M-k") 'describe-keymap)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-i") 'info-display-manual)


;;; VC
(linux (global-set-key (kbd "C-x g") 'magit-status))
(win10 (global-set-key (kbd "C-x g") 'fei-vc-dired-jump))
(global-set-key (kbd "C-x v j") 'fei-vc-dired-jump)
(with-eval-after-load 'vc-dir
  (define-key vc-dir-mode-map (kbd "z") 'fei-compile)
  (define-key vc-dir-mode-map (kbd "e") 'fei-eshell-cd-here) ;default is `vc-find-file'
  (define-key vc-dir-mode-map (kbd "j") 'project-find-file)
  (define-key vc-dir-mode-map (kbd "!") 'shell-command)
  (define-key vc-dir-mode-map (kbd "&") 'async-shell-command)
  )

(with-eval-after-load 'vc-git
  (define-key vc-git-log-edit-mode-map (kbd "C-c C-l") 'vc-print-root-log))

(provide 'init-key)
