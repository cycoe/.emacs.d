;; init-dot.el --- Initialize graphviz dot mode.	-*- lexical-binding: t -*-

(use-package graphviz-dot-mode
  :ensure t
  :defer t
  :config (setq graphviz-dot-indent-width 4)
  :hook
  ('graphviz-dot-mode . (lambda ()
                          (set (make-local-variable 'company-backends)
                               '(company-graphviz-dot-backend
                                 company-dabbrev))
                          (company-mode 1))))

(provide 'init-dot)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-dot.el ends here
