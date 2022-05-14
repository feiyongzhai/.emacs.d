;;; init-company-yasnippet.el --- configs for company
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

(setq company-minimum-prefix-length 1
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

;; ==== Yasnippet ====
(yas-global-mode)
(global-set-key (kbd "C-x y") 'yas-insert-snippet)
(global-set-key (kbd "C-M-y") 'company-yasnippet)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-M-y") 'fei-company-yasnippet) ;这个设计的不是很完美，不过也不经常用，不管了
  (defun fei-company-yasnippet ()
    "Hide the current completeions and show snippets."
    (interactive)
    (company-cancel)
    (call-interactively 'company-yasnippet)))

;; @REF: http://joaotavora.github.io/yasnippet/snippet-expansion.html
(with-eval-after-load 'yasnippet
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "M-i") yas-maybe-expand) ;注意： `yas-maybe-expand' 是一个 variable
  (define-key yas-keymap (kbd "M-n") 'yas-next-field)
  (define-key yas-keymap (kbd "M-p") 'yas-prev-field)
  (define-key yas-keymap (kbd "M-i") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "M-I") 'yas-prev-field)
  )

(with-eval-after-load 'yasnippet
  (yas-load-directory (expand-file-name "~/.emacs.d/snippets") t))

(provide 'init-company-yasnippet)
