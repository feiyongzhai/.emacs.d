(setq webjump-sites
      (append '(
		("Google xueshu" .
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
		("github" .
		 [simple-query "www.github.com" "https://github.com/search?ref=simplesearch&q=" ""])
		("blog" . "feiyongzhai.github.io")
		("Emacs China" .
		 [simple-query "emacs-china.org" "https://emacs-china.org/search?q=" ""])
		("YouTube" .
		 [simple-query "youtube.com" "http://www.youtube.com/results?aq=f&oq=&search_query=" ""])
                )
              webjump-sample-sites))

(provide 'init-webjump)