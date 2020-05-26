;; init-latex.el --- Initialize org configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Org configurations.
;;

;;; Code:

(use-package LaTeX
  :ensure nil
  :hook
  (LaTeX-mode . (lambda ()
                  (visual-line-mode t)
                  (LaTeX-math-mode t)))

  :init
  (setq-default
   ;; Variables for LaTeX itself
   TeX-PDF-mode t
   TeX-view-program-list '(("llpp" "llpp %o"))
   TeX-view-program-selection '((output-pdf "llpp"))
   TeX-command-default "XeLaTeX"))

(use-package company-auctex
  :ensure t
  :defer t
  :config
  (setq-default
   ;; Ask the master file every time you compile
   TeX-master nil
   TeX-parse-self t
   TeX-auto-save t)
  :hook (LaTeX-mode . company-auctex-init))

(use-package reftex
  :ensure nil
  :defer t
  :config
  (require 'reftex)
  (setq reftex-plug-into-AUCTeX t)
  :hook (LaTeX-mode . turn-on-reftex))

(use-package cdlatex
  :ensure nil
  :defer t
  :hook (LaTeX-mode . turn-on-cdlatex))

(provide 'init-latex)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-latex.el ends here
