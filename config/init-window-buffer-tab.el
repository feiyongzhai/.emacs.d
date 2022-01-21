;;; init-window-buffer-tab.el  --- configs for Window/Buffer/Tab

(require 'init-func)

;;; Mode

(winner-mode 1)

;;; Buffer
(global-set-key (kbd "M-k") 'fei-kill-current-buffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x K") 'fei-kill-current-buffer)	; inspired by protesilaos
(global-set-key (kbd "M-s b") 'fei-meow-last-buffer)
(global-set-key (kbd "C-x B") 'fei-meow-last-buffer)

;;; ==== Window ====
(global-set-key (kbd "s-o") 'ace-window)
(global-set-key (kbd "s-O") 'other-frame)
(global-set-key (kbd "s-u") 'winner-undo)
(fei-define-key-with-map global-map
  '(
    ("C-x w u" . transient-winner-undo)
    ("C-S-m" . maximize-window)		; matlab like keybinding
    ("C-x w M" . maximize-window)
    ("C-x w m" . minimize-window)
    ("C-x o" . transient-other-window)
    ("C-x O" . other-frame)
    ))

(setq aw-scope 'frame)
(setq aw-keys '(?j ?k ?l ?h ?g ?f ?d ?s ?a))
(custom-set-faces '(aw-leading-char-face ((t (:foreground "red" :height 1.5)))))
;;; ==== Tab bar ====

(define-key tab-switcher-mode-map (kbd "q") 'tab-close)

;; Eyebrowse
(eyebrowse-mode 1)
(setq eyebrowse-new-workspace t)
;; (setq eyebrowse-mode-line-style 'smart)

(fei-define-key-with-map global-map
  `(
    ("C-x t l" . tab-list)
    ("C-x t t" . tab-bar-select-tab-by-name)
    ("C-x t r" . tab-recent)
    ("C-x t n" . tab-new)
    ("C-x t R" . tab-rename)
    ("C-x t u" . tab-undo)
    ("M-0" . eyebrowse-switch-to-window-config-0)
    ("M-1" . eyebrowse-switch-to-window-config-1)
    ("M-2" . eyebrowse-switch-to-window-config-2)
    ("M-3" . eyebrowse-switch-to-window-config-3)
    ("M-4" . eyebrowse-switch-to-window-config-4)
    ("M-5" . eyebrowse-switch-to-window-config-5)
    ("M-6" . eyebrowse-switch-to-window-config-6)
    ("M-7" . eyebrowse-switch-to-window-config-7)
    ("M-8" . eyebrowse-switch-to-window-config-8)
    ("M-9" . eyebrowse-switch-to-window-config-9)
    ("C-S-w" . tab-close)
    ("C-S-t" . tab-new)
    ))

(setq tab-bar-show 1)
(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice nil)	;duplicate
(setq tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
;; (setq tab-bar-new-tab-choice 'eshell)

;;; Funcs

(transient-command winner-undo (winner-undo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

(transient-command other-window (other-window 1)
  '(("o" . other-window)
    ("O" . other-window-backward)))

;;; ==== Tab-line begin ====
(require 'tab-line)

(setq tab-line-tab-name-function 'tab-line-tab-name-truncated-buffer)
;;; `face-spec-set' 和 `custom-set-faces' 还是有点区别的
(face-spec-set 'tab-line
	       '((t (:inherit nil :height 0.95))))
;; (custom-set-faces
;;  '(tab-line ((t (:inherit nil :background "grey85" :foreground "black" :height 0.95)))))

(global-set-key (kbd "C-x <left>") 'transient-tab-line-prev)
(global-set-key (kbd "C-x <right>") 'transient-tab-line-next)

(transient-command tab-line-next
  (call-interactively 'tab-line-switch-to-next-tab)
  '(("<left>" . tab-line-switch-to-prev-tab)
    ("<right>" . tab-line-switch-to-next-tab)
    ("<down>" . bury-buffer)
    ))

(transient-command tab-line-prev
  (call-interactively 'tab-line-switch-to-prev-tab)
  '(("<left>" . tab-line-switch-to-prev-tab)
    ("<right>" . tab-line-switch-to-next-tab)
    ("<down>" . bury-buffer)
    ))

;;; ==== Tab-line end ====

;;; ==== Bs ====
;; @REF https://emacs.stackexchange.com/questions/65094/how-to-quickly-cycles-through-buffers-of-the-same-major-mode-as-current-one
(global-set-key (kbd "C-x C-b") (li (setq bs-cur-major-mode major-mode) (call-interactively 'bs-show)))
(add-hook 'bs-mode-hook 'hl-line-mode)
(setq bs-configurations
      '(("all" nil nil nil nil nil)
	("files" nil nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)
	("eshell" nil nil nil fei-bs-not-eshell bs-sort-buffer-interns-are-last)
	("same-major" nil nil nil fei-bs-not-cur-major-mode bs-sort-buffer-interns-are-last)
	("files-and-scratch" "^\\*scratch\\*$" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)
	("all-intern-last" nil nil nil nil bs-sort-buffer-interns-are-last))
      )

(defun fei-bs-not-eshell (buf)
  (with-current-buffer buf (not (eq major-mode 'eshell-mode))))

(defun fei-bs-not-cur-major-mode (buf)
  (with-current-buffer buf (not (eq major-mode bs-cur-major-mode))))

(with-eval-after-load 'bs
  (define-key bs-mode-map (kbd "e") (li (bs-set-configuration "eshell") (bs-refresh)))
  (define-key bs-mode-map (kbd "h") (li (bs-set-configuration "same-major") (bs-refresh)))
  (define-key bs-mode-map (kbd "i") (li (bs-kill) (call-interactively 'switch-to-buffer)))
  (define-key bs-mode-map (kbd "j") 'bs-select)
  )

(provide 'init-window-buffer-tab)
;;; init-windows.el ends here.
