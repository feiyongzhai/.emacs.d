;; 朴素的想法：之前给 EMACS 设置快捷键的时候总是不想占用 EMACS 原生的按键，但是随着快捷键越设越多，发现有点不够用。
;; 现在想通过把自己的快捷键放到一个 minor-mode 层上，就不用在意占用 EMACS 原生的快捷键了。
;; mode 的方式可以快速开启和关闭，方便切换

(defvar fei-key-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "M-a") 'org-agenda-list)
    (define-key map (kbd "M-c") 'fei-org-capture-TODO)
    map))

(define-minor-mode fei-key-mode
  "我的按键层"
  :global t
  :lighter " 飞"
  :keymap fei-key-mode-map
  (if fei-key-mode
      (message " 🥏 飞 开启！")
    (message " 🦉 飞 关闭！")))

;; 示意按键
(define-key fei-key-mode-map (kbd "M-u") 'eshell)
(define-key fei-key-mode-map (kbd "C-M-g") 'fei-vc-dired-jump)
(define-key fei-key-mode-map (kbd "C-M-v") 'vc-next-action)
(define-key fei-key-mode-map (kbd "M-q") 'quit-window)
(define-key fei-key-mode-map (kbd "M-g") (kbd "C-g"))

(provide 'fei-key)
