;;; init-ime.el  --- 中文输入法相关配置 rime & pyim

(require 'fei-funcs)
(require 'pyim)

;; Pyim

(pyim-isearch-mode)

;; 这行配置存在性能问题：
;; 1. 当在 minibuffer 中粘贴很长的一个链接的时候，会出现卡死的情况
(with-eval-after-load 'ivy
  (setq ivy-re-builders-alist
	'((t . pyim-cregexp-ivy))))

(define-key pyim-mode-map (kbd "C-h") 'pyim-delete-backward-char)
(define-key pyim-mode-map (kbd "M-h") 'pyim-quit-no-clear)
(define-key pyim-mode-map (kbd "<escape>") 'pyim-quit-clear)

(with-eval-after-load 'pyim
  (require 'pyim-basedict)
  (pyim-basedict-enable)
  (setq pyim-default-scheme 'xiaohe-shuangpin)
  (setq pyim-page-tooltip 'posframe)
  )
;; (setq-default pyim-english-input-switch-functions
;; 	      '(pyim-probe-dynamic-english
;; 		pyim-probe-isearch-mode
;; 		pyim-probe-program-mode
;; 		pyim-probe-org-structure-template))
;; (setq-default pyim-punctuation-half-width-functions
;; 	      '(pyim-probe-punctuation-line-beginning
;; 		pyim-probe-punctuation-after-punctuation))
;; (global-set-key (kbd "M-j") 'pyim-convert-code-at-point)
;; (global-set-key (kbd "C-;") 'pyim-delete-word-from-personal-buffer)
;; (setq pyim-page-length 5)
;; (setq pyim-page-tooltip 'posframe)


;; Rime

(add-to-list 'load-path "~/.emacs.d/extensions/emacs-rime/")

(setq rime-title "ㄓ ")
(autoload 'rime-activate "rime" nil nil nil)
(register-input-method "rime" "euc-cn" 'rime-activate rime-title)

;; Keys
(global-set-key (kbd "M-j") 'fei-activate-pyim)
(global-set-key (kbd "M-J") (li (deactivate-input-method)))
(with-eval-after-load 'rime
  (global-set-key (kbd "C-`") 'rime-select-schema)
  (define-key rime-active-mode-map (kbd "<tab>") 'rime-inline-ascii)
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
      (*is-windows*
       (setq rime-user-data-dir "~/.emacs.d/rime/win10"))
      (t (message "使用默认值：~/.emacs.d/rime/")))

(setq rime-posframe-properties
      (list :internal-border-width 4))

(setq default-input-method "pyim"
      rime-show-candidate nil
      rime-show-candidate 'posframe ;posframe 的显示效果和桌面环境相关，目前在 gnome 下工作良好，在 cinnamon 下工作会有问题
      rime-show-preedit t
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
	"M-n" "M-p"
	"<left>" "<right>" "<up>" "<down>" "<prior>" "<next>" "<delete>"))

(provide 'init-ime)
;;; init-ime.el ends here.
