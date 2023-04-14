(defvar searchbox-buffer "*搜索*")
(defvar searchbox-string nil)
(defvar searchbox-string-hist nil)
(defvar searchbox-string-hist-idx 0)

(defun eshell/s (&rest input)
  (interactive)
  ;; (setq searchbox-string (read-string "搜索(谷歌)：" (and initial-input searchbox-string) 'searchbox-string-hist))
  (message "%s" (eshell-flatten-and-stringify input))
  (let ((in (eshell-flatten-and-stringify input)))
    (if (string= "" in)
	(setq searchbox-string (read-string "搜索(谷歌)：" nil 'searchbox-string-hist))
      (setq searchbox-string in)))
  (setq searchbox-string-hist-idx 0) ;重置 `searchbox-string-hist-idx'
  (searchbox-refresh-buffer)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-encode-url searchbox-string)))
  (message "搜索: %s"searchbox-string)
  )

(defun searchbox-search (&optional initial-input)
  (interactive)
  (setq searchbox-string (read-string "搜索(谷歌)：" (and initial-input searchbox-string) 'searchbox-string-hist))
  (setq searchbox-string-hist-idx 0) ;重置 `searchbox-string-hist-idx'
  (searchbox-refresh-buffer)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-encode-url searchbox-string)))
  )

(defun searchbox-prev-hist ()
  (interactive)
  (if (length> searchbox-string-hist (1+ searchbox-string-hist-idx))
      (progn
	(setq searchbox-string-hist-idx (1+ searchbox-string-hist-idx))
	(message "item %d" searchbox-string-hist-idx)
	(setq searchbox-string (nth searchbox-string-hist-idx searchbox-string-hist))
	)
    (message "已经是最后一个了"))
  (searchbox-refresh-buffer))

(defun searchbox-research-from-hist ()
  "这个命令搜索的 item 不会记录到 `searchbox-string-hist' 中"
  (interactive)
  (setq searchbox-string (completing-read "请选择: " searchbox-string-hist)) ;居然可以自动去重，好！
  (setq searchbox-string-hist-idx
	;; @REF: https://emacs.stackexchange.com/questions/10492/how-to-get-element-number-in-a-list
	(cl-position searchbox-string searchbox-string-hist :test 'equal))
  (browse-url
   (concat "https://www.google.com/search?ie=utf-8&q="
	   searchbox-string))
  (searchbox-refresh-buffer))

(defun searchbox-next-hist ()
  (interactive)
  (if (> searchbox-string-hist-idx 0)
      (progn
        (setq searchbox-string-hist-idx (1- searchbox-string-hist-idx))
	(message "item %d" searchbox-string-hist-idx)
	(setq searchbox-string (nth searchbox-string-hist-idx searchbox-string-hist)))
    (message "已经是最新"))
  (searchbox-refresh-buffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun searchbox-refresh-buffer ()
  (interactive)
  (let ((buffer (get-buffer-create searchbox-buffer)))
    (display-buffer-in-side-window
     buffer '(nil (window-height . (lambda (win) (fit-window-to-buffer win)))
		  (body-function . select-window)
		  (side . top)))

    (read-only-mode -1)
    (with-current-buffer buffer
      (erase-buffer)
      (insert "搜索：> " searchbox-string " <")
      (if (length> searchbox-string 30)
	  (insert "\n")
	(insert " "))

      (searchbox-create-button "百度(B)" "https://www.baidu.com/s?wd=")
      (searchbox-create-button "知乎(z)" "https://www.zhihu.com/search?type=content&q=")
      (searchbox-create-button "谷歌(g)" "https://www.google.com/search?ie=utf-8&q=")
      (searchbox-create-button "B站(b)" "https://search.bilibili.com/all?keyword=")
      (searchbox-create-button "搜狗(S)" "https://www.sogou.com/web?query=")
      (searchbox-create-button "Github(G)" "https://github.com/search?ref=simplesearch&q=")
      (searchbox-create-button "YouTube(y)" "http://www.youtube.com/results?aq=f&oq=&search_query=")
      (searchbox-create-button "趣词(d)" "https://www.quword.com/w/")
      (searchbox-create-button "学术(x)" "https://scholar.google.com/scholar?hl=zh-CN&q=" t)
      (goto-char (point-min))

      (read-only-mode)

      (and (bound-and-true-p evil-mode)	    ; 避免问题：不会改变 evil normal state 的快捷键
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
	(define-key map "z" #'searchbox-search-zhihu)
	(define-key map "y" #'searchbox-search-youtube)
	(define-key map "r" #'searchbox-research-from-hist)
	(define-key map "x" #'searchbox-search-xueshu)
	(define-key map "h" #'webjump)
	(define-key map "e" (li (searchbox-search t)))
	(define-key map "w" #'searchbox-copy-string)
	(define-key map (kbd "M-p") #'searchbox-prev-hist)
	(define-key map (kbd "M-n") #'searchbox-next-hist)
	(define-key map "q" #'quit-window)
	(use-local-map map))
      )
    )
  )

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
  (browse-url
   (concat "https://scholar.google.com/scholar?hl=zh-CN&q="
	   (url-encode-url searchbox-string))))

(defun searchbox-search-sogou ()
  (interactive)
  (browse-url
   (concat "https://www.sogou.com/web?query="
	   (url-encode-url searchbox-string))))

(defun searchbox-search-youtube ()
  (interactive)
  (browse-url
   (concat "http://www.youtube.com/results?aq=f&oq=&search_query="
	   (url-encode-url searchbox-string))))

(defun searchbox-search-github ()
  (interactive)
  (browse-url
   (concat "https://github.com/search?ref=simplesearch&q="
	   (url-encode-url searchbox-string))))

(defun searchbox-search-baidu ()
  (interactive)
  (browse-url
   (concat "https://www.baidu.com/s?wd="
	   (url-encode-url searchbox-string))))

(defun searchbox-search-zhihu ()
  (interactive)
  (browse-url
   (concat "https://www.zhihu.com/search?type=content&q="
	   (url-encode-url searchbox-string))))

(defun searchbox-search-google ()
  (interactive)
  (browse-url
   (concat "https://www.google.com/search?ie=utf-8&q="
	   (url-encode-url searchbox-string))))

(defun searchbox-search-bilibili ()
  (interactive)
  (browse-url
   (concat "https://search.bilibili.com/all?keyword="
	   (url-encode-url searchbox-string))))

(defun searchbox-search-quword ()
  (interactive)
  (browse-url
   (concat "https://www.quword.com/w/"
	   (url-encode-url searchbox-string))))

(provide 'searchbox)
