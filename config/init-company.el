(require 'init-func)

(with-eval-after-load 'company
  (define-key company-mode-map (kbd "C-M-i") #'company-complete)
  (fei-define-key-with-map company-active-map
    '(("M-n" . company-select-next)
      ("M-p" . company-select-previous)
      ("C-h" . company-show-doc-buffer)
      ("M-i" . yas-expand)
      ("TAB" . company-complete-selection)
      ("M-h" . company-complete-selection)
      ("M-H" . company-complete-common)
      ("M-w" . company-show-location)
      ("M-s" . company-filter-candidates)
      ("M-/" . company-other-backend)
      ("M-g" . company-abort)
      ("C-w" . nil)
      ))

  (define-key company-search-map (kbd "M-n") 'company-select-next)
  (define-key company-search-map (kbd "M-p") 'company-select-previous)

  (add-to-list 'company-transformers 'delete-dups)
  )

(setq company-minimum-prefix-length 2	;为 1 的时候总是跳出来，很烦人
      ;; company-idle-delay 0.1
      company-tooltip-limit 10
      company-show-numbers t
      company-echo-delay (if (display-graphic-p) nil 0)
      company-tooltip-align-annotations t
      company-require-match nil
      company-dabbrev-ignore-case nil
      company-dabbrev-downcase nil
      company-global-modes '(not erc-mode message-mode help-mode
                                 gud-mode eshell-mode shell-mode))
;; 避免补全中文的一个workaround
(setq company-dabbrev-char-regexp "[-_a-zA-Z0-9]")

(provide 'init-company)
