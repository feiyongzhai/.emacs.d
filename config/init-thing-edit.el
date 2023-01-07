;;; init-thing-edit.el --- config for `thing-edit'

;;; Commentary:

;; 源头       ：emacs-china: https://emacs-china.org/t/emacs/7980/20
;; thing-edit : https://github.com/manateelazycat/thing-edit
;; 配置参考   : https://pengpengxp.github.io/emacs/emacs_thing_edit_replace.html

;; (require 'thing-edit)

;;; Code:

(defvar user-thing-edit-map (make-sparse-keymap)
  "Keybinding for `thing-edit'")

(global-set-key (kbd "M-o") user-thing-edit-map)

;; Copy.
(fei-define-key-with-map user-thing-edit-map
  '(("w" . thing-copy-word)
    ("s" . thing-copy-symbol)
    ("m" . thing-copy-email)
    ("f" . thing-copy-filename)
    ("u" . thing-copy-url)
    ("x" . thing-copy-sexp)
    ("t" . thing-copy-page)
    ("g" . thing-copy-sentence)
    ("o" . thing-copy-region-or-line)
    ("i" . thing-copy-list)
    ("c" . thing-copy-comment)
    ("d" . thing-copy-defun)
    ("p" . thing-copy-parentheses)
    ("a" . thing-copy-to-line-beginning)
    ("e" . thing-copy-to-line-end)
    ("l" . thing-copy-line))
  "thing-edit")

;; Cut
(fei-define-key-with-map user-thing-edit-map
  '(("W" . thing-cut-word)
    ("S" . thing-cut-symbol)
    ("M" . thing-cut-email)
    ("F" . thing-cut-filename)
    ("U" . thing-cut-url)
    ("X" . thing-cut-sexp)
    ("T" . thing-cut-page)
    ("G" . thing-cut-sentence)
    ("O" . thing-cut-region-or-line)
    ("I" . thing-cut-list)
    ("C" . thing-cut-comment)
    ("D" . thing-cut-defun)
    ("P" . thing-cut-parentheses)
    ("A" . thing-cut-to-line-beginning)
    ("E" . thing-cut-to-line-end)
    ("L" . thing-cut-line))
  "thing-edit")

;; Replace
(fei-define-key-with-map user-thing-edit-map
  '(("M-w" . thing-replace-word)
    ("M-s" . thing-replace-symbol)
    ("M-m" . thing-replace-email)
    ("M-f" . thing-replace-filename)
    ("M-u" . thing-replace-url)
    ("M-x" . thing-replace-sexp)
    ("M-t" . thing-replace-page)
    ("M-g" . thing-replace-sentence)
    ("M-o" . thing-replace-region-or-line)
    ("M-i" . thing-replace-list)
    ("M-c" . thing-replace-comment)
    ("M-d" . thing-replace-defun)
    ("M-p" . thing-replace-parentheses)
    ("M-l" . thing-replace-line))
  "thing-edit")


;; Other keys
(global-set-key (kbd "M-D") 'thing-cut-symbol)

(provide 'init-thing-edit)
;;; init-thing-edit.el ends here
