;;; init-var.el --- variable for initial time

;;;;;;;;;;;;;;;;;;;;;;; 用于判断系统的变量 ;;;;;;;;;;;;;;;;;;;;
(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))

(provide 'init-var)
;;; init-var.el ends here.
