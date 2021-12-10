;;; 一些过时的配置和函数，留着给以后做参考

;; {{ `display-line-numbers-cycle'
(defvar display-line-numbers-relative-p nil)

(defun display-line-numbers-cycle ()
  (interactive)
  (if display-line-numbers-relative-p
      (progn (menu-bar--display-line-numbers-mode-absolute)
	     (setq display-line-numbers-relative-p nil))
    (menu-bar--display-line-numbers-mode-relative)
    (setq display-line-numbers-relative-p t)))
;; }} 


;; {{ `next-same-major-mode-buffer'

;; (transient-command next-same-major-mode-buffer
;;   (next-same-major-mode-buffer)
;;   '(("m" . next-same-major-mode-buffer)))

(defun next-same-major-mode-buffer ()
  "Go to next buffer which has same major-mode of current buffer

this command is useful only when current buffer's major mode is
`eshell-mode', `eaf-mode', `term-mode', `shell-mode' or other
special major mode"
  (interactive)
  (let ((current major-mode))
    (catch 'done
      ;; `buffer-list' is changeable variable, the recently visited
      ;; buffer always next to the current buffer, if I do not use
      ;; `reverse', and if there is one buffer having same major mode
      ;; with current buffer, it will back and forth these two buffer,
      ;; despite there potentially are other buffers having the same
      ;; major mode with current buffer.
      (dolist (buf (reverse (cdr (buffer-list))) (message "only one `%s' buffer" current))
	(with-current-buffer buf
	  (when (eq current major-mode)
	    (throw 'done (progn (switch-to-buffer buf)
				(message "next `%s' buffer" current)))))))))
;; }} 


;; {{ ido related config
;;;TODO：ido-mode 下的 minibuffer-complete 对应的是 ido-complete，所以下面的命令需要重新写一下
(define-key minibuffer-local-map (kbd "M-i") 'minibuffer-complete)
;; }} 


;; {{ `fei-search-symbol-at-point'
(defun fei-search-symbol-at-point ()
  (interactive)
  (cond
   ((bounds-of-thing-at-point 'symbol)
    (if ctrlf-local-mode
	(call-interactively 'ctrlf-forward-symbol-at-point)
      (call-interactively 'isearch-forward-symbol-at-point)))
   (t
    (if ctrlf-local-mode
	(ctrlf-forward-default)
      (isearch-forward)))))
;; }}


;; {{ org-agenda related

;; (when (display-graphic-p)
;;   (org-agenda nil "a")
;;   (delete-other-windows))
;; (add-hook 'server-after-make-frame-hook
;; 	  (lambda () (when window-system
;; 		       (org-agenda nil "a")
;; 		       (delete-other-windows))))

;; }}

;;; {{ vc related config

;; (global-set-key (kbd "s-v") 'vc-prefix-map)
;; (global-set-key (kbd "s-v s-v") 'vc-next-action)

;; (with-eval-after-load 'vc-git
;;   (define-key vc-git-log-edit-mode-map (kbd "M-A") 'vc-git-log-edit-toggle-amend)
;;   (define-key vc-git-log-edit-mode-map (kbd "M-C") 'log-edit-done)
;;   (define-key vc-git-log-edit-mode-map (kbd "M-D") 'log-edit-show-diff))

;;; }}


;;; {{ matlab related
(autoload 'org-ctrl-c-ctrl-c "org" nil t) ; hack for matlab-mode
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "C-c C-c") 'org-ctrl-c-ctrl-c))
;;; }}


;;; {{ company & yasnippet
(with-eval-after-load 'yasnippet
  (with-eval-after-load 'company
    (global-set-key (kbd "M-i") 'company-yasnippet/yas-expand)
    (defun company-yasnippet/yas-expand ()
      (interactive)
      (call-interactively 'company-yasnippet)
      (when (eq 1 company-candidates-length)
	(call-interactively 'yas-expand)))
    ))

(defun my-lsp-fix-company-capf ()
  "Remove redundant `comapny-capf'."
  (setq company-backends
        (remove 'company-backends (remq 'company-capf company-backends))))
(advice-add #'lsp-completion--enable :after #'my-lsp-fix-company-capf)

(defun my-company-yasnippet-disable-inline (fn cmd &optional arg &rest _ignore)
  "Enable yasnippet but disable it inline."
  (if (eq cmd  'prefix)
      (when-let ((prefix (funcall fn 'prefix)))
        (unless (memq (char-before (- (point) (length prefix)))
                      '(?. ?< ?> ?\( ?\) ?\[ ?{ ?} ?\" ?' ?`))
          prefix))
    (progn
      (when (and (bound-and-true-p lsp-mode)
                 arg (not (get-text-property 0 'yas-annotation-patch arg)))
        (let* ((name (get-text-property 0 'yas-annotation arg))
               (snip (format "%s (Snippet)" name))
               (len (length arg)))
          (put-text-property 0 len 'yas-annotation snip arg)
          (put-text-property 0 len 'yas-annotation-patch t arg)))
      (funcall fn cmd  arg))))
(advice-add #'company-yasnippet :around #'my-company-yasnippet-disable-inline)

(defun my-company-yasnippet ()
  "Hide the current completeions and show snippets."
  (interactive)
  (company-cancel)
  (call-interactively 'company-yasnippet))

;;; }}


;;; {{ tab related

(transient-command tab-next
  (tab-next)
  '(("o" . tab-next)
    ("O" . tab-previous)))

(transient-command tab-previous
  (tab-previous)
  '(("o" . tab-next)
    ("O" . tab-previous)))

;;; }}


;;; 此配置配合`auto-save'避免写在*scratch*中的内容未保存导致的数据丢失
;; (add-hook 'after-init-hook
;; 	  (lambda ()
;; 	    (find-file "~/.emacs.d/@scratch@")
;; 	    ;; (setq initial-buffer-choice "~/.emacs.d/@scratch@")
;; 	    (kill-buffer "*scratch*")))


;;; Font config

;; (if *is-windows*
;;     ;; Setting English Font 仅在 windows 生效
;;     (progn
;;       (set-face-attribute
;;        'default nil
;;        :font "DejaVu Sans Mono for Powerline"
;;        :height 140)
;;      ;; Setting Chinese Font
;;      (set-fontset-font t '(#x4e00 . #x9fff) "Microsoft Yahei")))

;; @ref https://emacs-china.org/t/windows-emacs/7907/39
;; 下面这个配置当我需要更换其他的字体的时候，加上下面这一行，也可以保证中英文的对齐
;; (set-fontset-font "fontset-default" 'unicode'("等距更纱黑体 SC"))


;;; Misc

;;; 这个设置会导致一个小问题：blink一下当前行之后高亮不清除。主要体现
;;; 是在使用thing-edit和citre插件的时候会出现这个问题，这两个插件都提
;;; 供了blink一下相应的region来做提示，都会出现高亮之后高亮区域不消失
;;; 的情况
;; (setq frame-resize-pixelwise t)		;这个设置在笔记本电脑上面会出现画面透明的问题，找到问题了，是桌面特效的bug，不过是启动Emacs的时候有问题，别的应用也会出现消失不见的问题

;; no backup-file
;; (setq make-backup-files nil)

(global-set-key (kbd "s-0") 'delete-window)
(global-set-key (kbd "s-1") 'delete-other-windows)
(global-set-key (kbd "s-2") (lambda () (interactive) (split-window-below) (other-window 1)))
(global-set-key (kbd "s-3") (lambda () (interactive) (split-window-right) (other-window 1)))


;;; Eshell

;;; Misc
(add-hook 'eshell-mode-hook
	  (lambda ()
	    (define-key eshell-mode-map (kbd "C-l") (lambda () (interactive) (recenter 0)))))
;; another workaround
(add-hook 'eshell-mode-hook
	  (lambda ()
	    (setq-local recenter-positions '(top middle bottom))))

;;; Windows

(defun other-window-backward ()
  (interactive)
  (other-window -1))

(transient-command other-window-backward
  (other-window-backward)
  '(("o" . other-window)
    ("O" . other-window-backward)))


;;; Theme

;;; autoswitch theme by time
;; (let ((hour (string-to-number
;; 	     (substring (current-time-string) 11 13))))
;;   (if (member hour (number-sequence 6 17))
;;       (load-theme 'modus-operandi t)
;;     (load-theme 'modus-vivendi t)))


;;; package: move-text
(load-path-add "~/.emacs.d/extensions/move-text/")

(require 'move-text)

;;; Keys

(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "<M-down>") nil)
  (define-key paredit-mode-map (kbd "<M-up>") nil))

(define-key global-map (kbd "<M-up>") #'move-text-up)
(define-key global-map (kbd "<M-down>") #'move-text-down)

(provide 'init-move-text)


;;; LaTeX

;; (setq TeX-view-program-selection
;;       '(((output-dvi has-no-display-manager)
;; 	 "dvi2tty")
;; 	((output-dvi style-pstricks)
;; 	 "dvips and gv")
;; 	(output-dvi "xdvi")
;; 	(output-pdf "Zathura")
;; 	(output-html "xdg-open")))


;;; Dired

(defun find-name-current-dired (arg)
  (interactive
   (let ((string
	  (read-string "Find-name(filename wildcard): " nil 'history)))
     (list string)))
  (find-name-dired "." arg))


;;; Company

;; `yasnippet' integration
(with-no-warnings
  (with-eval-after-load 'yasnippet
    (defun company-backend-with-yas (backend)
      "Add `yasnippet' to company backend."
      (if (and (listp backend) (member 'company-yasnippet backend))
          backend
        (append (if (consp backend) backend (list backend))
                '(:with company-yasnippet))))

    (defun my-company-enbale-yas (&rest _)
      "Enable `yasnippet' in `company'."
      (setq company-backends (mapcar #'company-backend-with-yas company-backends)))
    ))



;; {{ citre
(global-set-key (kbd "C-c j") 'citre-jump)
(global-set-key (kbd "C-c J") 'citre-jump-back)
(global-set-key (kbd "C-c p") 'citre-ace-peek)
;; }} citre



;;; {{ tab-line

(global-set-key (kbd "<C-next>") 'tab-line-switch-to-next-tab)
(global-set-key (kbd "<C-prior>") 'tab-line-switch-to-prev-tab)
(global-set-key (kbd "<C-delete>") 'bury-buffer)

;;; tab-line }}


;;; Edit related

(global-set-key (kbd "M-N") 'transient-scroll-up-line)
(global-set-key (kbd "M-P") 'transient-scroll-down-line)

(transient-command scroll-up-line
  (call-interactively 'scroll-up-line)
  '(("n" . scroll-up-line)
    ("p" . scroll-down-line)))

(transient-command scroll-down-line
  (call-interactively 'scroll-down-line)
  '(("n" . scroll-up-line)
    ("p" . scroll-down-line)))

;; @see https://www.emacswiki.org/emacs/CopyingWholeLines
;; duplicate current line
(defun duplicate-current-line (&optional n)
  "duplicate current line, make more than 1 copy given a numeric argument"
  (interactive "p")
  (save-excursion
    (let ((nb (or n 1))
    	  (current-line (thing-at-point 'line)))
      ;; when on last line, insert a newline first
      (when (= 1 (forward-line 1))
    	(insert "\n"))
      
      ;; now insert as many time as requested
      (while (> n 0)
    	(insert current-line)
    	(decf n)))))

(defun back-to-indentation-or-beginning () (interactive)
       (if (= (point) (progn (back-to-indentation) (point)))
	   (beginning-of-line)))


;;; evil

;;; evil-mode 偶尔才会用一下，没有必要搞一个快捷键

;; 而且我发现自己的笔记本（Linux）用 emacs 的体验比实验室（windows）的
;; 体验好多了，完全是两种体验。不得不说，实验室的电脑实在是有点卡，还
;; 不如我自己的电脑，所以我为什么不带自己电脑去实验室，值得深思的问题？
;; 我为什么要让自己遭罪呢？怎么感觉又是自我设限（汗），真是处处自我设限

(global-set-key (kbd "C-S-z") 'evil-mode-with-cursor)
(define-key evil-normal-state-map (kbd "C-S-z") 'evil-mode-with-cursor)
(define-key evil-insert-state-map (kbd "C-S-z") 'evil-mode-with-cursor)
(define-key evil-visual-state-map (kbd "C-S-z") 'evil-mode-with-cursor)
(define-key evil-motion-state-map (kbd "C-S-z") 'evil-mode-with-cursor)
(define-key evil-emacs-state-map (kbd "C-S-z") 'evil-mode-with-cursor)
(setq evil-emacs-state-cursor 'bar)




;; devdocs {{
(with-eval-after-load 'devdocs
  (define-key devdocs-mode-map (kbd "s") 'devdocs-search))
(global-set-key (kbd "C-h q") 'devdocs-lookup)
(global-set-key (kbd "C-h Q") 'devdocs-search)
;; devdocs }}



;; 输入法相关

;; 目前还不知道是什么原因，下面这个这行设置不能生效，把这行保留是为
;; 了下次想追究这个原因的方便回忆

;; (set-face-attribute 'rime-default-face nil :slant 'italic)



;; eaf

(defun fei-eaf-start ()
  (interactive)
  (use-package eaf
    :init
    (use-package epc :defer t :ensure t)
    (use-package ctable :defer t :ensure t)
    (use-package deferred :defer t :ensure t)
    (use-package s :defer t :ensure t)))



;; change-cursor-mode inspired manual solution

(add-hook 'post-command-hook
	  (lambda () (if buffer-read-only
			 (setq cursor-type 'box)
		       (setq cursor-type 'bar))))

