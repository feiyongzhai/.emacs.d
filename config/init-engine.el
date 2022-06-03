(global-set-key (kbd "C-c /") 'webjump)
(global-set-key (kbd "C-c SPC") 'engine-mode-prefixed-map)
(with-eval-after-load 'engine-mode
  (define-key engine-mode-prefixed-map (kbd "SPC") 'fei-search-1))
(global-set-key (kbd "C-h C-y") 'engine/search-quword)
(global-set-key (kbd "C-<return>") 'engine/search-汉典)
(global-set-key (kbd "C-c C-SPC") 'engine/search-汉典)

(setq fei-search-prompt
      (concat "[b/B] B站/Bing [w/i] Wikipedia/Github [h/c] 汉典/词典 [y] YouTube \n"
	      "[s/S/M-s] 学术/搜狗/StackOverFlow [d/D] 百度/DuckDuckGo [g/i] 谷歌/图片"))

(defengine 汉典
  "https://www.zdic.net/hans/%s"
  :keybinding "h")

(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "i")

(defengine stackoverflow
  "https://stackoverflow.com/search?q=%s"
  :keybinding "M-s")

;; (defengine google-images
;;   "http://www.google.com/images?hl=en&source=hp&biw=1440&bih=795&gbv=2&aq=f&aqi=&aql=&oq=&q=%s"
;;   :keybinding "i")

(defengine wikipedia
  "https://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w"
  :docstring "Search Wikipedia!")

(defengine qwant
  "https://www.qwant.com/?q=%s"
  :keybinding "q"
  :docstring "Qwant")

(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  :keybinding "D")

(defengine google-scholar
  "https://scholar.google.com/scholar?hl=zh-CN&q=%s"
  :keybinding "s")

(defengine youtube
  "http://www.youtube.com/results?aq=f&oq=&search_query=%s"
  :keybinding "y")

(defengine zhihu
  "https://www.zhihu.com/search?type=content&q=%s"
  :keybinding "z"
  :docstring "知乎")

(defengine bilibili
  "https://search.bilibili.com/all?keyword=%s"
  :keybinding "b"
  :docstring "哔哩哔哩")

(defengine bing
  "https://www.bing.com/search?q=%s"
  :keybinding "B")

(defengine bing-dict
  "https://www.bing.com/dict/search?q=%s"
  :docstring "bing dictionary 不知道什么原因，和浏览器有关，默认如果是 firefox 不行，是 chrome 行"
  :keybinding "C")

(defengine quword
  "https://www.quword.com/w/%s"
  :docstring "趣词词典"
  :keybinding "c")

(defengine google
  "https://www.google.com/search?ie=utf-8&q=%s"
  :keybinding "g")

(defengine baidu
  "https://www.baidu.com/s?wd=%s"
  :keybinding "d")

(defengine sogou
  "https://www.sogou.com/web?query=%s"
  :keybinding "S")

(provide 'init-engine)
