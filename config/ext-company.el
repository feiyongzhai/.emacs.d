(require 'fei-funcs)

(with-eval-after-load 'company
  (add-to-list 'company-transformers 'delete-dups))

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

(provide 'ext-company)
