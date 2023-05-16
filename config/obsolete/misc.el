;; 一些不再使用的包的配置放到这个位置


;; easy-kill 相关配置
(global-set-key (kbd "M-w") 'easy-kill)
(with-eval-after-load 'easy-kill
  (define-key easy-kill-base-map (kbd "x") 'easy-kill-exchange-point-and-mark)
  (define-key easy-kill-base-map (kbd "C-w") 'easy-kill-region))



;; 搜索相关的命令
(defvar fei-search-prompt)

(setq fei-search-prompt
      (concat "[b/B] B站/Bing [w/i] Wikipedia/Github [h/c] 汉典/词典 [y] YouTube \n"
	      "[s/S/M-s] 学术/搜狗/StackOverFlow [d/D] 百度/DuckDuckGo [g/i] 谷歌/图片"))

(defun fei-search (&optional arg)
  "A wrapper for `fei-google-search', powered by `engine-mode'"
  (interactive "P")
  (if arg
      (progn
	(message fei-search-prompt)
	(set-transient-map 'engine-mode-prefixed-map))
    (call-interactively 'fei-google-search)))

(defun fei-search-1 ()
  (interactive)
  (fei-search 1))

(defun fei-google-search (&optional search-string)
  "Googles a query or region if any.

参考链接：https://liujiacai.net/blog/2020/11/25/why-emacs/"
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (or search-string
	(if mark-active
            (buffer-substring-no-properties (region-beginning) (region-end))
	  (url-encode-url (read-string "Google: ")))))))


;; 这是一个比较笨蛋的命令，就和 Alt+Tab 一样
(fei-repeat fr/bury-or-unbury-buffer
  (progn (window-configuration-to-register ?b)
	 (bury-buffer))
  '(("b" . bury-buffer)
    ("," . unbury-buffer)))


;; Ibuffer
(setq ibuffer-show-empty-filter-groups nil) ;; 不显示空组
(setq ibuffer-movement-cycle nil)
(add-hook 'ibuffer-mode-hook #'hl-line-mode)
;; (add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode)

  ;;; ibuffer group
(setq ibuffer-saved-filter-groups
      '(("default"
         ("C/C++" (or (name . "^.*\\.c$")
                      (name . "^.*\\.cpp$")))
         ("Matlab" (name . "^.*\\.m$"))
         ("Lisp" (or (name . "^.*\\.el$")
                     (mode . emacs-lisp-mode)))
         ("EAF" (mode . eaf-mode))
         ("Org" (or (mode . org-mode)
                    (mode . org-agenda-mode)))
         ("Dired" (mode . dired-mode))
         ("Emacs" (or (mode . eshell-mode)
                      (name . "^\\*ielm\\*$")))
         ("PDF" (name . "^.*\\.pdf$"))
         ;; 下面这个是贪婪匹配，就是匹配 * 开头和结尾所有句子（包括空格）
         ("Files" (not (name . "^\\*.*\\*$")))
         )))


(defun fei-scroll-up-line ()
  (interactive)
  (if (or (eq last-command 'fei-scroll-down-line)
	  (eq last-command 'fei-scroll-up-line))
      (scroll-up-line)
    (scroll-up-line)
    (fei-pulse-current-line)))

(defun fei-scroll-down-line ()
  (interactive)
  (if (or (eq last-command 'fei-scroll-down-line)
	  (eq last-command 'fei-scroll-up-line))
      (scroll-down-line)
    (scroll-down-line)
    (fei-pulse-current-line)))


;; Fcitx
;; (setq fcitx-active-evil-states '(insert emacs hybrid))
;; (fcitx-evil-turn-on)
;; (fcitx-aggressive-minibuffer-turn-on)
;; (fcitx-aggressive-setup)
;; (fcitx-prefix-keys-add "M-s")
;; (fcitx-prefix-keys-add "C-x")
;; (fcitx-prefix-keys-add "C-c")
;; (fcitx-prefix-keys-add "C-h")
;; (fcitx-prefix-keys-turn-on)
;; BUG: `fcitx-prefix-keys-turn-on' 会引入一个问题：在按住修饰键，鼠标点击 tab bar 会造成 emacs 崩溃


;; Sis
;; sis 和 emacsclient / deamon 的时候会出现退不出 emacs 的情况

;; 错误提示如下：
;; terminal-focus-reporting--apply-to-terminal: Device 1 is not a termcap terminal device

;; (setq sis-prefix-override-keys '("C-c" "C-x" "C-h" "M-s"))
;; (sis-ism-lazyman-config "1" "2" 'fcitx)
;; (sis-global-respect-mode 1)


(with-eval-after-load 'ctrlf
  (define-key ctrlf-minibuffer-mode-map (kbd "C-p") 'ctrlf-previous-match)
  (define-key ctrlf-minibuffer-mode-map (kbd "C-n") 'ctrlf-next-match)
  )


(defun fei-svg-clock ()
  (interactive)
  (frameset-to-register ?1)
  (svg-clock :size 800)
  (sit-for 0.1)
  (fit-frame-to-buffer))


(defun fei-meow-last-buffer (arg)
  "Switch to last buffer.
Argument ARG if not nil, switching in a new window."
  (interactive "P")
  (cond
   ((minibufferp)
    (keyboard-escape-quit))
   ((not arg)
    (mode-line-other-buffer))
   (t
    (split-window)
    (mode-line-other-buffer))))


;;; Neotree
(global-set-key (kbd "M-s M-n") 'neotree-toggle)

(setq neo-theme 'classic)
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

(defun fei-neotree-move-to-left ()
  (interactive)
  (neotree-hide)
  (setq neo-window-position 'left)
  (neotree-show))

(defun fei-neotree-move-to-right ()
  (interactive)
  (neotree-hide)
  (setq neo-window-position 'right)
  (neotree-show))

(defun neotree-mouse-open-external (event)
  (interactive "e")
  (mouse-set-point event)
  (neotree-open-file-in-system-application))
