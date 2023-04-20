(setq elfeed-feeds
      '(("http://www.solidot.org/index.rss" 奇客)
	("https://manateelazycat.github.io/feed.xml" 懒猫)
	("https://emacstalk.github.io/podcast/index.xml" emacstalk)
        ;; ("https://karthinks.com/index.xml" Karthinks)
        ;; ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0uTPqBCFIpZxlz_Lv1tk_g" personal video)
	("https://sachachua.com/blog/feed/" SachaChua)
        ;; ("https://planet.emacslife.com/atom.xml" emacsplanet)
        ("https://yukieyun.net/feed/" 沉默之沙)
        ("https://feeds.fireside.fm/steve/rss" steve说)
        ("https://www.changhai.org/feed.xml" 卢昌海个人主页)
	;; ("https://emacs-china.org/latest.rss" emacs)
        ;; ("http://feed.pippa.io/public/shows/teamhuman" podcast culture)
	;; ("http://www.geekpark.net/rss" 极客公园)
	("https://www.zhihu.com/rss" 知乎)
	;; ("https://sspai.com/feed" sspai)
	))

(unless *is-termux*
  (add-hook 'elfeed-show-mode-hook
	    (lambda ()
              (when (display-graphic-p)
		(olivetti-mode t))
	      (olivetti-set-width 80))))

(with-eval-after-load 'elfeed
  (face-spec-set 'elfeed-search-title-face '((t (:font "Sarasa Mono SC-12"))))
  )

;; (setq shr-inhibit-images t) ;nil

(provide 'init-elfeed)
