;;; config for search
(require 'init-func)
(require 'fei-funcs)

(setq isearch-lazy-count t)
(setq lazy-count-suffix-format " [%s/%s]")
(setq lazy-count-prefix-format nil)
(setq-default
 isearch-regexp-lax-whitespace t
 search-whitespace-regexp ".*?")

;; 控制 `kill-ring-save'(M-w) 在没有高亮选择区的时候的光标闪烁时间，而
;; 一般没有光标同时我想要进行复制的场景是在 isearch 的情形下，所以这个配
;; 置放在这里也比较合理
(setq copy-region-blink-delay .1)

(defun fei-counsel-rg-from-isearch ()
  (interactive)
  (isearch-exit)
  (counsel-rg isearch-string))

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

(defun fei/isearch-occur ()
  (interactive)
  (call-interactively 'isearch-occur)
  (isearch-exit)
  ;; occur 没有匹配项的时候不会显示，下面的函数会报错
  (select-window (get-buffer-window "*Occur*")))

(provide 'init-search)
