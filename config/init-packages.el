;; init-packages.el == configs for site packages

(require 'fei-funcs)

(require 'cal-china-x)
(setq calendar-week-start-day 1)

;; Treemacs
(setq treemacs-position 'right)
(global-set-key (kbd "<f8>") 'fei-switch-to-treemacs)
(global-set-key (kbd "<C-f8>") 'speedbar)

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "J") 'fei-treemacs-move-to-left)
  (define-key treemacs-mode-map (kbd "K") 'fei-treemacs-move-to-right)
  (define-key treemacs-mode-map (kbd "v") 'fei-vc-dired-jump)
  (define-key treemacs-mode-map (kbd "G") 'magit)
  )

;; Neotree
(setq neo-theme 'ascii)
(setq neo-window-position 'right)
(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "j") 'neotree-next-line)
  (define-key neotree-mode-map (kbd "k") 'neotree-previous-line)
  (define-key neotree-mode-map (kbd "J") 'fei-neotree-move-to-left)
  (define-key neotree-mode-map (kbd "K") 'fei-neotree-move-to-right)
  (define-key neotree-mode-map (kbd "l") 'neotree-enter)
  (define-key neotree-mode-map (kbd "f") 'neotree-enter)
  (define-key neotree-mode-map (kbd "<mouse-3>") 'neotree-mouse-open-external)
  )

(defun neotree-mouse-open-external (event)
  (interactive "e")
  (mouse-set-point event)
  (neotree-open-file-in-system-application))

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

;; tldr
(global-set-key (kbd "C-h j") 'man)
(global-set-key (kbd "C-h t") 'tldr)

;; 方便左手在键盘，右手在鼠标上的操作姿势
(global-set-key (kbd "M-s M-1") 'highlight-symbol-at-point)
(global-set-key (kbd "M-s 1") 'highlight-symbol-at-point)
(global-set-key (kbd "M-s M-2") 'fei-unhighlight-symbol-at-point)
(global-set-key (kbd "M-s 2") 'fei-unhighlight-symbol-at-point)

(defun fei-unhighlight-symbol-at-point ()
  (interactive)
  (unhighlight-regexp
   (concat "\\_<"
	   (thing-at-point 'symbol)
	   "\\_>")))

;; Symbol-overlay
(global-set-key (kbd "M-I") 'symbol-overlay-put)
(global-set-key (kbd "M-N") 'symbol-overlay-switch-forward)
(global-set-key (kbd "M-P") 'symbol-overlay-switch-backward)
(with-eval-after-load 'symbol-overlay
  (define-key symbol-overlay-map (kbd "o") 'fei-occur-for-mouse)
  (define-key symbol-overlay-map (kbd "O") 'symbol-overlay-find-at-point-project))

;; Consult
(setq consult-preview-key nil)		;不自动预览

(setq register-preview-delay 0.1
      register-preview-function #'consult-register-format)

(global-set-key (kbd "M-s [") 'point-to-register)
(global-set-key (kbd "M-s ]") 'jump-to-register)

(global-set-key (kbd "C-c J") (li (fei-counsel-fd-file-jump nil "~/Desktop/文献仓库")))
(global-set-key (kbd "C-c j") 'fasd-ivy-find-file)

;; minimap 不怎么用
;; (setq minimap-window-location 'right)

;; scratch
(global-set-key (kbd "C-c s") 'scratch)

;; youdao-dictionary
(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input)
  (define-key youdao-dictionary-mode-map (kbd "b") 'fei-quword-at-point))
(global-set-key (kbd "<menu>") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "C-h y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-c y") 'fei-youdao-at-point)

(defun fei-quword-at-point ()
  (interactive)
  (engine/search-quword (thing-at-point 'word)))

;; EAF
(with-eval-after-load 'eaf-browser
  (eaf-bind-key nil "M-s" eaf-browser-keybinding)
  (eaf-bind-key nil "M-S" eaf-browser-keybinding)
  )

;; Helpful
;; (global-set-key (kbd "C-h o") 'helpful-symbol)
;; (global-set-key (kbd "C-h O") 'describe-symbol)
;; (global-set-key (kbd "C-h k") 'helpful-key)

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
(setq keyfreq-excluded-commands
      '(
	;; mwheel-scroll
        ))

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
