;;; init-counsel.el  --- configs for counsel/swiper/ivy

;;; Mode
(ivy-mode 1)
(ivy-posframe-mode 1)

;;; Vars
(setq ivy-posframe-display-functions-alist
    '((t . ivy-posframe-display-at-frame-top-center)
      ))

;; (setq ivy-posframe-display-functions-alist
;;     '((swiper . ivy-posframe-display-at-frame-bottom-window-center)
;;       (complete-symbol . ivy-posframe-display-at-point)
;;       (counsel-M-x . ivy-posframe-display-at-frame-center)
;;       (counsel-find-file . ivy-posframe-display-at-frame-center)
;;       (ivy-switch-buffer . ivy-posframe-display-at-frame-center)))

(setq counsel-search-engine 'google)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; (setq search-default-mode #'char-fold-to-regexp)

(with-eval-after-load 'counsel
  (setq-default ivy-initial-inputs-alist nil))

(provide 'init-counsel)
;;; init-counsel.el ends here.

