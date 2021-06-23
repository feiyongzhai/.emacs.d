;;; Keys

(with-eval-after-load 'elfeed
  (define-key elfeed-search-mode-map (kbd "f") 'elfeed-search-show-entry))

;;; Vars

(setq elfeed-feeds
      '(("http://www.solidot.org/index.rss" Solidot)
	("https://sachachua.com/blog/feed/" SachaChua)
	("https://manateelazycat.github.io/feed.xml" ManateeLazyCat)
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0uTPqBCFIpZxlz_Lv1tk_g" personal video)
        ;; ("https://planet.emacslife.com/atom.xml" emacs community)
	;; ("https://emacs-china.org/latest.rss" emacs)
        ;; ("http://feed.pippa.io/public/shows/teamhuman" podcast culture)
	;; ("http://www.geekpark.net/rss" 极客公园)
	;; ("https://www.zhihu.com/rss" 知乎)
	;; ("https://sspai.com/feed" sspai)
	))

(setq shr-inhibit-images t)

(provide 'init-elfeed)
