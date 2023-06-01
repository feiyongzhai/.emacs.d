(defvar searchbox-buffer "*搜索*")
(defvar searchbox-string nil)
(defvar searchbox-string-hist nil)
(defvar searchbox-string-hist-idx 0)

(defvar searchbox-sites
  '(
    ("必应(bing)" . "https://www.bing.com/search?q=")
    ("必应词典(bing-dict)" . "https://www.bing.com/dict/search?q=")
    ("京东(jd)" . "https://search.jd.com/Search?keyword=")
    ("DuckDuckGo(ddg)" . "https://duckduckgo.com/?q=")
    ("Debian Manpages" . "https://manpages.debian.org/jump?q=")
    ("Hacker News" . "https://hn.algolia.com/?q=")
    ("Soundcloud" . "https://soundcloud.com/search?q=")
    ("Reddit" . "https://www.reddit.com/search/?q=")
    ("Emacs China" . "https://emacs-china.org/search?q=")
    ("维基百科(wiki)" . "https://en.wikipedia.org/wiki/")
    ("谷歌图片(image)" . "http://www.google.com/images?q=")
    ("网易公开课(163)" . "https://open.163.com/newview/search/")
    ("StackOverFlow" . "https://stackoverflow.com/search?q=")
    ("微信" . "https://weixin.sogou.com/weixin?type=2&query=")
    ("汉典" . "https://www.zdic.net/hans/")
    ("谷歌(g)" . "https://www.google.com/search?ie=utf-8&q=")
    ("哔站(b)" . "https://search.bilibili.com/all?keyword=")
    ("知乎(z)" . "https://www.zhihu.com/search?type=content&q=")
    ("百度(B)" . "https://www.baidu.com/s?wd=")
    ("Github(G)" . "https://github.com/search?ref=simplesearch&q=")
    ("油管(y)" . "http://www.youtube.com/results?aq=f&oq=&search_query=")
    ("搜狗(S)" . "https://www.sogou.com/web?query=")
    ("抖音(D)" . "https://www.douyin.com/search/")
    ("微博(W)" . "https://s.weibo.com/weibo?q=")
    ("趣词(d)" . "https://www.quword.com/w/")
    ("谷歌学术(x)" . "https://scholar.google.com/scholar?hl=zh-CN&q=")
    ))

(defun searchbox-get-sites-url (name)
  (alist-get name searchbox-sites nil nil 'string=))

(defun searchbox-switch-engine ()
  (interactive)
  (let* ((name (completing-read "切换引擎: " (mapcar (lambda (x) (car x)) searchbox-sites)))
	 (url (searchbox-get-sites-url name)))
    (browse-url (concat url (url-encode-url searchbox-string)))))

(defun eshell/s (&rest input)
  (interactive)
  (message "%s" (eshell-flatten-and-stringify input))
  (let ((in (eshell-flatten-and-stringify input)))
    (if (string= "" in)
	(setq searchbox-string (read-string "搜索(谷歌)：" nil 'searchbox-string-hist))
      (setq searchbox-string in)))
  (setq searchbox-string-hist-idx 0) ;重置 `searchbox-string-hist-idx'
  (browse-url (concat (searchbox-get-sites-url "谷歌(g)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search (&optional initial-input)
  (interactive)
  (setq searchbox-string (read-string "搜索(谷歌)：" (and initial-input searchbox-string) 'searchbox-string-hist))
  (setq searchbox-string-hist-idx 0) ;重置 `searchbox-string-hist-idx'
  (browse-url (concat (searchbox-get-sites-url "谷歌(g)")
		      (url-encode-url searchbox-string))))

(defun searchbox-research-from-hist ()
  "这个命令搜索的 item 不会记录到 `searchbox-string-hist' 中"
  (interactive)
  (setq searchbox-string (completing-read "请选择: " searchbox-string-hist)) ;居然可以自动去重，好！
  (setq searchbox-string-hist-idx
	;; @REF: https://emacs.stackexchange.com/questions/10492/how-to-get-element-number-in-a-list
	(cl-position searchbox-string searchbox-string-hist :test 'equal))
  (browse-url (concat (searchbox-get-sites-url "谷歌(g)") searchbox-string))
  (searchbox-refresh-buffer))

(defun searchbox-prev-hist ()
  (interactive)
  (if (length> searchbox-string-hist (1+ searchbox-string-hist-idx))
      (progn
	(setq searchbox-string-hist-idx (1+ searchbox-string-hist-idx))
	(message "item %d" searchbox-string-hist-idx))
    (message "已经是最后一个了"))
  (setq searchbox-string (nth searchbox-string-hist-idx searchbox-string-hist))
  (searchbox-refresh-buffer))

(defun searchbox-next-hist ()
  (interactive)
  (if (> searchbox-string-hist-idx 0)
      (progn
        (setq searchbox-string-hist-idx (1- searchbox-string-hist-idx))
	(message "item %d" searchbox-string-hist-idx))
    (message "已经是最新"))
  (setq searchbox-string (nth searchbox-string-hist-idx searchbox-string-hist))
  (searchbox-refresh-buffer))

(defun searchbox-oldest-hist ()
  (interactive)
  (setq searchbox-string-hist-idx (1- (length searchbox-string-hist)))
  (setq searchbox-string (nth searchbox-string-hist-idx searchbox-string-hist))
  (message "最远搜索项")
  (searchbox-refresh-buffer))

(defun searchbox-newest-hist ()
  (interactive)
  (setq searchbox-string-hist-idx 0)
  (setq searchbox-string (nth searchbox-string-hist-idx searchbox-string-hist))
  (message "最近搜索项")
  (searchbox-refresh-buffer))

(defun searchbox-remove-this-hist ()
  (interactive)

  ;; remove nth element in list
  ;; @REF: https://emacs.stackexchange.com/questions/29786/how-to-remove-delete-nth-element-of-a-list
  (if (zerop searchbox-string-hist-idx)
      (setq searchbox-string-hist (cdr searchbox-string-hist))
    (let ((last (nthcdr (1- searchbox-string-hist-idx) searchbox-string-hist)))
      (setcdr last (cddr last))))    ;destructive version 操作上像指针

  ;; remove 会删除所有相等的项，很可能不止一项
  ;; (setq searchbox-string-hist (remove searchbox-string searchbox-string-hist))


  (and (length= searchbox-string-hist searchbox-string-hist-idx)
       (setq searchbox-string-hist-idx (1- searchbox-string-hist-idx)))
  (setq searchbox-string (nth searchbox-string-hist-idx searchbox-string-hist))
  (searchbox-refresh-buffer))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(window-divider-mode) ; 目前不能实现 window-divider-local-mode，不过全局开也不是很影响
(defun searchbox-refresh-buffer ()
  (interactive)
  (let ((buffer (get-buffer-create searchbox-buffer)))
    (with-current-buffer buffer
      (read-only-mode -1)
      (erase-buffer)
      (insert "搜索：> " (if searchbox-string searchbox-string "") " <")
      ;; (insert "\n")
      (insert " ")

      (insert-button "Quit" 'action `(lambda (_) (quit-window)))
      (insert " | ")
      (searchbox-create-button "谷歌(g)" (searchbox-get-sites-url "谷歌(g)"))
      (searchbox-create-button "哔站(b)" (searchbox-get-sites-url "哔站(b)"))
      (searchbox-create-button "知乎(z)" (searchbox-get-sites-url "知乎(z)"))
      (searchbox-create-button "百度(B)" (searchbox-get-sites-url "百度(B)"))
      (searchbox-create-button "Github(G)" (searchbox-get-sites-url "Github(G)"))
      (searchbox-create-button "油管(y)" (searchbox-get-sites-url "油管(y)"))
      ;; (insert "\n")
      (searchbox-create-button "搜狗(S)" (searchbox-get-sites-url "搜狗(S)"))
      (searchbox-create-button "抖音(D)" (searchbox-get-sites-url "抖音(D)"))
      (searchbox-create-button "微博(W)" (searchbox-get-sites-url "微博(W)"))
      (searchbox-create-button "趣词(d)" (searchbox-get-sites-url "趣词(d)"))
      (searchbox-create-button "谷歌学术(x)" (searchbox-get-sites-url "谷歌学术(x)") t)
      (goto-char (point-min))

      (read-only-mode)

      (and (bound-and-true-p evil-mode)	; 避免问题：不会改变 evil normal state 的快捷键
	   (fboundp 'evil-emacs-state)
	   (evil-emacs-state))
      (let ((map (make-sparse-keymap)))
	(set-keymap-parent map (current-local-map))
	(define-key map "B" #'searchbox-search-baidu)
	(define-key map "b" #'searchbox-search-bilibili)
	(define-key map "g" #'searchbox-search-google)
	(define-key map "G" #'searchbox-search-github)
	(define-key map "d" #'searchbox-search-quword)
	(define-key map "S" #'searchbox-search-sogou)
	(define-key map "W" #'searchbox-search-weibo)
	(define-key map "D" #'searchbox-search-douyin)
	(define-key map "z" #'searchbox-search-zhihu)
	(define-key map "y" #'searchbox-search-youtube)
	(define-key map "r" #'searchbox-research-from-hist)
	(define-key map "x" #'searchbox-search-xueshu)
	(define-key map "h" #'searchbox-switch-engine)
	(define-key map "t" #'toggle-truncate-lines)
	(define-key map "i" #'fei/fit-window-to-buffer)
	(define-key map "m" #'minimize-window)
	(define-key map "H" #'webjump)
	(define-key map "l" (li (quit-window) (call-interactively 'searchbox-hist-list-show)))
	;; (define-key map "e" (li (searchbox-search t)))
	(define-key map "e" #'searchbox-edit-string)
	(define-key map "s" #'searchbox-search)
	(define-key map "w" #'searchbox-copy-string)
	(define-key map (kbd "M-d") #'searchbox-remove-this-hist)
	(define-key map ">" #'searchbox-newest-hist)
	(define-key map "<" #'searchbox-oldest-hist)
	(define-key map "p" #'searchbox-prev-hist)
        (define-key map "n" #'searchbox-next-hist)
	(define-key map (kbd "M-p") #'searchbox-prev-hist)
	(define-key map (kbd "M-n") #'searchbox-next-hist)
	(define-key map "q" #'quit-window)
	(use-local-map map))
      )
    ;;; Note:
    ;; 在使用过程中发现一个问题：如果使用 display-buffer-in-side-window 结合
    ;; window-min-height 为 1 的设置会出现问题。

    ;; 问题详细说明：因为在显示 searchbox-buffer 的时候没有显示 mode-line，所以
    ;; window-height 为 1 的时候可以正常显示窗口，但是当其他 window 也使用
    ;; display-buffer-in-side-window 进行显示时，此时 window-height 被
    ;; searchbox-buffer 限制为了 1 ，但是由于会显示 mode-line，mode-line
    ;; 会占据 1 个高度。这就导致了 buffer 的内容无法显示，此时 emacs 会出现卡
    ;; 死或者崩溃的情况。

    ;; 使用 display-buffer-at-bottom 就是为了避免这个问题。不再 side-window
    ;; 中进行显示，不会有限制 window 大小的情况。

    ;; 总结的经验为：三个条件不要同时满足，否则很容易出现问题。这三个条件分别为：
    ;; 1. 在 side-window 中显示 buffer，
    ;; 2. 在 side-window 中显示的 buffer 没有 mode-line
    ;; 3. window-min-height 设置为 1
    (setq window-min-height 1)        ;会影响 `minimize-window' 的行为
    (display-buffer-in-direction
     buffer '(nil (window-height . 1)
                  (window . root)
                  (direction . down)
	          (body-function . (lambda (w)
                                     ;; (toggle-truncate-lines 1)
                                     (fit-window-to-buffer w)))
                  (window-parameters . ((mode-line-format . none)))
	          ))))

(defun searchbox-buffer-search ()
  (interactive)
  (let (searchbox-string)
    (searchbox-switch-to-buffer)
    (searchbox-edit-string)))

(defun searchbox-switch-to-buffer ()
  (interactive)
  (searchbox-refresh-buffer)
  (select-window (get-buffer-window searchbox-buffer)))

(defun searchbox-edit-string ()
  (interactive)
  (let ((buffer (get-buffer-create searchbox-buffer)))
    (with-current-buffer buffer
      (read-only-mode -1)
      (erase-buffer)
      (goto-char (point-min))
      (insert (or searchbox-string ""))

      (use-local-map nil)		; 先清除 keybinding
      (let ((map (make-sparse-keymap)))
	(set-keymap-parent map (current-local-map))
        (define-key map (kbd "C-c C-c") #'searchbox-edit-confirm)
	(define-key map (kbd "C-c C-k") #'searchbox-edit-cancel)
        (define-key map (kbd "RET") #'searchbox-edit-confirm)
        (define-key map (kbd "C-j") #'searchbox-edit-confirm)
	(define-key map (kbd "C-g") #'searchbox-edit-quit)
        (use-local-map map)))))

(defun searchbox-edit-confirm ()
  (interactive)
  (setq searchbox-string (buffer-substring-no-properties (point-min) (point-max)))
  (push searchbox-string searchbox-string-hist)
  (setq searchbox-string-hist-idx 0) ;重置 `searchbox-string-hist-idx'
  (searchbox-refresh-buffer)
  (searchbox-search-google))

(defalias 'searchbox-edit-cancel 'searchbox-refresh-buffer)

(defun searchbox-edit-quit ()
  (interactive)
  (searchbox-refresh-buffer)
  (quit-window))

(defun searchbox-copy-string ()
  (interactive)
  (and searchbox-string
       (kill-new searchbox-string)
       (message searchbox-string)))

(defun searchbox-create-button (label link &optional last)
  ;; @REF：https://www.bilibili.com/video/BV1Pz4y1y7p9?p=2&vd_source=90a81ebe657f51bd739567296e1a9a37
  (insert-button
   label 'action `(lambda (_) (browse-url (concat ,link searchbox-string))))
  (unless last (insert " | ")))

(defun searchbox-search-xueshu ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "谷歌学术(x)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-sogou ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "搜狗(S)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-youtube ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "油管(y)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-github ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "Github(G)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-baidu ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "百度(B)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-zhihu ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "知乎(z)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-google ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "谷歌(g)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-bilibili ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "哔站(b)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-quword ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "趣词(d)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-weibo ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "微博(W)")
		      (url-encode-url searchbox-string))))

(defun searchbox-search-douyin ()
  (interactive)
  (browse-url (concat (searchbox-get-sites-url "抖音(D)")
		      (url-encode-url searchbox-string))))


;;; 想法：用 tabulated-list-mode 显示 searchbox-string-hist，还没有实现。
;; @REF: https://emacs-china.org/t/emacs/12024/2

(define-derived-mode searchbox-hist-list-mode tabulated-list-mode "Modules"
  (setq tabulated-list-padding 0)
  (setq tabulated-list-format `[("History Entry" 20 nil)])
  (tabulated-list-init-header)
  (add-hook 'tabulated-list-revert-hook 'searchbox-hist-list-do-refresh nil t))

(defun searchbox-hist-list-do-refresh ()
  (setq tabulated-list-entries (searchbox-string-hist-to-entries)))

(defun searchbox-string-hist-to-entries ()
  (let ((i 0))
    (mapcar (lambda (x) `(,(setq i (1+ i)) [,x]))
            searchbox-string-hist)))

(defun searchbox-hist-list-show ()
  (interactive)
  (let ((buf (get-buffer-create "*My tab*")))
    (switch-to-buffer buf)
    (searchbox-hist-list-mode)
    (searchbox-hist-list-do-refresh)
    (tabulated-list-print)))

(provide 'searchbox)
