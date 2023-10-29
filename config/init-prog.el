(require 'init-c)
(require 'init-web)
(require 'init-lisp)
(require 'init-python)
(require 'init-matlab)
(require 'hideshowvis)

(setq-default indent-tabs-mode nil)	;缩进配置，space 代替 tab

;; highlight-indent-guides-mode 配置
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-responsive 'top)

(add-hook 'prog-mode-hook '+fei-prog-hook)
(defun +fei-prog-hook ()
  ;; (outline-minor-mode t)
  ;; (hl-line-mode t)
  ;; (highlight-indent-guides-mode)
  (company-mode t)
  (hs-minor-mode t)
  (diff-hl-mode t)
  (toggle-truncate-lines 1)
  (hideshowvis-enable)
  (hideshowvis-symbols)
  (yas-minor-mode t))

;;; Rust
(when *is-linux*
  (setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/.cargo/bin")))
  (setq exec-path (append exec-path (list (expand-file-name "~/.cargo/bin"))))
  (with-eval-after-load 'eshell
    (setq-default eshell-path-env (concat eshell-path-env ":" (expand-file-name "~/.cargo/bin"))))
  )

(add-hook 'rust-mode-hook 'electric-pair-local-mode)

;;; Octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)

;;; Yaml
;; yaml-mode 居然不是 prog-mode
(add-hook 'yaml-mode-hook 'fei-yaml-mode-hook)
(defun fei-yaml-mode-hook ()
  (highlight-indentation-mode)
  (toggle-truncate-lines 1))

;;; AHK
(setq ahk-indentation 4)

;;; Flutter
(linux
 (add-hook 'dart-mode-hook 'electric-pair-local-mode)
 (add-hook 'dart-mode-hook 'subword-mode)

 (setq flutter-sdk-path "~/.local/opt/flutter/")
 (setq lsp-dart-flutter-sdk-dir "~/.local/opt/flutter/"))

(provide 'init-prog)
;; use `add-file-local-variable' to change `outline-regexp' for a single file

;; Local Variables:
;; outline-regexp: ";;;+"
;; End:
