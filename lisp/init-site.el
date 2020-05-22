;; 如果需要高亮代码
(require 'htmlize)

(require 'org)
(require 'ox-html)
(require 'ox-publish)

;; Declare all the directories
(setq org-blog-site-dir "/data/cycoe/GitHub/orgmode-blog"
      org-blog-template-dir (concat org-blog-site-dir "/templates")
      org-blog-src-dir (concat org-blog-site-dir "/src")
      org-blog-static-dir (concat org-blog-site-dir "/static")
      org-blog-output-dir (concat org-blog-site-dir "/html")
      org-blog-output-static-dir (concat org-blog-output-dir "/static"))

(defun org-blog-load-template (template-file)
  "Load templates from templates directory"
  (with-temp-buffer
    (insert-file-contents (concat org-blog-template-dir "/" template-file))
    (buffer-string)))

(defun org-blog-written-time (_plist)
  "Get the written time string from the article property."
  (plist-get (car (cdr (car _plist))) :raw-value))

(defun org-blog-built-time ()
  "Get the built time string of the site."
  (format-time-string "<%Y-%m-%d %a %H:%M>"))

(defun org-blog-preamble (_plist)
  "Pre-amble for whole blog."
  (format
   (org-blog-load-template "preamble.html")
   (if (plist-get _plist :title)
       (car-safe (plist-get _plist :title))
     "No Title")
   (if (s-contains-p "Blog/" (plist-get _plist :input-file))
       (format "Written @%s" (org-blog-written-time (plist-get _plist :date)))
     (format "Built @%s" (org-blog-built-time)))))

(defun org-blog-postamble (_plist)
  "Post-amble for whole blog."
  (concat
   (when (s-contains-p "Blog/" (plist-get _plist :input-file))
     (format "<div id=\"author-info\">
      <div id=\"author\">Author: %s (%s)</div>
      <div id=\"date\">Date: %s</div>
      <div id=\"generator\">Generator: %s</div>
      <div id=\"built\">Built: %s</div>
      </div>"
             (plist-get _plist :author)
             (plist-get _plist :email)
             (org-blog-written-time (plist-get _plist :date))
             (plist-get _plist :creator)
             (org-blog-built-time)))
   (org-blog-load-template "postamble.html")))

(defun org-blog-sitemap-format-entry (entry _style project)
  "Return string for each ENTRY in PROJECT."
  (when (s-starts-with-p "Blog/" entry)
    (format "@@html:<span class=\"archive-title\">@@ [[file:%s][%s]] @@html:</span><span class=\"archive-date\">@@%s@@html:</span>@@"
            entry
            (org-publish-find-title entry project)
            (format-time-string "<%Y-%m-%d>"
                                (org-publish-find-date entry project)))))

(defun org-blog-sitemap-function (title list)
  "Return sitemap using TITLE and LIST returned by `org-blog-sitemap-format-entry'."
  (concat "#+TITLE: " title "\n\n"
          "\n#+begin_archive\n"
          (mapconcat (lambda (li)
                       (format "@@html:<div class=\"archive-item\">@@ %s @@html:</div>@@" (car li)))
                     (seq-filter #'car (cdr list))
                     "\n")
          "\n#+end_archive\n"))

;; 这部分也可以放在 js 里
;; (advice-add 'org-html--translate :before-until 'display-toc-as-symbol)
;; (defun display-toc-as-symbol (phrase info)
;;   "将 Table of Contents 显示为符号"
;;   (when (equal phrase "Table of Contents")
;;     "<div id=\"toc-symbol\">Ξ</div>
;;     <div id=\"go-top\"><a href=\"javascript:window.scrollTo(0,0)\"
;;     style=\"color: black !important; border-bottom: none !important;\"
;;     class=\"tooltip\"
;;     title=\"Go to the top of the page\">
;;     <span class=\"top\">&uarr;</span>
;;     </a></div>"))

(setq org-publish-project-alist
      `(("images"
         :base-directory ,org-blog-src-dir
         :base-extension "jpg\\|png\\|c\\|gif\\|svg"
         :publishing-directory ,org-blog-output-dir
         :recursive t
         :publishing-function org-publish-attachment)
        ("static"
         :base-directory ,org-blog-static-dir
         :base-extension "jpg\\|png\\|c\\|gif\\|svg\\|css\\|js"
         :publishing-directory ,org-blog-output-static-dir
         :recursive t
         :publishing-function org-publish-attachment)
        ("blog-src"
         :base-directory ,org-blog-src-dir
         :base-extension "org"
         :publishing-directory ,org-blog-output-dir
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :recursive t
         :with-date t
         :with-email t
         :with-tags t
         :author "Cycoe"
         :email "cycoejoo@163.com"
         :html-doctype "html5"
         :html-html5-fancy t
         ;; 取消默认的CSS
         :html-head-include-default-style nil
         ;; 取消默认的Javascript代码
         :html-head-include-scripts nil
         :html-head-extra ,(org-blog-load-template "head.html")
         :html-preamble org-blog-preamble
         :html-postamble org-blog-postamble

         ;; 自动生成索引页
         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "Blog Posts"
         :sitemap-style list
         :sitemap-sort-files anti-chronologically
         :sitemap-format-entry org-blog-sitemap-format-entry
         :sitemap-function org-blog-sitemap-function)
        ("rss.xml"
         :base-directory ,org-blog-src-dir
         :base-extension "xml"
         :publishing-directory ,org-blog-output-dir
         :publishing-function org-publish-attachment)
        ("blog-project" :components ("blog-src" "static" "rss.xml" "images"))))

;; 设置Mathjax库的路径
(add-to-list 'org-html-mathjax-options '(path "https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML"))

(provide 'init-site)
