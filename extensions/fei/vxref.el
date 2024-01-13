;; vxref == a very simple way to visualise xref stack

;; 设计初衷：方便自己读别人的源码，原本的想法是，如果有一个 buffer 可以展示所有函数的调用关系，我可能会更好理解别人的源码
;; 但是自己能力不够，不知道怎么做这件事。所以采用了一个投机取巧的方式，给 `xref-find-definitions' 添加一个 hook ，但发
;; 现没有 hook ，所以就整了一个 advice。

;; WIP
;; 目前效果勉勉强强能够使用

(require 'which-func)									     ;use for know fn-called-from

(defvar vxref-buffer-name "*VXREF*")

(defun vxref--refresh-vxref-buffer (fn-info)
  "create buffer if target buffer not exist and refresh targert buffer contents"
  (let* (
	 (buf (get-buffer-create vxref-buffer-name))
	 (fn-buf (nth 0 fn-info))
	 (fn-name (nth 1 fn-info))
	 (fn-pos (nth 2 fn-info))
	 (fn-called-from (nth 3 fn-info))
	 )
    (with-current-buffer buf
      (goto-char (point-max))
      (unless (bobp) (insert "\n"))
      ;; TODO: do not insert two same entry(fn-name)
      ;; 目前还不知道怎么做去重处理，但是，*vxref* buffer 的内容是可修改的，自动不了就手动，哈哈哈
      ;; 但是有一个比较头痛的问题是，button 是通过 overlay 实现的，如果，我修改了 button 的位置，
      ;; button 就没了，所以我得给这个文字添加一个高亮，这样就算没有了可以点击的功能，还有一个颜色
      ;; 指示被调用关系，
      (insert (concat fn-called-from "\n :: "))
      (insert-button (propertize fn-name 'face 'font-lock-function-name-face)
		     'action
		     `(lambda (e)
			;;TODO: i do not know this display buffer strategy is good
			(select-window (get-buffer-window ,vxref-buffer-name)) ; 如果没有这行，evil-mode 会工作不预期，不知道 evil-mode 做了什么
			(other-window 1)
			(switch-to-buffer ,fn-buf)
			(goto-char ,fn-pos)
			(fei-pulse-current-line)
			(other-window -1))
		     ))
    (display-buffer-in-side-window buf '((side . right)))
    )
  )

(defun vxref-get-function-info ()
  "get the function name position and buffer-file-name"
  (let ((fn-name (thing-at-point 'symbol)) ;maybe i should remove the text properties
	(fn-pos (point))
	fn-called-from)
    (list (buffer-name)
	  fn-name
	  fn-pos
	  (which-function)		; 这个函数返回的值不太准
	  )))

(defun vxref-xref-find-definitions-advisor (old-fun &rest args)
  (let ((fn-info (vxref-get-function-info)))
    (apply old-fun args)
    (vxref--refresh-vxref-buffer fn-info)
    ))

(define-minor-mode vxref-mode
  "自己乱糊的，哈哈哈"
  :init-value nil
  :global t
  (if vxref-mode
      (advice-add 'xref-find-definitions :around 'vxref-xref-find-definitions-advisor)
    (advice-remove 'xref-find-definitions 'vxref-xref-find-definitions-advisor)))

(provide 'vxref)
