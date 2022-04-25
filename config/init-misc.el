(require 'init-func)

;; fei-prefix-map
(defvar fei-prefix-map (make-sparse-keymap))
(global-set-key (kbd "<f1>") fei-prefix-map)
(define-key fei-prefix-map (kbd "j") 'fasd-ivy-find-file)
(define-key fei-prefix-map (kbd "k") 'rg)
(define-key fei-prefix-map (kbd "g") 'fei-search-1)
(define-key fei-prefix-map (kbd "o") 'fei-counsel-fd-file-jump)
(define-key fei-prefix-map (kbd "e") 'file-manager-here)
(define-key fei-prefix-map (kbd "0") 'scratch)
(define-key fei-prefix-map (kbd "n") 'transient-scroll-up-line)
(define-key fei-prefix-map (kbd "p") 'transient-scroll-down-line)

(transient-command scroll-up-line
  (progn (scroll-up-line)
	 (fei-pulse-current-line))
  '(("n" . scroll-up-line)
    ("p" . scroll-down-line)))

(transient-command scroll-down-line
  (progn (scroll-down-line)
	 (fei-pulse-current-line))
  '(("n" . scroll-up-line)
    ("p" . scroll-down-line)))

;; Goto
(global-set-key (kbd "M-g M-f") 'fasd-ivy-find-file)
(global-set-key (kbd "M-g h") (li (browse-url "https://feiyongzhai.github.io")))

;; Pulse
(global-set-key (kbd "C-c h") 'fei-pulse-current-line)

;; goldendict
(when (executable-find "goldendict")
  (global-set-key (kbd "C-c C-d") 'fei-golden-dict)
  (global-set-key (kbd "C-c d") 'fei-golden-dict))

(global-set-key (kbd "C-M-=") 'calculator)
(global-set-key (kbd "<f7>") 'fei-ff-find-other-file-pdf-org)

(global-set-key (kbd "C-c o f") 'file-manager-here)
(global-set-key (kbd "C-c o t") 'fei-terminal-here)
(global-set-key (kbd "C-c o v") 'open-current-file-with-gvim)
(global-set-key (kbd "C-c o C-v") 'open-current-file-with-vscode)
(global-set-key (kbd "C-c o C-e") 'open-current-file-with-emacsq)
(global-set-key (kbd "C-c o e") 'open-current-file-with-emacsv)
(global-set-key (kbd "C-c o E") 'open-current-file-with-emacs)
(global-set-key (kbd "<f12>") 'fei-emacs) ;use for quick debug

(global-set-key (kbd "M-s L") (li (fei-meow-last-buffer 1)))

(fei-define-key-with-map global-map
  `(("<insert>"     . fei-occur-at-point)
    ("<insertchar>" . fei-occur-at-point)
    ("C-x F"        . set-fill-column)
    ("<f5>"         . fei-simple-compile)
    ("M-s g"        . rgrep)
    ))

;; ESC ESC * == toggle style mode
(fei-define-key-with-map global-map
  '(
    ("M-ESC b" . display-battery-mode)
    ("M-ESC f" . display-fill-column-indicator-mode)
    ("M-ESC l" . display-line-numbers-mode)
    ("M-ESC L" . fei-display-line-numbers-cycle)
    ("M-ESC M" . feebleline-mode)
    ("M-ESC m" . menu-bar-mode)
    ("M-ESC o" . olivetti-mode)
    ("M-ESC t" . tab-bar-mode)
    ("M-ESC T" . tool-bar-mode)
    ("M-ESC r" . ruler-mode)
    ("M-ESC u" . fei-toggle-ui)
    ("M-ESC w" . whitespace-mode)
    ("M-ESC W" . whitespace-newline-mode)
    ("M-ESC v" . evil-mode-with-cursor)
    ))

;; (add-hook 'server-after-make-frame-hook 'fei-resize-frame)
;; (defun fei-resize-frame ()
;;   (interactive)
;;   (when (display-graphic-p)
;;     (set-frame-width nil 125)))

(provide 'init-misc)
