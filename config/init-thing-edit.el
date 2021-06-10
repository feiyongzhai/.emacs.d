;;; init-thing-edit.el --- config for `thing-edit'

;;; Commentary:

;; emacs-china: https://emacs-china.org/t/emacs/7980/20
;; 这个是我看到这个 package 的地方（源头）
;; thing-edit : https://github.com/manateelazycat/thing-edit
;; 上面是源码的 git 主页
;; 配置参考   : https://pengpengxp.github.io/emacs/emacs_thing_edit_replace.html
;; 根据上面的配置参考，我采用了新的快捷键定义方式

;;; Code:

(progn
  (require 'thing-edit)
  (defvar user-thing-edit-map (make-sparse-keymap)
    "Keybinding for `thing-edit'")

  ;; Copy.
  (define-key user-thing-edit-map (kbd "w") 'thing-copy-word)
  (define-key user-thing-edit-map (kbd "s") 'thing-copy-symbol)
  (define-key user-thing-edit-map (kbd "m") 'thing-copy-email)
  (define-key user-thing-edit-map (kbd "f") 'thing-copy-filename)
  (define-key user-thing-edit-map (kbd "u") 'thing-copy-url)
  (define-key user-thing-edit-map (kbd "x") 'thing-copy-sexp)
  (define-key user-thing-edit-map (kbd "t") 'thing-copy-page)
  (define-key user-thing-edit-map (kbd "g") 'thing-copy-sentence)
  (define-key user-thing-edit-map (kbd "o") 'thing-copy-whitespace)
  (define-key user-thing-edit-map (kbd "i") 'thing-copy-list)
  (define-key user-thing-edit-map (kbd "c") 'thing-copy-comment)
  (define-key user-thing-edit-map (kbd "h") 'thing-copy-defun)
  (define-key user-thing-edit-map (kbd "p") 'thing-copy-parentheses)
  (define-key user-thing-edit-map (kbd "a") 'thing-copy-to-line-beginning)
  (define-key user-thing-edit-map (kbd "e") 'thing-copy-to-line-end)
  (define-key user-thing-edit-map (kbd "l") 'thing-copy-line)


  ;; Replace
  (define-key user-thing-edit-map (kbd "W") 'thing-replace-word)
  (define-key user-thing-edit-map (kbd "S") 'thing-replace-symbol)
  (define-key user-thing-edit-map (kbd "M") 'thing-replace-email)
  (define-key user-thing-edit-map (kbd "F") 'thing-replace-filename)
  (define-key user-thing-edit-map (kbd "U") 'thing-replace-url)
  (define-key user-thing-edit-map (kbd "X") 'thing-replace-sexp)
  (define-key user-thing-edit-map (kbd "T") 'thing-replace-page)
  (define-key user-thing-edit-map (kbd "G") 'thing-replace-sentence)
  (define-key user-thing-edit-map (kbd "O") 'thing-replace-whitespace)
  (define-key user-thing-edit-map (kbd "I") 'thing-replace-list)
  (define-key user-thing-edit-map (kbd "C") 'thing-replace-comment)
  (define-key user-thing-edit-map (kbd "H") 'thing-replace-defun)
  (define-key user-thing-edit-map (kbd "P") 'thing-replace-parentheses)
  (define-key user-thing-edit-map (kbd "L") 'thing-replace-line)

  (global-set-key (kbd "C-z") user-thing-edit-map))

(provide 'init-thing-edit)
;;; init-thing-edit.el ends here
