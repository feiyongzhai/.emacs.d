(setq TeX-save-query nil)
(setq TeX-electric-escape nil)	     ; 打开的时候有点烦人
(setq font-latex-fontify-script nil) ; 使用朴素的上下标样式，auctex 的配置
;; (setq tex-fontify-script nil)	  ;使用朴素的上下标样式，自带 tex 的配置

(defun reftex-toc-mode-hor-or-ver ()
  (interactive)
  (if reftex-toc-split-windows-horizontally
      (progn
	(reftex-toc-quit)
	(setq reftex-toc-split-windows-horizontally nil)
	(call-interactively 'reftex-toc))
    (reftex-toc-quit)
    (setq reftex-toc-split-windows-horizontally t)
    (call-interactively 'reftex-toc)))

(with-eval-after-load 'reftex-toc
  (define-key reftex-toc-mode-map (kbd "v") 'reftex-toc-mode-hor-or-ver))

;; @REF: https://ks3-cn-beijing.ksyun.com/attachment/9ff9efaf747469424f48741629013db1
;; @REF: https://emacs-china.github.io/emacsist/blog/2016/10/26/2016-10-23%E5%A6%82%E4%BD%95%E6%90%AD%E5%BB%BAemacs-latex-make%E5%B7%A5%E5%85%B7%E9%93%BE/
;; vscode 的 latex 配置简单好用，emacs 输

(add-hook 'LaTeX-mode-hook #'reftex-mode)
(add-hook 'LaTeX-mode-hook #'visual-line-mode)
(add-hook 'LaTeX-mode-hook #'prettify-symbols-mode)
(add-hook 'LaTeX-mode-hook #'TeX-fold-mode) ;相应快捷键为 C-c C-o 开头

;; (imenu-add-menubar-index)

;; use xelatex engine
(with-eval-after-load 'latex
  ;; @ref https://github.com/yangsheng6810/dotfiles/blob/master/.spacemacs.d/init.org
  (add-to-list 'TeX-command-list
	       '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t)))


;; ==== Quick Input ====

(add-hook 'LaTeX-mode-hook #'cdlatex-mode)
(add-hook 'LaTeX-mode-hook #'yas-minor-mode)

;; (add-hook 'LaTeX-mode-hook #'company-mode) ;company is very annoying when written latex
;; (add-hook 'LaTeX-mode-hook (lambda () (setq-local company-backends '(company-yasnippet))))

(with-eval-after-load 'cdlatex
  ;; `cdlatex-pbb' 总是工作不符合预期
  (define-key cdlatex-mode-map (kbd "<") nil)
  (define-key cdlatex-mode-map (kbd "(") nil)
  (define-key cdlatex-mode-map (kbd "[") nil))

;; ===  Auto Expand option 1 (powered by `aas' & `laas') ===

(add-hook 'LaTeX-mode-hook #'laas-mode)
(add-hook 'org-mode-hook #'laas-mode)

(with-eval-after-load 'laas
  (aas-set-snippets 'laas-mode
    :cond (lambda () (and (not (texmathp)) (quote auto)))
    "dm" (li (yas-expand-snippet "\\[\n$0\n\\]"))
    "mk" (li (yas-expand-snippet (yas-lookup-snippet "Inline Math" 'latex-mode))) ;可以复用 yasnippets
    )
  (aas-set-snippets 'laas-mode
    :cond 'texmathp
    "st" "\\text{s.t.}"
    "qq" "\\quad"
    ",," "\\,"
    ;; ";;" "\\\\\n"			; laas 默认很多用 ;; 开头的 snippets，所以还是
    "\\\\" "\\\\\n"
    "KK" "^k"
    "pw" (li (yas-expand-snippet "^{$0}"))
    "sb" (li (yas-expand-snippet "\\symbf{$0}"))
    "bb" (li (yas-expand-snippet "\\mathbb{$0}"))
    ))

;; === Auto Expand option 2 (powered by `yasnippet' & `post-command-hook') ===

;; @REF: https://github.com/karthink/.emacs.d/blob/0d56c66c2e2d53ba05366493f433e523cc36cd87/init.el#L2943

;; (defun my/yas-try-expanding-auto-snippets ()
;;   (when (and (boundp 'yas-minor-mode) yas-minor-mode)
;;     (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
;;       (yas-expand))))
;; (add-hook 'post-self-insert-hook #'my/yas-try-expanding-auto-snippets)

(provide 'init-latex)
