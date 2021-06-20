;;; init-thing-edit.el --- config for `thing-edit'

;;; Commentary:

;; 源头       ：emacs-china: https://emacs-china.org/t/emacs/7980/20
;; thing-edit : https://github.com/manateelazycat/thing-edit
;; 配置参考   : https://pengpengxp.github.io/emacs/emacs_thing_edit_replace.html

;; (require 'thing-edit)

;;; Code:

(defvar user-thing-edit-map (make-sparse-keymap)
  "Keybinding for `thing-edit'")

;; Copy.
(fei-define-key-with-map user-thing-edit-map
  '(("w" . thing-copy-word)
    ("." . thing-copy-symbol)
    ("m" . thing-copy-email)
    ("f" . thing-copy-filename)
    ("u" . thing-copy-url)
    ("x" . thing-copy-sexp)
    ("t" . thing-copy-page)
    ("g" . thing-copy-sentence)
    ("o" . thing-copy-whitespace)
    ("i" . thing-copy-list)
    ("c" . thing-copy-comment)
    ("h" . thing-copy-defun)
    ("p" . thing-copy-parentheses)
    ("a" . thing-copy-to-line-beginning)
    ("e" . thing-copy-to-line-end)
    ("l" . thing-copy-line))
  "thing-edit")

;; Replace
(fei-define-key-with-map user-thing-edit-map
  '(("W" . thing-replace-word)
    (">" . thing-replace-symbol)
    ("M" . thing-replace-email)
    ("F" . thing-replace-filename)
    ("U" . thing-replace-url)
    ("X" . thing-replace-sexp)
    ("T" . thing-replace-page)
    ("G" . thing-replace-sentence)
    ("O" . thing-replace-whitespace)
    ("I" . thing-replace-list)
    ("C" . thing-replace-comment)
    ("H" . thing-replace-defun)
    ("P" . thing-replace-parentheses)
    ("L" . thing-replace-line))
  "thing-edit")

(global-set-key (kbd "M-o") user-thing-edit-map)

(provide 'init-thing-edit)
;;; init-thing-edit.el ends here
