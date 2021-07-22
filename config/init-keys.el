(fei-define-key-with-map global-map
  '(
    ;; ESC ESC Style 这类快捷键会导致有点慢 这种快捷键的方式，完成一
    ;; 个命令需要按两下，如果命令本身就是一个动作的话，我在使用的过程
    ;; 中经常是按了前面的按键之后就不知道刚刚要干什么了，很打断思路，
    ;; 根据我的使用经验，这种分段的按键方式不适合那种很`直接的命令'，
    ;; 而是需要很具有`分段特性的命令'结合使用才不会打断思路直接的命令
    ;; 可以用一个组合按键来配合使用如同下面列举的：`M-s-*'和`C-s-*'类
    ;; 型的一步到位的组合键模式，而不适合这种序列式的按键模式

    ;; ESC ESC * style -- quick open dir or file
    ("ESC ESC h" . (lambda () (interactive) (dired "~")))
    ("ESC ESC c" . (lambda () (interactive) (dired "~/.config")))
    ("ESC ESC d" . (lambda () (interactive) (dired "~/Downloads")))
    ("ESC ESC D" . (lambda () (interactive) (dired "~/Desktop")))
    ("ESC ESC e" . (lambda () (interactive) (dired "~/.emacs.d")))
    ("ESC ESC E" . (lambda () (interactive) (dired "~/Sandbox/Emacs/")))
    ("ESC ESC m" . (lambda () (interactive) (dired "~/Music")))
    ("ESC ESC o" . (lambda () (interactive) (find-file "~/.emacs.d/init-local.el")))
    ("ESC ESC p" . (lambda () (interactive) (dired "~/Picture")))
    ("ESC ESC s" . (lambda () (interactive) (dired "~/Sandbox")))
    ("ESC ESC n" . (lambda () (interactive) (dired "~/Nutstore Files")))
    ("ESC ESC v" . (lambda () (interactive) (dired "~/Videos")))
    ("ESC ESC V" . (lambda () (interactive) (dired "~/.vim")))
    ("ESC ESC g" . (lambda () (interactive) (dired "~/Sandbox/Git/testGit/")))
    ("ESC ESC C-b" . (lambda () (interactive) (dired "~/Sandbox/Emacs/MyBlog/")))
    ("ESC ESC ." . (lambda () (interactive) (dired "~/dotfiles-fei")))
    ("ESC ESC ;" . (lambda () (interactive) (find-file "~/.emacs.d/@scratch@")))

    ("ESC ESC b" . list-bookmarks)
    ("ESC ESC l" . list-packages)
    ("ESC ESC L" . list-processes)
    ;; ("ESC ESC <M-escape>" . evil-local-mode-with-cursor)

    ;; M-s-* style
    ("M-s-b" . (lambda () (interactive) (browse-url "https://feiyongzhai.github.io")))
    ("M-s-d" . (lambda () (interactive) (dired "~/Desktop/")))
    ("M-s-e" . elfeed)
    ("M-s-g" . magit-status)
    ("M-s-n" . (lambda () (interactive) (dired "~/Nutstore Files")))
    ("M-s-i" . (lambda () (interactive) (require 'rime) (toggle-input-method)))
    ("M-s-I" . insert-translated-name-insert)
    ("M-s-s" . (lambda () (interactive) (dired "~/Sandbox/")))
    ("M-s-t" . telega)
    ("M-s-v" . vc-prefix-map)
    ("M-s-m" . (lambda () (interactive) (dired "~/Nutstore Files/我的坚果云/研究生")))

    ("M-s-o" . (lambda () (interactive) (find-file "~/.emacs.d/init-local.el")))
    ("M-s-y" . youdao-dictionary-search-at-point-tooltip)
    ("M-s-l" . display-line-numbers-mode)
    ("M-s-;" . (lambda () (interactive) (find-file "~/.emacs.d/@scratch@")))

    ;; C-s-* style
    ("C-s-i" . fei-toggle-xhup-flypy)
    ("C-s-l" . toggle-truncate-lines)
    ("C-s-k" . (lambda () (interactive) (find-file "~/.emacs.d/config/init-keys.el")))

    ;; C-M-s-* style
    ("C-M-s-l" . display-line-numbers-cycle)

    ;; s-* style usually Windows related
    ("s-[" . fei-restore-or-store-window)
    ("s-]" . fei-restore-window)
    ("s-0" . delete-window)
    ("s-1" . delete-other-windows)
    ("s-2" . (lambda () (interactive) (split-window-below) (other-window 1)))
    ("s-3" . (lambda () (interactive) (split-window-right) (other-window 1)))
    ("s-o" . other-window)
    ("s-s" . occur)
    ("s-O" . (lambda () (interactive) (other-window -1)))
    ;; 下面这个fei-meow-last-buffer有一个Bug，就是在分屏之后，工作逻辑
    ;; 会有点奇怪，不管了，先用着吧
    ("<s-tab>" . fei-meow-last-buffer)
    ("s-u" . winner-undo)
    ("s-r" . winner-redo)
    ("s-\\" . fei-terminal-here)
    ("<s-return>" . fei-terminal-here)

    ;; Key Tweaks(less Ctrl style)
    ("C-x F" . set-fill-column)
    ("C-x f" . counsel-find-file)
    ("C-x C-f" . counsel-find-file)
    
    ("C-c r" . counsel-recentf)
    ("C-c f" . find-name-current-dired)
    ("C-c F" . find-name-dired)
    ("C-x u" . transient-undo)

    ("C-x d" . counsel-dired)
    ("C-x C-d" . counsel-dired)
    ("M-z" . fei-org-capture)
    ("C-M-z" . (lambda () (interactive)
		 (org-capture nil "i")
		 (auto-fill-mode)
		 (require 'rime)
		 (activate-input-method 'rime)))
    ;; Misc
    ("<menu>" . youdao-dictionary-search-at-point-tooltip)
    ("<insert>" . nil)
    ("M-s s" . isearch-forward-symbol-at-point)
    ("M-s M-s" . swiper)
    ("M-G" . engine-mode-prefixed-map)
    ("M-G M-g" . eaf-open-browser)
    ("M-G M-G" . eaf-open-browser-with-history)
    ("M-G p" . devdocs-lookup)
    ("M-L" . duplicate-current-line)

    ;; <f1> -- <f12>
    ;; ("<f10>" . nil)
    ("<f10>" . next-same-major-mode-buffer)
    ("<f12>" . fei-ansi-term)
    ("<f8>" . next-eshell-buffer)
    ("<C-f8>" . fei-eshell-cd-here)
    ("<s-f8>" . (lambda () (interactive)
		  (split-window-below)
		  (other-window 1)
		  (call-interactively 'fei-eshell-cd-here)))
    ("<M-f8>" . shell)
    
    ("<f1> f" . counsel-describe-function)
    ("<f1> v" . counsel-describe-variable)
    ("<f9>" . neotree-toggle)
    ;; gnome-terminal 不接受 s-* style的快捷键
    ("<s-f1>" . (lambda () (interactive)
		  (eaf-open-this-buffer)))

    ;; Tab related
    ("C-x t O" . transient-tab-previous)
    ("C-x t o" . transient-tab-next)
    ("C-x t l" . tab-list)
    ("C-x t t" . tab-bar-select-tab-by-name)
    ("C-x t r" . tab-recent)
    ("C-x t n" . tab-new)
    ("C-x t R" . tab-rename)
    ("C-x t u" . tab-undo)
    ("M-1" . (lambda () (interactive) (tab-bar-select-tab 1)))
    ("M-2" . (lambda () (interactive) (tab-bar-select-tab 2)))
    ("M-3" . (lambda () (interactive) (tab-bar-select-tab 3)))
    ("M-4" . (lambda () (interactive) (tab-bar-select-tab 4)))
    ("M-5" . (lambda () (interactive) (tab-bar-select-tab 5)))
    ("M-6" . (lambda () (interactive) (tab-bar-select-tab 6)))
    ("M-7" . (lambda () (interactive) (tab-bar-select-tab 7)))
    ("M-8" . (lambda () (interactive) (tab-bar-select-tab 8)))
    ("M-9" . (lambda () (interactive) (tab-bar-select-tab 9)))
    ("M-0" . (lambda () (interactive) (tab-bar-select-tab 10)))
    ("M-_" . tab-close)
    ("M-+" . tab-new)
    ("C-S-w" . tab-close)
    ("C-S-t" . tab-new)
    ;; ivy-view replacement
    ("C-c v" . ivy-push-view)
    ("C-c V" . ivy-pop-view)

    ;; C-c * style
    ("C-c a" . org-agenda)
    ("C-c b" . counsel-bookmark)
    ("C-c g" . counsel-git)
    ("C-c k" . counsel-rg)
    ("C-c l" . counsel-locate)
    ("C-c r" . counsel-recentf)
    ("C-c s" . (lambda () (interactive) (require 'org) (call-interactively 'org-store-link)))
    ("C-c M-x" . counsel-M-x)
    ("C-c SPC" . neotree-toggle)
    ;; youdao-dictionary
    ("C-c y y" . youdao-dictionary-search-at-point-tooltip)
    ("C-c y i" . youdao-dictionary-search-from-input)

    ;; C-x *
    ("C-x 4 C-b" . (lambda () (interactive) (ibuffer-jump) (ibuffer-auto-mode 1)))
    ("C-x C-b" . (lambda () (interactive) (ibuffer-jump t) (ibuffer-auto-mode 1)))

    ;; M-* style
    ("M-x" . counsel-M-x)
    ("M-i" . company-yasnippet/yas-expand)

    ;; C-*
    ("C-=" . er/expand-region)
    ("C-z" . evil-mode-with-cursor)
    ("<C-return>" . (lambda () (interactive) (end-of-line) (newline-and-indent)))

    ;; mouse
    ("<mouse-4>" . scroll-down-line)
    ("<mouse-5>" . scroll-up-line)

    ;; ("M-v" . scroll-down-line)
    ;; ("C-v" . scroll-up-line)

    ("C-x b" . counsel-switch-buffer)

    ;; windows related
    ("C-x w u" . transient-winner-undo)
    ("C-x w U" . transient-winner-redo)
    ("C-x w e" . balance-windows)
    ("C-x w H" . windmove-swap-states-left)
    ("C-x w J" . windmove-swap-states-down)
    ("C-x w K" . windmove-swap-states-up)
    ("C-x w L" . windmove-swap-states-right)
    ("C-x w M" . maximize-window)
    ("C-x w m" . fei-minimize-window)
    ("C-x o" . transient-other-window)
    ("C-x O" . transient-other-window-backward)
    ("C-x {" . transient-shrink-window)
    ("C-x }" . transient-enlage-window)
    ("M-k" . fei-kill-current-buffer)

    ("C-h y" . youdao-dictionary-search-from-input)
    ("C-h q" . devdocs-lookup)
    ("C-h Q" . devdocs-search)
    ("M-g i" . imenu)
    ))


(define-key tab-switcher-mode-map (kbd "q") 'tab-close)

(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
			       (save-buffer)
			       (let (compilation-read-command)
				 (call-interactively 'compile))))

;; 回车代替输入y
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)

(global-set-key (kbd "<C-return>") (lambda () (interactive)
				     (end-of-line)
				     (newline-and-indent)))

(add-hook 'eshell-mode-hook
	  (lambda ()
	    (define-key eshell-mode-map (kbd "C-l") (lambda () (interactive) (recenter 0)))))

(with-eval-after-load 'vc-git
  (define-key vc-git-log-edit-mode-map (kbd "M-A") 'vc-git-log-edit-toggle-amend)
  (define-key vc-git-log-edit-mode-map (kbd "M-C") 'log-edit-done)
  (define-key vc-git-log-edit-mode-map (kbd "M-D") 'log-edit-show-diff))

(with-eval-after-load 'rime
  (define-key rime-active-mode-map (kbd "M-h") 'rime--escape)
  (define-key rime-active-mode-map (kbd "M-j") 'rime--return)
  (define-key rime-active-mode-map (kbd "M-o") 'rime--backspace)
  (define-key rime-active-mode-map (kbd "<tab>") 'rime-inline-ascii))

(with-eval-after-load 'eaf
  (define-key eaf-mode-map* (kbd "<s-f1>") 'eaf-open-external))

(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "M-o") nil)
  (define-key diff-mode-map (kbd "M-k") nil)
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))

(with-eval-after-load 'org
  (global-set-key (kbd "C-c s") 'org-store-link))

(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input))

(global-set-key (kbd "C-c j") 'citre-jump)
(global-set-key (kbd "C-c J") 'citre-jump-back)
(global-set-key (kbd "C-c p") 'citre-ace-peek)


(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (define-key evil-insert-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (define-key evil-visual-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (define-key evil-motion-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (define-key evil-emacs-state-map (kbd "C-z") 'evil-mode-with-cursor)
  (evil-define-key 'normal messages-buffer-mode-map "q" 'quit-window)
  )

(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "M-s") nil)
  (define-key paredit-mode-map (kbd "M-r") #'paredit-splice-sexp))

(with-eval-after-load 'devdocs
  (define-key devdocs-mode-map (kbd "s") 'devdocs-search))

(with-eval-after-load 'markdown-mode
  (fei-define-key-with-map markdown-mode-map
    '(
      ("C-c !" . markdown-insert-header-setext-1)
      ("C-c 1" . markdown-insert-header-atx-1)
      ("C-c 2" . markdown-insert-header-atx-2)
      ("C-c 3" . markdown-insert-header-atx-3)
      ("C-c 4" . markdown-insert-header-atx-4)
      ("C-c 5" . markdown-insert-header-atx-5)
      ("C-c 6" . markdown-insert-header-atx-6)
      ("C-c @" . markdown-insert-header-setext-2)
      ("C-c H" . markdown-insert-header-setext-dwim)
      ("C-c h" . markdown-insert-header-dwim)
      ("C-c s" . markdown-insert-header-setext-2)
      ("C-c t" . markdown-insert-header-setext-1)
      ("<M-up>" . markdown-move-up)
      ("<M-down>" . markdown-move-down)
      )))

(fei-define-key-with-map global-map
  '(("C-c n l" . org-roam)
    ("C-c n f" . org-roam-find-file)
    ("C-c n g" . (lambda () (interactive) (browse-url "http://127.0.0.1:8080")))
    ("C-c n G" . org-roam-graph)))

(with-eval-after-load 'org
  (fei-define-key-with-map org-mode-map
    '(
      ("C-c n i" . org-roam-insert)
      ("C-c n I" . org-roam-insert-immediate)
      )))

(fei-define-key-with-map global-map
  '(
    ))

;;; {{ need feature `general`
;;; Evil related keys
(general-create-definer fei-space-leader-def
  :prefix "SPC"
  :states '(normal visual))

(fei-space-leader-def
  "SPC" 'counsel-M-x
  "tt" 'modus-themes-toggle
  "ts" 'counsel-load-theme
  ;; "gg" 'browse-stackoverflow-search
  "g" 'engine-mode-prefixed-map
  "ss" 'eshell
  "se" 'shell
  "jj" 'scroll-other-window
  "kk" 'scroll-other-window-down
  )
;;; }}

;;; {{ win10 related
(when *is-windows*
  (setq w32-lwindow-modifier 'super)
  (w32-register-hot-key [s-])
  (w32-register-hot-key [M-escape])
  (setq w32-apps-modifier 'super)
  (global-set-key (kbd "s-m") 'toggle-frame-maximized))
;;; }}

(provide 'init-keys)
