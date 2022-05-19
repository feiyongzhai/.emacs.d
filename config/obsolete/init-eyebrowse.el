(require 'init-func)

;; Eyebrowse
(eyebrowse-mode 1)
(setq eyebrowse-new-workspace t)
(setq eyebrowse-mode-line-style 'current)

(fei-define-key-with-map global-map
  `(
    ("M-`" . eyebrowse-last-window-config)
    ("M-1" . eyebrowse-switch-to-window-config-1)
    ("M-2" . eyebrowse-switch-to-window-config-2)
    ("M-3" . eyebrowse-switch-to-window-config-3)
    ("M-4" . eyebrowse-switch-to-window-config-4)
    ("M-5" . eyebrowse-switch-to-window-config-5)
    ("M-6" . eyebrowse-switch-to-window-config-6)
    ("M-7" . eyebrowse-switch-to-window-config-7)
    ("M-8" . eyebrowse-switch-to-window-config-8)
    ("M-9" . eyebrowse-switch-to-window-config-9)
    ("M-0" . eyebrowse-switch-to-window-config-0)
    ))

(add-hook 'term-mode-hook '+fei-eyebrowse-term-mode-hook)

(defun +fei-eyebrowse-term-mode-hook ()
  ;; 占用了终端 native 的 M-num 的按键：不过这个按键也不常用，所以没什么问题
  (define-key term-raw-map (kbd "M-`") 'eyebrowse-last-window-config)
  (define-key term-raw-map (kbd "M-1") 'eyebrowse-switch-to-window-config-1)
  (define-key term-raw-map (kbd "M-2") 'eyebrowse-switch-to-window-config-2)
  (define-key term-raw-map (kbd "M-3") 'eyebrowse-switch-to-window-config-3)
  (define-key term-raw-map (kbd "M-4") 'eyebrowse-switch-to-window-config-4)
  (define-key term-raw-map (kbd "M-5") 'eyebrowse-switch-to-window-config-5)
  (define-key term-raw-map (kbd "M-6") 'eyebrowse-switch-to-window-config-6)
  (define-key term-raw-map (kbd "M-7") 'eyebrowse-switch-to-window-config-7)
  (define-key term-raw-map (kbd "M-8") 'eyebrowse-switch-to-window-config-8)
  (define-key term-raw-map (kbd "M-9") 'eyebrowse-switch-to-window-config-9)
  (define-key term-raw-map (kbd "M-0") 'eyebrowse-switch-to-window-config-0)
  )

(provide 'init-eyebrowse)
