;; backward-forward
;; @REF: https://emacs-china.org/t/emacs/19171/17?u=yongfeizhai
(setq backward-forward-mark-ring-max 100)

(defun my/backward-forward-previous-location ()
  "A `backward-forward-previous-location' wrap for skip invalid locations."
  (interactive)
  (let ((purge (< backward-forward-mark-ring-traversal-position (1- (length backward-forward-mark-ring))))
        (recent (point-marker)))
    (backward-forward-previous-location)
    (when (and (equal recent (point-marker)) purge)
      (my/backward-forward-previous-location))))

(defun my/backward-forward-next-location ()
  "A `backward-forward-next-location' wrap for skip invalid locations."
  (interactive)
  (let ((purge (> backward-forward-mark-ring-traversal-position 0))
        (recent (point-marker)))
    (backward-forward-next-location)
    (when (and (equal recent (point-marker)) purge)
      (my/backward-forward-next-location))))

(global-set-key (kbd "M-,") 'my/backward-forward-previous-location)
(global-set-key (kbd "C-M-,") 'my/backward-forward-next-location)

(backward-forward-mode t)

(provide 'init-backward-forward)
