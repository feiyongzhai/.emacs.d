;;; 网上搜集的一些函数


;; url%文本编码和解码
(defun xah-html-decode-percent-encoded-url ()
  "Decode percent encoded URL of current line or selection.

     Example:
      %28D%C3%BCrer%29
     becomes
      (Dürer)

     Example:
      %E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8
     becomes
      文本编辑器

     URL `http://ergoemacs.org/emacs/emacs_url_percent_decode.html'
     Version 2018-10-26"
  (interactive)
  (let ( $p1 $p2 $input-str $newStr)
    (if (use-region-p)
	(setq $p1 (region-beginning) $p2 (region-end))
      (setq $p1 (line-beginning-position) $p2 (line-end-position)))
    (setq $input-str (buffer-substring-no-properties $p1 $p2))
    (require 'url-util)
    ;; core function1 `url-unhex-string'
    (setq $newStr (url-unhex-string $input-str))
    (if (string-equal $newStr $input-str)
	(progn (message "no change" ))
      (progn
	(delete-region $p1 $p2)
	;; core function2 `decode-coding-string'
	(insert (decode-coding-string $newStr 'utf-8))))))

(defun xah-html-encode-percent-encoded-url ()
  "Percent encode URL in current line or selection.

Example:
    http://example.org/(Dürer)
becomes
    http://example.org/(D%C3%BCrer)

Example:
    http://example.org/文本编辑器
becomes
    http://example.org/%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8

URL `http://ergoemacs.org/emacs/emacs_url_percent_decode.html'
Version 2018-10-26"
  (interactive)
  (let ($p1 $p2 $input-str $newStr)
    (if (use-region-p)
	(setq $p1 (region-beginning) $p2 (region-end))
      (setq $p1 (line-beginning-position) $p2 (line-end-position)))
    (setq $input-str (buffer-substring-no-properties $p1 $p2))
    (require 'url-util)
    ;; core function for encoding `url-encode-url'
    (setq $newStr (url-encode-url $input-str))
    (if (string-equal $newStr $input-str)
	(progn (message "no change" ))
      (progn
	(delete-region $p1 $p2)
	(insert $newStr)))))
