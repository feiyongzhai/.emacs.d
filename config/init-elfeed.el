;;; Vars

(setq elfeed-feeds
      '(("http://www.solidot.org/index.rss" Solidot)
	("https://manateelazycat.github.io/feed.xml" ManateeLazyCat)
	("https://emacstalk.github.io/podcast/index.xml" EmacsTalk)
        ;; ("https://karthinks.com/index.xml" Karthinks)
        ;; ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0uTPqBCFIpZxlz_Lv1tk_g" personal video)
	;; ("https://sachachua.com/blog/feed/" SachaChua)
        ;; ("https://planet.emacslife.com/atom.xml" emacs community)
	;; ("https://emacs-china.org/latest.rss" emacs)
        ;; ("http://feed.pippa.io/public/shows/teamhuman" podcast culture)
	;; ("http://www.geekpark.net/rss" 极客公园)
	;; ("https://www.zhihu.com/rss" 知乎)
	;; ("https://sspai.com/feed" sspai)
	))

;;; Keys

(with-eval-after-load 'elfeed
  (define-key elfeed-search-mode-map (kbd "f") 'elfeed-search-show-entry))

;; (setq shr-inhibit-images t) ;nil

(provide 'init-elfeed)
