;; init-latex.el --- Initialize org configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Org configurations.
;;

;;; Code:
(use-package LaTeX
  :ensure nil
  :bind ()
  ;; :hook (LaTeX-mode . (lambda ()
  ;;                       (company-auctex-init)
  ;;                       (setcar company-backends
  ;;                               (let ((backend (car company-backends)))
  ;;                                 (funcall (if (consp backend) 'append 'cons)
  ;;                                          backend '(company-math-symbols-unicode
  ;;                                                    company-math-symbols-latex))))
  ;;                       (visual-line-mode t)
  ;;                       (LaTeX-math-mode t)
  ;;                       (turn-on-cdlatex t)))

  :config (setq-default
           TeX-master nil
           TeX-parse-self t
           TeX-auto-save t
           TeX-PDF-mode t
           TeX-view-program-list '(("Zathura" "zathura %o"))
           TeX-view-program-selection '((output-pdf "Zathura"))
           TeX-command-default "XeLaTeX"))

(provide 'init-latex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-latex.el ends here
