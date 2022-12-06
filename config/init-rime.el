;; Rime
(add-to-list 'load-path "~/.emacs.d/extensions/rime/")

(setq rime-title "ㄓ ")
(autoload 'rime-activate "rime" nil nil nil)
(register-input-method "rime" "euc-cn" 'rime-activate rime-title)

;; Keys
(global-set-key (kbd "M-j") 'fei-ime-force-enable)
(global-set-key (kbd "M-J") (li (deactivate-input-method)))
(with-eval-after-load 'rime
  (global-set-key (kbd "C-`") 'rime-select-schema)
  (define-key rime-active-mode-map (kbd "C-i") 'rime-inline-ascii)
  (define-key rime-active-mode-map (kbd "M-h") 'rime--return)
  (define-key rime-active-mode-map (kbd "C-j") 'rime--return)
  )

;; Vars
(with-eval-after-load 'rime
  (face-spec-set 'rime-default-face
		 '((((class color) (background dark))
		    (:background "#333333" :foreground "#dcdccc" :slant italic))
		   (((class color) (background light))
		    (:background "#dcdccc" :foreground "#333333" :slant italic)))))

(cond (*is-linux*
       (setq rime-user-data-dir "~/.emacs.d/rime/linux"))
      (t (message "使用默认值：~/.emacs.d/rime/")))

(setq rime-posframe-properties
      (list :internal-border-width 4))

(setq default-input-method "rime"
      ;; rime-show-candidate 'posframe ;posframe 的显示效果和桌面环境相关，目前在 gnome 下工作良好，在 cinnamon 下工作会有问题
      rime-show-candidate 'posframe
      rime-show-preedit t
      rime-posframe-style 'vertical
      rime-posframe-fixed-position t)

(setq rime-disable-predicates
      '(rime-predicate-auto-english-p
	fei-rime-predicate-prog-in-code-p
        ;; rime-predicate-space-after-cc-p
        ;; rime-predicate-after-alphabet-char-p
	rime-predicate-tex-math-or-command-p
	rime-predicate-org-latex-mode-p
	rime-predicate-org-in-src-block-p))

(defun fei-rime-predicate-prog-in-code-p ()
    (and (derived-mode-p 'prog-mode 'conf-mode)
	 (not (nth 4 (syntax-ppss)))))

(setq rime-translate-keybindings
      '("C-f" "C-b" "C-n" "C-p" "C-g" "C-h" "C-e" "C-v" "M-v" "M-f" "M-b"
	"C-`" "C-d" "C-k" "C-y" "<tab>" "C-a" "C-u"
	"<left>" "<right>" "<up>" "<down>" "<prior>" "<next>" "<delete>"))

;; 让 rime 和 isearch 更好的工作，自己乱胡的版本，勉强能用

;; M-j 配合 `isearch-mode-hook' 和 `isearch-mode-end-hook' 可以完成在
;; isearch 的情况下也是 "输入中文" 这个功能，这样 M-j 按键的功能就有一
;; 致性的表现了

(define-key isearch-mode-map (kbd "M-j") 'isearch-edit-string)

(add-hook 'isearch-mode-hook '+fei-isearch-deacivate-input-method)
(add-hook 'isearch-mode-end-hook '+fei-isearch-end-restore-input-method)


(defvar isearch-end-activate-input-method-predicate nil)

(defun +fei-isearch-deacivate-input-method ()
  (when (string= current-input-method "rime")
    (deactivate-input-method)
    (setq isearch-end-activate-input-method-predicate t)))

(defun +fei-isearch-end-restore-input-method ()
  (when isearch-end-activate-input-method-predicate
    (activate-input-method "rime")
    ;; 不知道什么原因，isearch-mode 退出之后重新激活输入法，会导致
    ;; (default-value 'input-method-function) 的值变成 rime-input-method
    ;; 不过目前可以用这个方法解决问题 (虽然不是从根本上解决，但是管用)
    (setq-default input-method-function nil)
    (setq isearch-end-activate-input-method-predicate nil)))

(defun fei-ime-force-enable ()
  (interactive)
  (cond
   (*is-windows*
    (w32-set-ime-open-status t)
    ;; (pyim-convert-string-at-point)
    )
   (*is-linux*
    (activate-input-method "rime")
    (call-interactively 'rime-force-enable))))

(provide 'init-rime)
