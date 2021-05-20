;;; init-counsel.el  --- configs for counsel/swiper/ivy

;;; Code:

;;; Add to `fei-package-ensure-installed'
(add-to-list 'fei-package-ensure-installed 'swiper)
(add-to-list 'fei-package-ensure-installed 'counsel)
(add-to-list 'fei-package-ensure-installed 'ivy)
(add-to-list 'fei-package-ensure-installed 'ctrlf)
(add-to-list 'fei-package-ensure-installed 'anzu)

;; (global-set-key (kbd "M-y") 'counsel-yank-pop)
;; (define-key ivy-minibuffer-map (kbd "M-y") #'next-line)

;;; counsel-search
;; (define-key global-map (kbd "M-p") 'counsel-search)
(setq counsel-search-engine 'google)

;;; counsel-bookmark
(global-set-key (kbd "C-c B") 'counsel-bookmark)
(global-set-key (kbd "C-c b") 'list-bookmarks)

;;; ivy-views
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-switch-view)

;;; config for swiper, including counsel and ivy
;; 现在好像直接写这么一句话就可以了，下面这些键绑定都不需要了
(ivy-mode 1)

;; 这个配置似乎可以自动调用 recentf-mode 
(setq ivy-use-virtual-buffers nil)
;; 按键
(define-key global-map (kbd "C-c C-r") #'counsel-recentf)

(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)

;; (ctrlf-mode 1)
(global-anzu-mode t)
(define-key isearch-mode-map (kbd "C-n") #'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-p") #'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "M->") #'isearch-end-of-buffer)
(define-key isearch-mode-map (kbd "M-<") #'isearch-beginning-of-buffer)
(with-eval-after-load 'ctrlf
  (add-to-list 'ctrlf-minibuffer-bindings '("C-p" . ctrlf-previous-match))
  (add-to-list 'ctrlf-minibuffer-bindings '("C-n" . ctrlf-next-match))
)

;; (global-set-key "\C-s" 'swiper)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-c l") 'counsel-locate)
;; 这个配置会使得 M-* 类别的键失效
;; (define-key ivy-minibuffer-map (kbd "<ESC>") 'minibuffer-keyboard-quit)

;;; some tweaks about ivy
(with-eval-after-load 'counsel
  (setq-default ivy-initial-inputs-alist nil))

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
