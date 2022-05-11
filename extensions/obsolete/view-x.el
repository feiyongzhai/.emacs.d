;;; Enhance read only buffer by view-mode

;; (add-hook 'read-only-mode-hook 'view-mode) ; 不要这么用，会无法 toggle read-only-mode
(setq view-read-only t)
(with-eval-after-load 'view
  (define-key view-mode-map (kbd "i") 'symbol-overlay-put)
  (define-key view-mode-map (kbd "<return>") 'youdao-dictionary-search-from-input)
  (define-key view-mode-map (kbd "o") 'fei-occur-for-mouse)
  (define-key view-mode-map (kbd "O") 'multi-occur-in-this-mode)
  (define-key view-mode-map (kbd "h") 'nil)
  (define-key view-mode-map (kbd "e") 'nil)
  (define-key view-mode-map (kbd "v") 'fei-search)
  (define-key view-mode-map (kbd "V") 'fei-search-1)
  (define-key view-mode-map (kbd "c") 'nil)
  (define-key view-mode-map (kbd "Q") 'nil)
  (define-key view-mode-map (kbd "q") 'nil)
  (define-key view-mode-map (kbd "w") 'nil)
  (define-key view-mode-map (kbd "z") 'nil)
  (define-key view-mode-map (kbd "s") 'swiper-isearch)
  (define-key view-mode-map (kbd "r") 'nil)
  (define-key view-mode-map (kbd "y") 'fei-youdao-at-point)
  (define-key view-mode-map (kbd ".") 'isearch-forward-symbol-at-point))
