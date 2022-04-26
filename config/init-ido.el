;; Fido
(setq icomplete-compute-delay 0)

;; Ido
(setq ido-enable-flex-matching t)
(setq ido-use-virtual-buffers nil)
;; (setq ido-max-window-height 1)
;; Disable auto merge work directories behavior, But you can merge
;; manually by M-s, undo merge by C-z manually
(setq ido-auto-merge-work-directories-length -1)

(define-key ido-common-completion-map (kbd "C-M-j") 'ido-select-text)

(provide 'init-ido)
