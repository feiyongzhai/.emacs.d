;; @REF: https://www.reddit.com/r/emacs/comments/a3rajh/chrome_bookmarks_sync_to_org/
;; @SEEALSO:
;; 1. https://emacs-china.org/t/helm-chrome/9562/2
;; 2. https://github.com/kawabata/helm-chrome
;; 3. https://github.com/xuchunyang/helm-chrome-history

(defvar chrome-bookmarks-file
  (cl-find-if
   #'file-exists-p
   ;; Base on `helm-chrome-file'
   (list
    "~/Library/Application Support/Google/Chrome/Profile 1/Bookmarks"
    "~/Library/Application Support/Google/Chrome/Default/Bookmarks"
    "~/AppData/Local/Google/Chrome/User Data/Default/Bookmarks"
    "~/.config/google-chrome/Default/Bookmarks"
    "~/.config/chromium/Default/Bookmarks"
    (substitute-in-file-name
     "$LOCALAPPDATA/Google/Chrome/User Data/Default/Bookmarks")
    (substitute-in-file-name
     "$USERPROFILE/Local Settings/Application Data/Google/Chrome/User Data/Default/Bookmarks")))
  "Path to Google Chrome Bookmarks file (it's JSON).")

(defun chrome-bookmarks-insert-as-org ()
  "Insert Chrome Bookmarks as org-mode headings."
  (interactive)
  (require 'json)
  (require 'org)
  (let ((data (let ((json-object-type 'alist)
                    (json-array-type  'list)
                    (json-key-type    'symbol)
                    (json-false       nil)
                    (json-null        nil))
                (json-read-file chrome-bookmarks-file)))
        level)
    (cl-labels ((fn
                 (al)
                 (pcase (alist-get 'type al)
                   ("folder"
                    (insert
                     (format "%s %s\n"
                             (make-string level ?*)
                             (alist-get 'name al)))
                    (cl-incf level)
                    (mapc #'fn (alist-get 'children al))
                    (cl-decf level))
                   ("url"
                    (insert
                     (format "%s %s\n"
                             (make-string level ?*)
                             (org-make-link-string
                              (alist-get 'url al)
                              (alist-get 'name al))))))))
      (setq level 1)
      (fn (alist-get 'bookmark_bar (alist-get 'roots data)))
      (setq level 1)
      (fn (alist-get 'other (alist-get 'roots data))))))

(defun fei-bookmark-to-org ()
  (interactive)
  (let ((file "~/Nutstore Files/org/Bookmark/bookmark.org"))
    (find-file file)
    (erase-buffer)
    (call-interactively 'chrome-bookmarks-insert-as-org)
    (save-buffer)
    (kill-this-buffer)))

(provide 'fei-bookmark-org)
