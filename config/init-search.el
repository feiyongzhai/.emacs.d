;;; config for search
(require 'init-func)
(require 'fei-funcs)

(setq isearch-lazy-count t)
(setq lazy-count-suffix-format " [%s/%s]")
(setq lazy-count-prefix-format nil)
(setq-default
 isearch-regexp-lax-whitespace t
 search-whitespace-regexp ".*?")

(global-set-key (kbd "M-s C-m") 'browse-url)
(global-set-key (kbd "s-g") 'fei-search)
(global-set-key (kbd "M-G") 'fei-search)
(global-set-key (kbd "M-S") 'swiper-isearch)
(global-set-key (kbd "M-s s") 'swiper-isearch)
(global-set-key (kbd "M-s M-s") 'swiper-isearch)

(with-eval-after-load 'swiper
  (define-key swiper-map (kbd "M-s") 'swiper-C-s)
  (define-key swiper-map (kbd "M-r") 'swiper-isearch-C-r)
  )

;; 控制 `kill-ring-save'(M-w) 在没有高亮选择区的时候的光标闪烁时间，而
;; 一般没有光标同时我想要进行复制的场景是在 isearch 的情形下，所以这个配
;; 置放在这里也比较合理
(setq copy-region-blink-delay .1)

(fei-define-key-with-map isearch-mode-map
  '(
    ("M-g" . isearch-cancel)
    ("M-<" . isearch-beginning-of-buffer)
    ("M->" . isearch-end-of-buffer)
    ("<C-return>" . prot-search-isearch-other-end)
    ("C-'" . avy-isearch)
    ("M-'" . avy-isearch)	 ;gnome-terminal 读不到 C-',用这个代替
    ("C-c k" . fei-counsel-rg-from-isearch)
    ("M-s r" . rg-isearch-project)
    ("M-S" . swiper-isearch-toggle)
    ("M-s M-s" . swiper-isearch-toggle)
    ))

(defun fei-counsel-rg-from-isearch ()
  (interactive)
  (isearch-exit)
  (counsel-rg isearch-string))

;; ==== ctrlf-mode ====
;; (ctrlf-mode 1)

(setq ctrlf-default-search-style 'fuzzy)
(setq ctrlf-show-match-count-at-eol nil)
(setq ctrlf-highlight-current-line nil)

(with-eval-after-load 'ctrlf
  (define-key ctrlf-minibuffer-mode-map (kbd "C-p") 'ctrlf-previous-match)
  (define-key ctrlf-minibuffer-mode-map (kbd "C-n") 'ctrlf-next-match)
  )

;;; Funcs
(defun prot-search-isearch-other-end ()
  "End current search in the opposite side of the match.
Particularly useful when the match does not fall within the
confines of word boundaries (e.g. multiple words)."
  (interactive)
  (isearch-done)
  (when isearch-other-end
    (goto-char isearch-other-end)))

(defun fei-isearch-copy-region ()
  (interactive)
  (isearch-exit)
  (call-interactively 'copy-region-as-kill))

(provide 'init-search)
