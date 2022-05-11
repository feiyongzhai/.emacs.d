(add-to-list 'load-path "~/Repos/lsp-bridge")

(require 'lsp-bridge)             ;; load lsp-bridge

(require 'lsp-bridge-orderless)   ;; make lsp-bridge support fuzzy match, optional
(require 'lsp-bridge-icon)        ;; show icon for completion items, optional

;; Enable auto completion in elisp mode.
(dolist (hook (list
               'emacs-lisp-mode-hook
               ))
  (add-hook hook (lambda ()
                   (setq-local corfu-auto t)
                   )))

;; Enable lsp-bridge.
(dolist (hook (list
               'c-mode-hook
               'c++-mode-hook
               ;; 'java-mode-hook
               'python-mode-hook
               ;; 'ruby-mode-hook
               ;; 'rust-mode-hook
               ;; 'elixir-mode-hook
               ;; 'go-mode-hook
               ;; 'haskell-mode-hook
               ;; 'haskell-literate-mode-hook
               ;; 'dart-mode-hook
               ;; 'scala-mode-hook
               ;; 'typescript-mode-hook
               ;; 'js2-mode-hook
               ;; 'js-mode-hook
               ;; 'tuareg-mode-hook
               ;; 'latex-mode-hook
               ;; 'Tex-latex-mode-hook
               ;; 'texmode-hook
               ;; 'context-mode-hook
               ;; 'texinfo-mode-hook
               ;; 'bibtex-mode-hook
               ))
  (add-hook hook (lambda ()
                   (setq-local corfu-auto nil)  ;; let lsp-bridge control when popup completion frame
                   (lsp-bridge-mode 1)
		   (company-mode -1)
		   (corfu-mode 1)
                   )))

(add-hook 'lsp-bridge-mode-hook
	  (lambda ()
	    (local-set-key (kbd "M-.") 'lsp-bridge-find-def)
	    (local-set-key (kbd "C-.") 'lsp-bridge-find-references)))

(provide 'init-lsp-bridge)
