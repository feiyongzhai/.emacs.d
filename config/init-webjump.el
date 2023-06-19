(setq webjump-sites
      (append '(("Google xueshu" .
		 [simple-query "scholar.google.com" "https://scholar.google.com/scholar?hl=zh-CN&q=" ""])
		("zhihu" .
		 [simple-query "www.zhihu.com" "https://www.zhihu.com/search?type=content&q=" ""])
		("bilibili" .
		 [simple-query "bilibili.com" "https://search.bilibili.com/all?keyword=" ""])
		("jd" .
		 [simple-query "www.jd.com" "https://search.jd.com/Search?keyword=" ""])
		("bing" .
		 [simple-query "www.bing.com" "https://www.bing.com/search?q=" ""])
		("quword" .
		 [simple-query "www.quword.com" "https://www.quword.com/w/" ""])
		("google" .
		 [simple-query "www.google.com" "https://www.google.com/search?ie=utf-8&q=" ""])
		("baidu" .
		 [simple-query "www.baidu.com" "https://www.baidu.com/s?wd=" ""])
		("sogou" .
		 [simple-query "www.sogou.com" "https://www.sogou.com/web?query=" ""])
		("weibo" .
		 [simple-query "www.weibo.com" "https://s.weibo.com/weibo?q=" ""])
		("github" .
		 [simple-query "www.github.com" "https://github.com/search?ref=simplesearch&q=" ""])
		("douyin" .
		 [simple-query "www.douyin.com" "https://www.douyin.com/search/" ""])
		("YouTube" .
		 [simple-query "youtube.com" "http://www.youtube.com/results?aq=f&oq=&search_query=" ""])
		("Emacs China" . "https://emacs-china.org")
		("blog" . "feiyongzhai.github.io")
		("Emacs Planet" . "https://planet.emacslife.com/")
		("HackNews" . "https://news.ycombinator.com/")
		("Google street" . "https://neal.fun/wonders-of-street-view/")
		("Steveshuo" . "http://steveshuo.com/")
		("cplusplus" . "https://cplusplus.com/")
		("cppsh" . "https://cpp.sh/")
		("cppsh" . "https://cpp.sh/")
		("cppreference" . "https://en.cppreference.com/w/")
		("clash" . "https://clash.razord.top/#/proxies")
                )
              webjump-sample-sites))

(provide 'init-webjump)
