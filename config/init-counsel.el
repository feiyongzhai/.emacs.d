;;; init-counsel.el  --- configs for counsel/swiper/ivy

;;; Mode
(ivy-mode 1)

;;; Vars

;;; counsel-search
(setq counsel-search-engine 'google)

(setq ivy-use-virtual-buffers nil)
(setq enable-recursive-minibuffers t)

;; (setq search-default-mode #'char-fold-to-regexp)

(with-eval-after-load 'counsel
  (setq-default ivy-initial-inputs-alist nil))

(provide 'init-counsel)
;;; init-counsel.el ends here.
