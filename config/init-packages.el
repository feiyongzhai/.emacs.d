;; init-packages.el == configs for site packages

(require 'fei-funcs)

;; alarm-clock
(global-set-key (kbd "M-s a s") 'alarm-clock-set)
(global-set-key (kbd "M-s a l") 'alarm-clock-list-view)

;; separedit
(define-key prog-mode-map        (kbd "C-c '") #'separedit)
(define-key minibuffer-local-map (kbd "C-c '") #'separedit)

;; imenu-list
(setq imenu-list-focus-after-activation t)

;; trashed
(global-set-key (kbd "C-c T") 'trashed)

;; feebleline
(add-to-list 'load-path "~/.emacs.d/extensions/feebleline")
(require 'feebleline)

;; tldr
(global-set-key (kbd "C-c M") 'man)
(global-set-key (kbd "C-c M-m") 'tldr)

;; Symbol-overlay
(global-set-key (kbd "M-I") 'symbol-overlay-put)
(with-eval-after-load 'symbol-overlay
  (define-key symbol-overlay-map (kbd "o") 'fei-occur-for-mouse))

;; Consult
(setq register-preview-delay 0
      register-preview-function #'consult-register-format)

(global-set-key (kbd "C-c J") 'consult-register-store)
(global-set-key (kbd "C-c j") 'consult-register-load)

;; minimap
(setq minimap-window-location 'right)

;; scratch
(global-set-key (kbd "C-c s") 'scratch)

;; youdao-dictionary
(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input))
(global-set-key (kbd "<menu>") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "C-h y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-c y") 'fei-youdao-at-point)

;; EAF
(with-eval-after-load 'eaf-browser
  (eaf-bind-key nil "M-s" eaf-browser-keybinding)
  (eaf-bind-key nil "M-S" eaf-browser-keybinding)
  )

;; Helpful
(global-set-key (kbd "C-h o") 'helpful-symbol)
(global-set-key (kbd "C-h O") 'describe-symbol)
(global-set-key (kbd "C-h k") 'helpful-key)

;; highlight-indent-guides copied from lazycat
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-auto-enabled t)
(setq highlight-indent-guides-responsive 'top)

;; deadgrep
(global-set-key (kbd "M-s d") 'deadgrep)

;; keyfreq
(keyfreq-mode)
(keyfreq-autosave-mode)
(setq keyfreq-file "~/.emacs.d/.emacs.keyfreq")

;; helm-org-rifle 搜索的 org 文件需要打开。不过 org-agenda 会默认打开
;; 一些 org 文件，所以配合起来使用也能接受
(global-set-key (kbd "C-x c o") 'helm-org-rifle)
(with-eval-after-load 'helm
  (global-set-key (kbd "C-x c o") 'helm-org-rifle))

(global-set-key (kbd "C-x H b") 'helm-chrome-bookmarks)
(global-set-key (kbd "C-x M-h b") 'helm-chrome-bookmarks)


;; rg
(global-set-key (kbd "M-s r") 'rg-project)
(define-key isearch-mode-map (kbd "M-s r") 'rg-isearch-project)

;; grep-dired
(add-to-list 'load-path "~/.emacs.d/extensions/grep-dired")
(autoload 'grep-dired "grep-dired" nil t) ;emacs 自带了一个相似的命令 `find-name-dired'

(provide 'init-packages)
