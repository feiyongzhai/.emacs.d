;;; init-counsel.el  --- configs for counsel/swiper/ivy

;;; Code:

;;; counsel-search
(setq counsel-search-engine 'google)

;;; counsel-bookmark
(global-set-key (kbd "C-c B") 'counsel-bookmark)
(global-set-key (kbd "C-c b") 'list-bookmarks)

;;; ivy-views
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-switch-view)

;;; config for swiper, including counsel and ivy
(ivy-mode 1)

(setq ivy-use-virtual-buffers nil)
(global-set-key (kbd "C-c C-r") #'counsel-recentf)

(setq enable-recursive-minibuffers t)
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key (kbd "C-c M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c l") 'counsel-locate)

;;; some tweaks about ivy
(with-eval-after-load 'counsel
  (setq-default ivy-initial-inputs-alist nil))


(provide 'init-counsel)
;;; init-counsel.el ends here.
