(defvar searchbox-buffer "*搜索*")
(defvar searchbox-string nil)
(defvar searchbox-string-hist nil)
(defvar searchbox-string-hist-idx 0)

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
    (display-buffer-in-direction
     buffer '(nil (window-height . (lambda (win) (fit-window-to-buffer win)))
		  (body-function . select-window)
		  (direction . above)))

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
      (searchbox-create-button "趣词(d)" "https://www.quword.com/w/" t)
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
	(define-key map "d" #'searchbox-search-quword)
	(define-key map "z" #'searchbox-search-zhihu)
	(define-key map "r" #'searchbox-research-from-hist)
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
