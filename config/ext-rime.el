;; 需要安装的包
;; Deepin 平台
;;   sudo apt install librime-dev

;; 目前笔记本电脑上出现 librime 日志输出总是打乱终端 emacs 界面的问题。
;; emacs-rime 的 issue 上有两个相似的问题
;; @ISSUE: https://github.com/DogLooksGood/emacs-rime/issues/137
;; @ISSUE: https://github.com/DogLooksGood/emacs-rime/issues/145
;;
;; 解决方案一致，都是使用 emacs --daemon 的方式，在终端下用 emacsclient
;; 就可以了。其实这个思路就是在 emacs --daemon 放在后台 librime 的输出日志
;; 在那个进程中输出，不会在 emacsclient 的界面输出。

;; Rime
(add-to-list 'load-path "~/.emacs.d/extensions/rime/")

;; https://github.com/DogLooksGood/emacs-rime/issues/161#issuecomment-979907791
(with-eval-after-load 'rime
  (add-hook 'kill-emacs-hook #'rime-lib-finalize))

(setq default-input-method "rime")
(setq rime-title " ㄓ ")
(autoload 'rime-activate "rime" nil nil nil)
(register-input-method "rime" "euc-cn" 'rime-activate rime-title)

(setq rime-user-data-dir "~/.emacs.d/rime/") ;linux 和 windows 共用一个配置文件

(when *is-windows*
  ;; @REF1: https://github.com/DogLooksGood/emacs-rime/pull/92
  ;; @REF2: https://eason0210.github.io/post/install-emacs-rime-with-msys2/
  ;; @REF3: https://github.com/DogLooksGood/emacs-rime/issues/64
  ;; 根据上述的方式，可以较方便的在 windows 平台编译 librime-emacs.dll
  ;; 0. 确保自己一定是最新的状态
  ;; pacman -Syu # 这个命令你可能需要运行好几次
  ;; 1. 安装基本包
  ;; pacman -S base-devel mingw64-x86_64-librime mingw64-x86_64-librime-data mingw64-x86_64-toolchain
  ;; 2. 切换到 rime 目录，编译 librime-emacs.dll：
  ;; cd ~/.emacs.d/extensions/rime
  ;; gcc lib.c -o librime-emacs.dll -fPIC -O2 -Wall -I '/c/Program Files/Emacs/emacs-28.2/include/' -shared -lrime
  ;; 3. 复制 librime.dll 到 emacs.exe 所在的文件夹：
  ;; 直接复制 msys64 下 pacman -S librime 安装的 librime.dll 就可以了（推荐用 everything 搜索）
  ;; * 备注
  ;; 这个命令：ln -s /mingw64/share/opencc/* /mingw64/share/rime-data/opencc
  ;; 因为我的 /mingw64/share/rime-data/ 文件夹中没有 opencc 文件夾，所以上面的命令会出錯，則修改为
  ;; ln -s /mingw64/share/opencc /mingw64/share/rime-data/opencc
  ;; 但是仍然不能解决繁體的問題。现在能想到的迴避問題的方法：就是用一個簡體詞庫的方案。但是心有不甘。
  ;; 另外一個很蹩腳的方案：我發現【朙月拼音】雖然默認是繁體輸出（詞庫是繁體的），但是它裏面也有簡體的字，
  ;; 所以還是可以輸入簡體字符，只不過需要選擇好久。
  ;; 本着「又不是不能用」的原則，決定還是先把 rime 全平臺用起來。

  ;; 备注：windows 下需要 C:\msys64\mingw64\bin 在 path 中，emacs-rime 才可以正常使用。

  ;; Changelog:
  ;; 2023年03月03日 15:15:04: 也不知道发什么了，现在可以简繁切换，且工作正常了。
  (setq rime-share-data-dir
	"c:/msys64/mingw64/share/rime-data"))

(setq rime-translate-keybindings
      '("C-f" "C-b" "C-n" "C-p" "C-g" "C-h" "C-e" "C-v" "M-v" "M-f" "M-b"
	"C-`" "C-d" "C-k" "C-y" "<tab>" "C-a" "C-u" "M-n" "M-p"
	"<left>" "<right>" "<up>" "<down>" "<prior>" "<next>" "<delete>"))

(with-eval-after-load 'rime
  (global-set-key (kbd "C-`") 'rime-select-schema)
  (define-key rime-active-mode-map (kbd "C-i") 'rime-inline-ascii)
  (define-key rime-active-mode-map (kbd "M-i") 'rime-return-yas-expand)
  (define-key rime-active-mode-map (kbd "C-j") 'rime--return))

(defun rime-return-yas-expand ()
  (interactive)
  (call-interactively 'rime--return)
  (call-interactively 'yas-expand))

(with-eval-after-load 'rime
  (face-spec-set 'rime-highlight-candidate-face
                 '((t :height 1.5 :bold t)))
  (face-spec-set 'rime-default-face
		 '((((class color) (background dark))
		    (:height 1.5 :background "#333333" :foreground "#dcdccc"))
		   (((class color) (background light))
		    (:height 1.5 :background "#dcdccc" :foreground "#333333")))))

(setq rime-posframe-properties
      (list :internal-border-width 8)
      rime-candidate-num-format-function 'fei-rime--candidate-num-format)

(defun fei-rime--candidate-num-format (num select-labels)
  "魔改的 `rime--candidate-num-format'"
  (if select-labels
      (format "%s. " (nth (1- num) select-labels))
    (format "%d." num)))

(setq rime-show-candidate 'posframe ;minibuffer 的方式会和 awesome-tab 冲突
      ;; posframe 的显示效果和桌面环境相关，目前在 gnome 下工作良好，在 cinnamon 下工作会有问题
      rime-show-preedit 'inline
      rime-posframe-style 'vertical ;选择竖着的原因，是因为横着的时候很容易出现 posframe 碰到 emacs frame 边界的情况，导致候选框一直跳动
      ;; rime-posframe-style 'horizontal
      rime-posframe-fixed-position t)

(setq rime-disable-predicates
      '(
        ;; rime-predicate-auto-english-p
	fei-rime-predicate-prog-in-code-p
	rime-predicate-space-after-cc-p
	rime-predicate-after-alphabet-char-p
	fei-texmathp
	rime-predicate-org-latex-mode-p
	rime-predicate-org-in-src-block-p))

(defun fei-texmathp ()
  (and (or (derived-mode-p  'latex-mode)
	   (derived-mode-p  'org-mode))
       (featurep 'tex-site)
       (texmathp)))

(defun fei-rime-predicate-prog-in-code-p ()
  (and (derived-mode-p 'prog-mode 'conf-mode)
       (not (nth 4 (syntax-ppss)))))


;; 让 rime 和 isearch 更好的工作，自己乱胡的版本，勉强能用

;; M-j 配合 `isearch-mode-hook' 和 `isearch-mode-end-hook' 可以完成在
;; isearch 的情况下也是 "输入中文" 这个功能，这样 M-j 按键的功能就有一
;; 致性的表现了

(add-hook 'isearch-mode-hook '+fei-isearch-deacivate-input-method)
(add-hook 'isearch-mode-end-hook '+fei-isearch-end-restore-input-method)


(defvar isearch-end-activate-input-method-predicate nil)

(defun +fei-isearch-deacivate-input-method ()
  (when (string= current-input-method "rime")
    (deactivate-input-method)
    (setq isearch-end-activate-input-method-predicate t)))

(defun +fei-isearch-end-restore-input-method ()
  (when isearch-end-activate-input-method-predicate
    (activate-input-method "rime")
    ;; 不知道什么原因，isearch-mode 退出之后重新激活输入法，会导致
    ;; (default-value 'input-method-function) 的值变成 rime-input-method
    ;; 不过目前可以用这个方法解决问题 (虽然不是从根本上解决，但是管用)
    (setq-default input-method-function nil)
    (setq isearch-end-activate-input-method-predicate nil)))

(defun fei-rime-force-enable ()
  (interactive)
  (activate-input-method "rime")
  (call-interactively 'rime-force-enable))

(provide 'ext-rime)
