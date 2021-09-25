;;; {{ almost all global-map shortkeys
(fei-define-key-with-map global-map
  `(
    ;; ESC ESC * style -- quick open dir or file
    ("ESC ESC c" . ,(li (dired "~/.config")))
    ("ESC ESC d" . ,(li (dired "~/Downloads")))
    ("ESC ESC D" . ,(li (dired "~/Desktop")))
    ("ESC ESC e" . ,(li (dired "~/.emacs.d")))
    ("ESC ESC E" . ,(li (dired "~/Sandbox/Emacs/")))
    ("ESC ESC h" . ,(li (dired "~")))
    ("ESC ESC m" . ,(li (dired "~/Music")))
    ("ESC ESC o" . ,(li (find-file "~/.emacs.d/init-local.el")))
    ("ESC ESC p" . ,(li (dired "~/Picture")))
    ("ESC ESC s" . ,(li (dired "~/Sandbox")))
    ("ESC ESC N" . ,(li (dired "~/Nutstore Files")))
    ("ESC ESC n" . ,(li (dired "/home/yongfeizhai/Nutstore Files/我的坚果云/研究生/SAR/")))
    ("ESC ESC v" . ,(li (dired "~/Videos")))
    ("ESC ESC V" . ,(li (dired "~/.vim")))
    ("ESC ESC g" . ,(li (dired "~/Sandbox/Git/testGit/")))
    ("ESC ESC C-b" . ,(li (dired "~/Sandbox/Emacs/MyBlog/")))
    ("ESC ESC ." . ,(li (dired "~/dotfiles-fei")))
    ("ESC ESC ;" . ,(li (find-file "~/.emacs.d/@scratch@")))
    ;; ("ESC ESC <M-escape>" . evil-local-mode-with-cursor)

    ("M-s-b" . ,(li (browse-url "https://feiyongzhai.github.io")))
    ("M-s-n" . ,(li (dired "~/Nutstore Files")))
    ("M-s-i" . ,(li (require 'rime) (toggle-input-method)))
    ("C-s-i" . fei-toggle-xhup-flypy)
    ("s-`" . ,(li (require 'rime) (toggle-input-method)))
    ("M-s-I" . insert-translated-name-insert)
    ("M-s-e" . elfeed)
    ("M-s-m" . ,(li (dired "~/Nutstore Files/我的坚果云/研究生")))

    ("M-s-o" . ,(li (find-file "~/.emacs.d/init-local.el")))
    ("M-s-;" . ,(li (find-file "~/.emacs.d/@scratch@")))
    ("C-x u" . transient-undo)

    ("C-x F" . set-fill-column)
    ("C-x f" . counsel-find-file)
    ("C-x C-f" . counsel-find-file)
    ("C-x d" . counsel-dired)
    ("C-x C-d" . counsel-dired)
    ("M-z" . fei-org-capture)
    ("C-M-z" . ,(li
		 (org-capture nil "i")
		 (auto-fill-mode)
		 (require 'rime)
		 (activate-input-method 'rime)))
    ;; Misc
    ("<menu>" . youdao-dictionary-search-at-point-tooltip)
    ("<insert>" . nil)
    ("M-s s" . isearch-forward-symbol-at-point)
    ("M-G" . engine-mode-prefixed-map)
    ("M-G p" . devdocs-lookup)
    ("M-g i" . imenu)
    ("M-L" . duplicate-current-line)

    ;; <f1> -- <f12>
    ("<f5>" . ,(li (save-buffer) (let (compilation-read-command) (call-interactively 'compile))))
    ("<f8>" . next-eshell-buffer)
    ("<C-f8>" . fei-eshell-cd-here)
    ("<s-f8>" . ,(li (split-window-below) (other-window 1) (call-interactively 'fei-eshell-cd-here)))
    ("<M-f8>" . shell)
    ;; ("<f10>" . nil)
    ("<f7>" . scratch)
    ("<f12>" . fei-ansi-term)
    
    ("<f1> f" . counsel-describe-function)
    ("<f1> v" . counsel-describe-variable)
    ("<f9>" . neotree-toggle)

    ;; Tab related
    ("C-x t O" . transient-tab-previous)
    ("C-x t o" . transient-tab-next)
    ("C-x t l" . tab-list)
    ("C-x t t" . tab-bar-select-tab-by-name)
    ("C-x t r" . tab-recent)
    ("C-x t n" . tab-new)
    ("C-x t R" . tab-rename)
    ("C-x t u" . tab-undo)
    ("M-1" . ,(li (tab-bar-select-tab 1)))
    ("M-2" . ,(li (tab-bar-select-tab 2)))
    ("M-3" . ,(li (tab-bar-select-tab 3)))
    ("M-4" . ,(li (tab-bar-select-tab 4)))
    ("M-5" . ,(li (tab-bar-select-tab 5)))
    ("M-6" . ,(li (tab-bar-select-tab 6)))
    ("M-7" . ,(li (tab-bar-select-tab 7)))
    ("M-8" . ,(li (tab-bar-select-tab 8)))
    ("M-9" . ,(li (tab-bar-select-tab 9)))
    ("M-0" . tab-list)
    ("M--" . tab-close)
    ("M-_" . tab-bar-rename-tab)
    ("M-=" . tab-new)
    ("M-+" . tab-bar-switch-to-tab)
    ("C-t" . tab-new)
    ;; ivy-view replacement
    ("C-c v" . ivy-push-view)
    ("C-c V" . ivy-pop-view)

    ("M-t" . tab-undo)
    ;; C-c * style
    ("C-c a" . org-agenda)
    ("C-c b" . counsel-bookmark)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c s" . ,(li (require 'org) (call-interactively 'org-store-link)))
    ("C-," . set-mark-command)

    ;; C-x *
    ("C-x 4 C-b" . ,(li (ibuffer-jump t) (ibuffer-auto-mode 1)))
    ("C-x C-b" . ,(li (ibuffer-jump) (ibuffer-auto-mode 1)))
    ("C-x b" . counsel-switch-buffer)

    ;; windows related
    ("C-x w u" . transient-winner-undo)
    ("C-x w M" . maximize-window)
    ("C-S-m" . maximize-window)		; matlab like keybinding
    ("C-x w m" . minimize-window)
    ("C-x o" . transient-other-window)
    ("C-x O" . transient-other-window-backward)

    ;; M-* style
    ("M-x" . counsel-M-x)
    ("M-i" . company-yasnippet/yas-expand)

    ;; C-*
    ("C-=" . align-regexp)
    ("C-z" . evil-mode-with-cursor)
    ("<C-return>" . ,(li (end-of-line) (newline-and-indent)))
    ("M-RET" . ,(li (end-of-line) (newline-and-indent)))

    ;; mouse
    ("<mouse-4>" . scroll-down-line)
    ("<mouse-5>" . scroll-up-line)

    ("M-k" . fei-kill-current-buffer)
    ("C-x k" . kill-current-buffer)
    ("C-x K" . fei-kill-current-buffer)	; inspired by protesilaos

    ("C-h y" . youdao-dictionary-search-from-input)
    ("C-h q" . devdocs-lookup)
    ("C-h Q" . devdocs-search)

    ("M-h" . find-file)		      ; inspired by emacstalk 嘉宾领峰
    ("C-c o" . occur)
    ("M-H" . counsel-recentf)
    ("M-j" . switch-to-buffer)
    ("<pause>" . fei-org-time)

    ;; citre related
    ("C-c j" . citre-jump)
    ("C-c J" . citre-jump-back)
    ("C-c p" . citre-ace-peek)

    ))

(global-set-key (kbd "M-N") 'scroll-up-line)
(global-set-key (kbd "M-P") 'scroll-down-line)

(global-set-key (kbd "M-a") 'beginning-of-defun)
(global-set-key (kbd "M-e") 'end-of-defun)

(when *is-linux*
  (global-set-key (kbd "C-c w") 'counsel-wmctrl)
  (global-set-key (kbd "C-c m") 'counsel-linux-app)
  (global-set-key (kbd "C-'") 'avy-goto-line)
  (global-set-key (kbd "C-x p") 'proced)
  )

;; s-* style usually Windows related
(global-set-key (kbd "s-0") 'delete-window)
(global-set-key (kbd "s-1") 'delete-other-windows)
(global-set-key (kbd "s-2") (lambda () (interactive) (split-window-below) (other-window 1)))
(global-set-key (kbd "s-3") (lambda () (interactive) (split-window-right) (other-window 1)))
(global-set-key (kbd "s-s") 'fei-google-search)
(global-set-key (kbd "<s-tab>") 'fei-meow-last-buffer)
(global-set-key (kbd "s-u") 'winner-undo)
(global-set-key (kbd "<s-return>") 'fei-terminal-here)
(global-set-key (kbd "s-y") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "s-Y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "s-v") 'vc-prefix-map)
(global-set-key (kbd "s-v s-v") 'vc-next-action)

;;; }} almost all global-map keybindings

(define-key tab-switcher-mode-map (kbd "q") 'tab-close)

;; 回车代替输入y
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

(add-hook 'eshell-mode-hook
	  (lambda ()
	    (define-key eshell-mode-map (kbd "C-l") (lambda () (interactive) (recenter 0)))))

(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "M-o") nil)
  (define-key diff-mode-map (kbd "M-k") nil)
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))

(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input))

(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "M-s") nil)
  (define-key paredit-mode-map (kbd "M-r") #'paredit-splice-sexp))

(with-eval-after-load 'devdocs
  (define-key devdocs-mode-map (kbd "s") 'devdocs-search))

(provide 'init-keys)
