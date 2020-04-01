(use-package hexo
  :ensure t
  :init
  (setq hexo-posix-compatible-shell-file-path "/bin/bash"
        ;; Generate blog with org file
        hexo-new-format 'org)
  :config
  (require 'hexo)
  (defun hexo-my-blog ()
    (interactive)
    (hexo "/data/cycoe/GitHub/blog-hexo/"))
  :bind
  (("C-c C-h" . hexo-my-blog)))

(provide 'init-hexo)
