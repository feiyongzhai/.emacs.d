;;; init-counsel.el  --- configs for counsel/swiper/ivy

;;; Code:

;;; Add to `user/package-ensure-installed'
(add-to-list 'user/package-ensure-installed 'swiper)
(add-to-list 'user/package-ensure-installed 'counsel)
(add-to-list 'user/package-ensure-installed 'ivy)
(add-to-list 'user/package-ensure-installed 'ctrlf)

;; (global-set-key (kbd "M-y") 'counsel-yank-pop)
;; (define-key ivy-minibuffer-map (kbd "M-y") #'next-line)

;;; counsel-search
(define-key global-map (kbd "M-p") 'user/google-search)
(setq counsel-search-engine 'google)

;;; 参考链接：https://liujiacai.net/blog/2020/11/25/why-emacs/
(defun user/google-search ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))

;;; counsel-rg
(define-key global-map (kbd "C-c M-r") #'counsel-rg)

;;; counsel-git
(define-key global-map (kbd "C-c M-g") #'counsel-git)

;;; counsel-bookmark
(global-set-key (kbd "C-c B") 'counsel-bookmark)

;;; ivy-views
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)

;;; config for swiper, including counsel and ivy
;; 现在好像直接写这么一句话就可以了，下面这些键绑定都不需要了
(ivy-mode 1)

;; 这个配置似乎可以自动调用 recentf-mode 
(setq ivy-use-virtual-buffers nil)
;; 按键
(define-key global-map (kbd "C-r") #'counsel-recentf)

(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)

(ctrlf-mode 1)
(with-eval-after-load 'ctrlf
  (add-to-list 'ctrlf-minibuffer-bindings '("C-p" . ctrlf-previous-match))
  (add-to-list 'ctrlf-minibuffer-bindings '("C-n" . ctrlf-next-match))
)

;; (global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
;;(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; 这个配置会使得 M-* 类别的键失效
;; (define-key ivy-minibuffer-map (kbd "<ESC>") 'minibuffer-keyboard-quit)

;;; some tweaks about ivy
;; (require 'counsel)
;; 用 `with-eval-after-load' 代替 `require'
(with-eval-after-load 'counsel
  (setq-default ivy-initial-inputs-alist
		'((counsel-minor . "^+")
		  (counsel-package . "^+")
		  (counsel-org-capture . "^")
		  (counsel-M-x . ignore)
		  (counsel-describe-function . "^")
		  (counsel-describe-variable . "^")
		  (org-refile . "^")
		  (org-agenda-refile . "^")
		  (org-capture-refile . "^")
		  (Man-completion-table . "^")
		  (woman . "^"))))

;; 让 ivy 的显示移到中间来，使用中发现一个问题，输入法光标不跟随
;; (ivy-posframe-mode 1)
;; (setq ivy-posframe-display-functions-alist
;;     '((swiper . ivy-posframe-display-at-frame-center)
;;       (complete-symbol . ivy-posframe-display-at-point)
;;       (counsel-M-x . ivy-posframe-display-at-frame-center)
;;       (counsel-find-file . ivy-posframe-display-at-frame-center)
;;       (ivy-switch-buffer . ivy-posframe-display-at-frame-center)
;;       (t . ivy-posframe-display-at-frame-center)))

;;; ivy-rich-mode: ivy enhance
;; (ivy-rich-mode 1)

(provide 'init-counsel)
;;; init-counsel.el ends here.
