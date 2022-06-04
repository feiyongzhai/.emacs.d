(require 'init-func)

;; fei-prefix-map
(defvar fei-prefix-map (make-sparse-keymap))
(defvar fei-jump-map (make-sparse-keymap))
(global-set-key (kbd "<f1>") fei-prefix-map)
(global-set-key (kbd "<menu>") fei-prefix-map)
(define-key fei-prefix-map (kbd "1") 'zygospore-toggle-delete-other-windows)
(define-key fei-prefix-map (kbd "2") (li (split-window-right) (other-window 1)))
(define-key fei-prefix-map (kbd "3") (li (split-window-below) (other-window 1)))
(define-key fei-prefix-map (kbd "0") 'delete-window)
(define-key fei-prefix-map (kbd "j") fei-jump-map)
(define-key fei-prefix-map (kbd "l") 'fei-meow-last-buffer)
(define-key fei-prefix-map (kbd "SPC") 'set-mark-command)
(define-key fei-prefix-map (kbd "k") 'rg)
(define-key fei-prefix-map (kbd "s") 'eshell)
(define-key fei-prefix-map (kbd "S") 'fei-eshell-cd-here)
(define-key fei-prefix-map (kbd "g") 'fei-search-1)
(define-key fei-prefix-map (kbd "o") (li (fei-counsel-fd-file-jump nil "~/Desktop/文献仓库")))
(define-key fei-prefix-map (kbd "e") 'file-manager-here)
(define-key fei-prefix-map (kbd "X") 'compile)
(define-key fei-prefix-map (kbd "x") 'execute-extended-command)
(define-key fei-prefix-map (kbd "n") 'transient-scroll-up-line)
(define-key fei-prefix-map (kbd "p") 'transient-scroll-down-line)

(transient-command scroll-up-line
  (progn (scroll-up-line)
	 (fei-pulse-current-line))
  '(("n" . scroll-up-line)
    ("p" . scroll-down-line)
    ("N" . scroll-other-window)
    ("P" . scroll-other-window-down)))

(transient-command scroll-down-line
  (progn (scroll-down-line)
	 (fei-pulse-current-line))
  '(("n" . scroll-up-line)
    ("p" . scroll-down-line)
    ("N" . scroll-other-window)
    ("P" . scroll-other-window-down)))

;; Pulse
(global-set-key (kbd "C-c H") 'fei-pulse-current-line)

;; Misc
(global-set-key (kbd "C-M-=") 'calculator)
(global-set-key (kbd "<f7>") 'fei-ff-find-other-file-pdf-org)

(global-set-key (kbd "<f12>") 'fei-emacs) ;use for quick debug

(fei-define-key-with-map global-map
  `(("<insert>"     . fei-occur-at-point)
    ("<insertchar>" . fei-occur-at-point)
    ("C-x F"        . set-fill-column)
    ("<f5>"         . recompile)
    ("M-s g"        . rgrep)
    ))

;; (add-hook 'server-after-make-frame-hook 'fei-resize-frame)
;; (defun fei-resize-frame ()
;;   (interactive)
;;   (when (display-graphic-p)
;;     (set-frame-width nil 125)))

(provide 'init-misc)
