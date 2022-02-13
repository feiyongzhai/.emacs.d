;;; init-window-buffer-tab.el  --- configs for Window/Buffer/Tab

(require 'init-func)

;;; Mode

(winner-mode 1)

;;; Buffer
(global-set-key (kbd "M-k") 'fei-kill-current-buffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x K") 'fei-kill-current-buffer)	; inspired by protesilaos
(global-set-key (kbd "M-s RET") 'fei-meow-last-buffer)
(global-set-key (kbd "M-s l") 'fei-meow-last-buffer)
(global-set-key (kbd "C-x B") 'fei-meow-last-buffer)
(global-set-key (kbd "C-x b") 'consult-buffer)

;;; ==== Window ====
(global-set-key (kbd "s-u") 'winner-undo)
(fei-define-key-with-map global-map
  '(
    ("C-x w u" . transient-winner-undo)
    ("C-S-m" . maximize-window)		; matlab like keybinding
    ("C-x w M" . maximize-window)
    ("C-x w m" . minimize-window)
    ("C-x o" . ace-window)
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
    ("M-`" . eyebrowse-last-window-config)
    ("M-1" . eyebrowse-switch-to-window-config-1)
    ("M-2" . eyebrowse-switch-to-window-config-2)
    ("M-3" . eyebrowse-switch-to-window-config-3)
    ("M-4" . eyebrowse-switch-to-window-config-4)
    ("M-5" . eyebrowse-switch-to-window-config-5)
    ("M-6" . eyebrowse-switch-to-window-config-6)
    ("M-7" . eyebrowse-switch-to-window-config-7)
    ("M-8" . eyebrowse-switch-to-window-config-8)
    ("M-9" . eyebrowse-switch-to-window-config-9)
    ("M-0" . eyebrowse-switch-to-window-config-0)
    ("C-S-w" . tab-close)
    ("C-S-t" . tab-new)
    ))

(add-hook 'term-mode-hook '+fei-term-mode-hook)

(defun +fei-term-mode-hook ()
  ;; 占用了终端 native 的 M-num 的按键：不过这个按键也不常用，所以没什么问题
  (define-key term-raw-map (kbd "M-`") 'eyebrowse-last-window-config)
  (define-key term-raw-map (kbd "M-1") 'eyebrowse-switch-to-window-config-1)
  (define-key term-raw-map (kbd "M-2") 'eyebrowse-switch-to-window-config-2)
  (define-key term-raw-map (kbd "M-3") 'eyebrowse-switch-to-window-config-3)
  (define-key term-raw-map (kbd "M-4") 'eyebrowse-switch-to-window-config-4)
  (define-key term-raw-map (kbd "M-5") 'eyebrowse-switch-to-window-config-5)
  (define-key term-raw-map (kbd "M-6") 'eyebrowse-switch-to-window-config-6)
  (define-key term-raw-map (kbd "M-7") 'eyebrowse-switch-to-window-config-7)
  (define-key term-raw-map (kbd "M-8") 'eyebrowse-switch-to-window-config-8)
  (define-key term-raw-map (kbd "M-9") 'eyebrowse-switch-to-window-config-9)
  (define-key term-raw-map (kbd "M-0") 'eyebrowse-switch-to-window-config-0))

(setq tab-bar-show 1)
(setq tab-bar-tab-hints t)		;show number in tab-bar
(setq tab-bar-new-tab-choice nil)	;duplicate
(setq tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
;; (setq tab-bar-new-tab-choice 'eshell)

;;; Funcs

(transient-command winner-undo (winner-undo)
  '(("u" . winner-undo)
    ("U" . winner-redo)))

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
	("files-and-scratch" "^\\*scratch\\*$" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)
	("eshell" nil nil nil fei-bs-not-eshell bs-sort-buffer-interns-are-last)
	("Org" nil nil nil fei-bs-not-org bs-sort-buffer-interns-are-last)
	("same-major" nil nil nil fei-bs-not-cur-major-mode bs-sort-buffer-interns-are-last)
	("all-intern-last" nil nil nil nil bs-sort-buffer-interns-are-last))
      )

(defun fei-bs-not-eshell (buf)
  (with-current-buffer buf (not (eq major-mode 'eshell-mode))))

(defun fei-bs-not-org (buf)
  (with-current-buffer buf (not (eq major-mode 'org-mode))))

(defun fei-bs-not-cur-major-mode (buf)
  (with-current-buffer buf (not (eq major-mode bs-cur-major-mode))))

(defun fei-bs-get-current-buffer-list ()
  (mapcar (lambda (buf) (buffer-name buf)) bs-current-list))

(defun fei-switch-to-buffer-from-bs ()
  (interactive)
  (let ((buf (completing-read "Switch to buffer: " (fei-bs-get-current-buffer-list))))
    (bs-kill)
    (switch-to-buffer buf)))

(defun fei-bs-set-configuration-default (conf)
  (bs-set-configuration conf)
  (setq bs-default-configuration bs-current-configuration)
  (bs-refresh))

(with-eval-after-load 'bs
  (define-key bs-mode-map (kbd "a") (li (fei-bs-set-configuration-default "all")))
  (define-key bs-mode-map (kbd "A") 'bs-toggle-show-all)
  (define-key bs-mode-map (kbd "e") (li (fei-bs-set-configuration-default "eshell")))
  (define-key bs-mode-map (kbd "h") (li (fei-bs-set-configuration-default "same-major")))
  (define-key bs-mode-map (kbd "O") (li (fei-bs-set-configuration-default "Org")))
  (define-key bs-mode-map (kbd "i") (li (bs-kill) (call-interactively 'switch-to-buffer)))
  (define-key bs-mode-map (kbd "I") (li (bs-kill) (call-interactively 'ibuffer)))
  (define-key bs-mode-map (kbd "j") 'fei-switch-to-buffer-from-bs)
  (define-key bs-mode-map (kbd "k") 'nil) ;default is `bs-delete', 但是最近总是误触
  (define-key bs-mode-map (kbd "f") (li (fei-bs-set-configuration-default "files")))
  )

(provide 'init-window-buffer-tab)
;;; init-windows.el ends here.
