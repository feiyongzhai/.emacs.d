;;; config for search
(require 'init-func)
(require 'fei-funcs)

;;; Keys
;; isearch experimental config
(setq isearch-lazy-count t)
(setq lazy-count-suffix-format " [%s/%s]")
(setq lazy-count-prefix-format nil)
(with-eval-after-load 'isearch
  (define-key isearch-mode-map (kbd "M-g") 'isearch-cancel)
  (define-key isearch-mode-map (kbd "DEL") 'isearch-del-char)
  ;; M-j 配合 `isearch-mode-hook' 和 `isearch-mode-end-hook' 可以完成
  ;; 在 isearch 的情况下也是 "输入中文" 这个功能，这样 M-j 按键的功能
  ;; 就有一致性的表现了
  (define-key isearch-mode-map (kbd "M-j") 'isearch-edit-string)
  )

(defvar isearch-end-activate-input-method-predicate nil)
(add-hook 'isearch-mode-hook (lambda () (when (string= current-input-method "rime")
					  (deactivate-input-method)
					  (setq isearch-end-activate-input-method-predicate t))))
(add-hook 'isearch-mode-end-hook (lambda () (when isearch-end-activate-input-method-predicate
					      (activate-input-method "rime")
					      (setq isearch-end-activate-input-method-predicate nil))))

(global-set-key (kbd "s-s") 'fei-google-search)
(global-set-key (kbd "M-s p") 'pinyin-search)
(fei-define-key-with-map isearch-mode-map
  '(
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("C-'" . avy-isearch)
    ("M-s j" . avy-isearch)
    ("M-w" . fei-isearch-copy-region)
    ("<C-return>" . prot-search-isearch-other-end)
    ))

;; (global-anzu-mode t)
(setq-default
 isearch-regexp-lax-whitespace t
 search-whitespace-regexp ".*?")

;; ctrlf-mode

;; (ctrlf-mode 1)

(with-eval-after-load 'ctrlf
  (define-key (kbd "C-p") 'ctrlf-previous-match)
  (define-key (kbd "C-n") 'ctrlf-next-match)
  )

(setq ctrlf-default-search-style 'fuzzy)
(setq ctrlf-show-match-count-at-eol nil)
(setq ctrlf-highlight-current-line nil)

(provide 'init-search)
