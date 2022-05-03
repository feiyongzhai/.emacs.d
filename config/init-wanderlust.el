(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(setq
  wl-smtp-connection-type   'ssl	      ; Use TLS
  wl-smtp-posting-port      465               ; The SMTP port
  wl-smtp-authenticate-type "login"           ; Authentication type
  wl-smtp-posting-user      "yongfeizhai"          ; Username
  wl-smtp-posting-server    "smtp.qq.com"  ; SMTP server
  wl-local-domain           "qq.com"       ; The SMTP server again
  wl-message-id-domain      "smtp.qq.com") ; And... Again?


(setq wl-from "yongfeizhai <yongfeizhai@qq.com>")

(with-eval-after-load 'wl
  (setq wl-message-ignored-field-list
      '(".")
      wl-message-visible-field-list
      '("^\\(To\\|Cc\\):"
        "^Subject:"
        "^\\(From\\|Reply-To\\):"
        "^\\(Posted\\|Date\\):"
        "^Organization:"
        "^X-\\(Face\\(-[0-9]+\\)?\\|Weather\\|Fortune\\|Now-Playing\\):")
      wl-message-sort-field-list
      (append wl-message-sort-field-list
              '("^Reply-To" "^Posted" "^Date" "^Organization"))))

(provide 'init-wanderlust)
