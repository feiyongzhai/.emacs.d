(require 'auth-source) ;; probably not necessary
(setq auth-sources '("~/.emacs.d/.authinfo"))

(setq message-send-mail-function 'smtpmail-send-it)
(setq user-mail-address "yongfeizhai@qq.com")
(setq user-full-name "yongfeizhai")

(setq smtpmail-smtp-user "yongfeizhai@qq.com"
      smtpmail-smtp-server "smtp.qq.com"
      smtpmail-smtp-service 465
      smtpmail-stream-type 'ssl
      message-auto-save-directory "~/Mail/drafts")

;;Debug
(setq smtpmail-debug-info t)
(setq smtpmail-debug-verb t)

(setq gnus-select-method
      '(nnimap "qq.com"
	       (nnimap-address "imap.qq.com")
	       (nnimap-inbox "INBOX")
	       (nnimap-expunge t)
	       (nnimap-server-port 993)
	       (nnimap-stream ssl)))

(provide 'init-mail)
