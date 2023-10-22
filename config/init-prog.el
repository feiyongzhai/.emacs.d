(require 'init-lisp)
(require 'init-python)
(require 'x-rust)
(require 'init-matlab)
(require 'init-c)
(require 'init-web)
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

(provide 'init-prog)
;; use `add-file-local-variable' to change `outline-regexp' for a single file

;; Local Variables:
;; outline-regexp: ";;;+"
;; End:
