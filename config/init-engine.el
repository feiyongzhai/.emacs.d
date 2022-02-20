(load-path-add "~/.emacs.d/extensions/one-key")
(require 'one-key)

(one-key-create-menu
 "ENGINE"
 '(
   (("g" . "谷歌") . engine/search-google)
   (("z" . "知乎") . engine/search-zhihu)
   (("h" . "Github") . engine/search-github)
   (("b" . "哔哩哔哩") . engine/search-bilibili)
   (("d" . "DuckDuckGo") . engine/search-duckduckgo)
   (("D" . "百度") . engine/search-baidu)
   (("B" . "必应") . engine/search-bing)
   (("S" . "搜狗") . engine/search-sogou)
   (("y" . "YouTube") . engine/search-youtube)
   (("s" . "谷歌学术") . engine/search-google-scholar)
   (("i" . "谷歌图片") . engine/search-google-images)
   (("c" . "必应词典") . engine/search-bing-dict)
   (("q" . "Qwant") . engine/search-qwant)
   )
 t)

(global-set-key (kbd "M-s-g") 'one-key-menu-engine)

(global-set-key (kbd "C-c /") 'webjump)
(global-set-key (kbd "C-x /") 'engine-mode-prefixed-map)
(global-set-key (kbd "C-x C-/") 'engine-mode-prefixed-map)

(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "h")

(defengine google-images
  "http://www.google.com/images?hl=en&source=hp&biw=1440&bih=795&gbv=2&aq=f&aqi=&aql=&oq=&q=%s"
  :keybinding "i")

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
  :keybinding "d")

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
  :docstring "bing dictionary"
  :keybinding "c")

(defengine google
  "https://www.google.com/search?ie=utf-8&q=%s"
  :keybinding "g")

(defengine baidu
  "https://www.baidu.com/s?wd=%s"
  :keybinding "D")

(defengine sogou
  "https://www.sogou.com/web?query=%s"
  :keybinding "S")

(provide 'init-engine)
