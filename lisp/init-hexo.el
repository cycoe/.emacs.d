(require 'hexo)

(defun hexo-my-blog ()
  (interactive)
  (hexo "/data/cycoe/GitHub/blog-hexo/"))
(setq hexo-posix-compatible-shell-file-path "/bin/bash")

(provide 'init-hexo)
