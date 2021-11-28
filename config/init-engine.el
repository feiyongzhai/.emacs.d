(load-path-add "~/.emacs.d/extensions/one-key")
(require 'one-key)

(global-set-key (kbd "C-x /") 'engine-mode-prefixed-map)
(global-set-key (kbd "M-s-g") 'one-key-menu-engine)

(one-key-create-menu
 "ENGINE"
 '(
   (("g" . "谷歌") . engine/search-google)
   (("z" . "知乎") . engine/search-zhihu)
   (("h" . "Github") . engine/search-github)
   (("b" . "哔哩哔哩") . engine/search-bilibili)
   (("y" . "YouTube") . engine/search-youtube)
   (("s" . "谷歌学术") . engine/search-google-scholar)
   (("i" . "谷歌图片") . engine/search-google-images)
   (("D" . "必应词典") . engine/search-bing-dict)
   (("q" . "Qwant") . engine/search-qwant)
   )
 t)

(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "h")

(defengine google-images
  "http://www.google.com/images?hl=en&source=hp&biw=1440&bih=795&gbv=2&aq=f&aqi=&aql=&oq=&q=%s"
  :keybinding "i")

(defengine wikipedia
    "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
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

(defengine bing-dict
  "https://www.bing.com/dict/search?q=%s"
  :docstring "bing dictionary"
  :keybinding "D")

(defengine google
  "https://www.google.com/search?ie=utf-8&q=%s"
  :keybinding "g")

(provide 'init-engine)
