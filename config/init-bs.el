;; Powered by builtin package `bs'

(setq bs-default-configuration "all")

(defun fei-bs-not-dired (buf)
  (with-current-buffer buf
    (not (eq major-mode 'dired-mode))))

(defun fei-bs-not-eaf (buf)
  (with-current-buffer buf
    (not (eq major-mode 'eaf-mode))))

(defun fei-bs-not-eww/w3m (buf)
  (with-current-buffer buf
    (not (or (eq major-mode 'eww-mode)
	     (eq major-mode 'w3m-mode)))))

(defun fei-bs-not-eshell/term (buf)
  (with-current-buffer buf
    (not (or (eq major-mode 'eshell-mode)
	     (eq major-mode 'term-mode)))))

(defun fei-bs-not-org (buf)
  (with-current-buffer buf
    (not (eq major-mode 'org-mode))))

(defun fei-bs-not-cur-major-mode (buf)
  (with-current-buffer buf
    (not (eq major-mode bs-cur-major-mode))))

(defun fei-bs-not-have-same-base-name (buf)
  (with-current-buffer buf
    (not (string= (file-name-base bs-cur-buffer-name)
		  (file-name-base (buffer-name))))))

(defun fei-bs-get-current-buffer-list ()
  (mapcar (lambda (buf) (buffer-name buf)) bs-current-list))

(defun fei-switch-to-buffer-from-bs ()
  (interactive)
  (let ((buf (completing-read
	      "Switch to buffer: "
	      (fei-bs-get-current-buffer-list))))
    (bs-kill)
    (switch-to-buffer buf)))

(defun fei-bs-set-configuration-default (conf)
  (bs-set-configuration conf)
  (setq bs-default-configuration bs-current-configuration)
  (bs-refresh))

(defun fei-bs-switch-buffer-other-tab ()
  (interactive)
  (let ((buf (bs--current-buffer)))
    (bs-kill)
    (switch-to-buffer-other-tab buf)))

;; @REF https://emacs.stackexchange.com/questions/65094/how-to-quickly-cycles-through-buffers-of-the-same-major-mode-as-current-one
(defun fei-bs-show ()
  (interactive)
  (setq bs-cur-major-mode major-mode)
  (setq bs-cur-buffer-name (buffer-name))
  (call-interactively 'bs-show))

(add-hook 'bs-mode-hook 'hl-line-mode)
(setq bs-configurations
      '(("all" nil nil nil nil nil)
	("not-all" nil nil nil (lambda (buf) t))
	("files" nil nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)
	("dired" nil nil nil fei-bs-not-dired bs-sort-buffer-interns-are-last)
	("files-and-scratch" "^\\*scratch\\*$" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)
	("EAF" nil nil nil fei-bs-not-eaf bs-sort-buffer-interns-are-last)
	("eshell-and-term" nil nil nil fei-bs-not-eshell/term bs-sort-buffer-interns-are-last)
	("eww-and-w3m" nil nil nil fei-bs-not-eww/w3m bs-sort-buffer-interns-are-last)
	("same-major" nil nil nil fei-bs-not-cur-major-mode bs-sort-buffer-interns-are-last)
	("same-base-name" nil nil nil fei-bs-not-have-same-base-name bs-sort-buffer-interns-are-last)
	("Org" nil nil nil fei-bs-not-org bs-sort-buffer-interns-are-last)
	("all-intern-last" nil nil nil nil bs-sort-buffer-interns-are-last)
	))

(with-eval-after-load 'bs
  (define-key bs-mode-map (kbd "w") (li (fei-bs-set-configuration-default "eww-and-w3m")))
  (define-key bs-mode-map (kbd "a") (li (fei-bs-set-configuration-default "all")))
  (define-key bs-mode-map (kbd ";") (li (fei-bs-set-configuration-default "not-all")))
  (define-key bs-mode-map (kbd "A") 'bs-toggle-show-all)
  (define-key bs-mode-map (kbd "d") (li (fei-bs-set-configuration-default "dired")))
  (define-key bs-mode-map (kbd "C-j") 'bs-select)
  (define-key bs-mode-map (kbd "C-c j") (li (bs-kill) (call-interactively 'counsel-recentf)))
  (define-key bs-mode-map (kbd "C-k") 'bs-delete)
  (define-key bs-mode-map (kbd "e") (li (fei-bs-set-configuration-default "eshell-and-term")))
  (define-key bs-mode-map (kbd "E") (li (fei-bs-set-configuration-default "EAF")))
  (define-key bs-mode-map (kbd "h") (li (fei-bs-set-configuration-default "same-major")))
  (define-key bs-mode-map (kbd "H") (li (fei-bs-set-configuration-default "same-base-name")))
  (define-key bs-mode-map (kbd "O") (li (fei-bs-set-configuration-default "Org")))
  (define-key bs-mode-map (kbd "i") (li (bs-kill) (ibuffer)))
  (define-key bs-mode-map (kbd "j") 'fei-switch-to-buffer-from-bs)
  (define-key bs-mode-map (kbd "k") 'nil) ;default is `bs-delete', 但是最近总是误触
  (define-key bs-mode-map (kbd "f") (li (fei-bs-set-configuration-default "files")))
  (define-key bs-mode-map (kbd "C-t") 'fei-bs-switch-buffer-other-tab)
  )

(provide 'init-bs)
