;;; init-packages  --- misc packages configs

;;; autoload

(load-path-add "~/.emacs.d/extensions/insert-translated-name")
(autoload 'insert-translated-name-insert "insert-translated-name" nil t)

;; {{ iedit
(global-set-key (kbd "C-;") 'iedit-mode)
;; }} iedit

;;; {{ matlab
(autoload 'org-ctrl-c-ctrl-c "org" nil t) ; hack for matlab-mode
(setq matlab-indent-level 2)
(with-eval-after-load 'matlab
  (define-key matlab-mode-map (kbd "C-c C-c") 'org-ctrl-c-ctrl-c))
(add-hook 'matlab-mode-hook (lambda () (display-line-numbers-mode t)))
;;; }}


;; {{ youdao-dictionary
(with-eval-after-load 'youdao-dictionary
  (define-key youdao-dictionary-mode-map "i" #'youdao-dictionary-search-from-input))
(global-set-key (kbd "s-y") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "<menu>") 'youdao-dictionary-search-at-point-tooltip)
(global-set-key (kbd "s-Y") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-h y") 'youdao-dictionary-search-from-input)
;; }} youdao-dictionary

;; {{ insert-translated-name
(global-set-key (kbd "M-s-I") 'insert-translated-name-insert)
;; }} insert-translated-name

;; {{ elfeed
(global-set-key (kbd "M-s-e") 'elfeed)
;; }} elfeed

;; {{ citre
(global-set-key (kbd "C-c j") 'citre-jump)
(global-set-key (kbd "C-c J") 'citre-jump-back)
(global-set-key (kbd "C-c p") 'citre-ace-peek)
;; }} citre

;; {{ diff
(with-eval-after-load 'diff
  (define-key diff-mode-map (kbd "M-o") nil)
  (define-key diff-mode-map (kbd "M-k") nil)
  (define-key diff-mode-map (kbd "C-o") 'diff-goto-source)
  (define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill))
;; }} diff

;; {{ devdocs
(with-eval-after-load 'devdocs
  (define-key devdocs-mode-map (kbd "s") 'devdocs-search))
(global-set-key (kbd "C-h q") 'devdocs-lookup)
(global-set-key (kbd "C-h Q") 'devdocs-search)
(global-set-key (kbd "M-G p") 'devdocs-lookup)

;; }} devdocs

;; {{ engine-mode
(global-set-key (kbd "M-G") 'engine-mode-prefixed-map)
;; }} engine-mode


;; {{ y-or-n
;; 回车代替输入y
(define-key y-or-n-p-map [return] 'act)
(define-key y-or-n-p-map (kbd "C-m") 'act)
(define-key y-or-n-p-map (kbd "C-j") 'act)
;; }} y-or-n

;; {{ ahk-mode
(setq ahk-indentation 4)
;; }} ahk-mode

;; {{ paredit
(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "M-s") nil)
  (define-key paredit-mode-map (kbd "M-r") nil)
  (define-key paredit-mode-map (kbd "M-R") #'paredit-splice-sexp)
  )
;; }} paredit

;; {{ neotree
(setq neo-theme 'ascii)
(global-set-key (kbd "C-c SPC") 'neotree)
(global-set-key (kbd "C-c n") 'neotree)
(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "j") 'isearch-forward)
  (define-key neotree-mode-map (kbd "J") 'isearch-backward)
  (define-key neotree-mode-map (kbd "f") 'neotree-enter)
  )
;; }} neotree

;; {{ ialign
(global-set-key (kbd "C-x l") 'ialign)
;; }} ialign

;; {{ minimap
(setq minimap-window-location 'right)
;; }} minimap

;; {{ octave alternative for matlab-mode
(add-hook 'octave-mode-hook 'electric-pair-local-mode)
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

(add-hook 'octave-mode-hook
    (lambda () (progn (setq octave-comment-char ?%)
                      (setq comment-start "% ")
                      (setq comment-add 0)
		      (setq comment-column 0)
		      )))
;; }} octave

;;; {{ smex
;; (setq smex-prompt-string "^_^ ")
;;; }}

;;; {{ ace-window config
(global-set-key (kbd "s-o") 'ace-window)
(setq aw-keys '(?j ?k ?l ?h ?g ?f ?d ?s ?a))
(custom-set-faces '(aw-leading-char-face ((t (:foreground "red" :height 1.5)))))
;;; }}

(defun yasnippet-snippets--fixed-indent ()
  "Set `yas-indent-line' to `fixed'."
  (set (make-local-variable 'yas-indent-line) 'fixed))

(defun yasnippet-snippets--no-indent ()
  "Set `yas-indent-line' to nil."
  (set (make-local-variable 'yas-indent-line) nil))

(with-eval-after-load 'yasnippet
  (yas-load-directory (expand-file-name "~/.emacs.d/snippets") t))

;;; Vars

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(provide 'init-packages)
;;; init-packages.el ends here.
