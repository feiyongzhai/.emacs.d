(setq fei-search-prompt
      (concat "[b/B] B站/Bing [w/i] Wikipedia/Github [h/c] 汉典/词典 [y] YouTube \n"
	      "[s/S/M-s] 学术/搜狗/StackOverFlow [d/D] 百度/DuckDuckGo [g/i] 谷歌/图片"))

;; 抖音
(defun eshell/dy (&rest search-string)
  (let ((word (eshell-flatten-and-stringify search-string)))
    (browse-url
     (if (string-empty-p word)
	 "https://www.douyin.com"
       (concat "https://www.douyin.com/search/" word)))))

;; 微信
(defengine weixin "https://weixin.sogou.com/weixin?type=2&query=%s")

(defun eshell/weixin (&rest search-string)
  (browse-url
   (concat
    "https://weixin.sogou.com/weixin?type=2&query="
    (eshell-flatten-and-stringify search-string))))

;; 汉典
(defengine 汉典
  "https://www.zdic.net/hans/%s"
  :keybinding "h")

;; Github
(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "i")

(defun eshell/github (&rest search-string)
  (let ((word (eshell-flatten-and-stringify search-string)))
    (browse-url
     (if (string-empty-p word)
	 "https://www.github.com"
       (concat "https://github.com/search?ref=simplesearch&q=" word)))))

;; Stackoverflow
(defengine stackoverflow
  "https://stackoverflow.com/search?q=%s"
  :keybinding "M-s")

;; 谷歌图片
;; (defengine google-images
;;   "http://www.google.com/images?hl=en&source=hp&biw=1440&bih=795&gbv=2&aq=f&aqi=&aql=&oq=&q=%s"
;;   :keybinding "i")

;; 维基百科
(defengine wikipedia
  "https://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w"
  :docstring "Search Wikipedia!")

;; Qwant
(defengine qwant
  "https://www.qwant.com/?q=%s"
  :keybinding "q"
  :docstring "Qwant")

;; DuckDuckgo
(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  :keybinding "D")

(defun eshell/ddg (&rest search-string)
  (browse-url
   (concat
    "https://duckduckgo.com/?q="
    (eshell-flatten-and-stringify search-string))))

;; 谷歌学术
(defengine google-scholar
  "https://scholar.google.com/scholar?hl=zh-CN&q=%s"
  :keybinding "s")

(defun eshell/gs (&rest search-string)
  (browse-url
   (concat
    "https://scholar.google.com/scholar?hl=zh-CN&q="
    (eshell-flatten-and-stringify search-string))))

;; YouTube
(defengine youtube
  "http://www.youtube.com/results?aq=f&oq=&search_query=%s"
  :keybinding "y")

(defun eshell/yt (&rest search-string)
  (interactive)
  (let ((word (eshell-flatten-and-stringify search-string)))
    (browse-url
     (if (string-empty-p word)
	 "https://www.youtube.com"
       (concat "http://www.youtube.com/results?aq=f&oq=&search_query=" word)))))

;; 知乎
(defengine zhihu
  "https://www.zhihu.com/search?type=content&q=%s"
  :keybinding "z"
  :docstring "知乎")

(defun eshell/zhihu (&rest search-string)
  (browse-url
   (concat
    "https://www.zhihu.com/search?type=content&q="
    (eshell-flatten-and-stringify search-string))))

;; B站
(defengine bilibili
  "https://search.bilibili.com/all?keyword=%s"
  :keybinding "b"
  :docstring "哔哩哔哩")

(defun eshell/blbl (&rest search-string)
  (interactive)
  (let ((word (eshell-flatten-and-stringify search-string)))
    (browse-url
     (if (string-empty-p word)
	 "https://www.bilibili.com"
       (concat "https://search.bilibili.com/all?keyword=" word)))))

;; 网易公开课
(defun eshell/wy (&rest search-string)
  (let ((word (eshell-flatten-and-stringify search-string)))
    (browse-url
     (if (string-empty-p word)
	 "https://open.163.com"
       (concat "https://open.163.com/newview/search/" word)))))

;; 京东
(defun eshell/jd (&rest search-string)
  (let ((word (eshell-flatten-and-stringify search-string)))
    (browse-url
     (if (string-empty-p word)
	 "https://www.jd.com"
       (concat "https://search.jd.com/Search?keyword=" word)))))

;; 必应
(defengine bing
  "https://www.bing.com/search?q=%s"
  :keybinding "B")

;; 必应词典
(defengine bing-dict
  "https://www.bing.com/dict/search?q=%s"
  :docstring "bing dictionary 不知道什么原因，和浏览器有关，默认如果是 firefox 不行，是 chrome 行"
  :keybinding "C")

;; 趣词词典
(defengine quword
  "https://www.quword.com/w/%s"
  :docstring "趣词词典"
  :keybinding "c")

(defun eshell/dict (&rest search-string)
  (browse-url
   (concat
    "https://www.quword.com/w/"
    (eshell-flatten-and-stringify search-string))))

;; 谷歌
(defengine google
  "https://www.google.com/search?ie=utf-8&q=%s"
  :keybinding "g")

(defun eshell/g (&rest search-string)
  (browse-url
   (concat
    "https://www.google.com.hk/search?ie=utf-8&oe=utf-8&q="
    ;; 用下面的链接会出现总是让你人机验证的问题（实验室台式机遇到的 Deepin）
    ;; 目前定位到的是：一个是 https ，另一个是 .hk 必须两个都有
    ;; "https://www.google.com/search?ie=utf-8&oe=utf-8&q="
    ;; "http://www.google.com.hk/search?ie=utf-8&oe=utf-8&q="
    ;; "https://www.google.com/search?q="
    (eshell-flatten-and-stringify search-string))))

;; 百度
(defengine baidu
  "https://www.baidu.com/s?wd=%s"
  :keybinding "d")

(defun eshell/baidu (&rest search-string)
  (browse-url
   (concat
    "https://www.baidu.com/s?wd="
    (eshell-flatten-and-stringify search-string))))

;; 搜狗
(defengine sogou
  "https://www.sogou.com/web?query=%s"
  :keybinding "S")

(defun eshell/sg (&rest search-string)
  (browse-url
   (concat
    "https://www.sogou.com/web?query="
    (eshell-flatten-and-stringify search-string))))


(provide 'init-engine)
