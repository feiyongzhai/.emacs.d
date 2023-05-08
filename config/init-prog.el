(require 'init-lisp)
(require 'init-python)
(require 'init-rust)
(require 'init-matlab)
(require 'init-c)
(require 'init-web)
(require 'hideshowvis)

;; indent
(setq-default indent-tabs-mode nil)	;space 代替 tab

;; highlight-indent-guides emacs-china 上说比较慢，还没有体验到
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-responsive 'top)

;;; prog-mode-hook
(add-hook 'prog-mode-hook '+fei-prog-hook)
(defun +fei-prog-hook ()
  (outline-minor-mode t)
  (company-mode t)
  (hs-minor-mode t)
  ;; (hl-line-mode t)
  (diff-hl-mode t)
  (toggle-truncate-lines 1)
  (highlight-indent-guides-mode)
  (hideshowvis-enable)
  (hideshowvis-symbols)
  (yas-minor-mode t))

;;; Octave
(add-hook 'octave-mode-hook 'electric-pair-local-mode)

;;; Yaml
;; yaml-mode 居然不是 prog-mode
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)
(add-hook 'yaml-mode-hook 'fei-yaml-mode-hook)

(defun fei-yaml-mode-hook ()
  (toggle-truncate-lines 1))

;;; AHK
(setq ahk-indentation 4)

(provide 'init-prog)
;; use `add-file-local-variable' to change `outline-regexp' for a single file

;; Local Variables:
;; outline-regexp: ";;;+"
;; End:
