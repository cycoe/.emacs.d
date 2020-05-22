;; init-latex.el --- Initialize org configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Org configurations.
;;

;;; Code:

(use-package LaTeX
  :ensure nil
  :hook (LaTeX-mode . (lambda ()
                        (visual-line-mode t)
                        (LaTeX-math-mode t)))

  :config (setq-default
           ;; Variables for LaTeX itself
           TeX-PDF-mode t
           TeX-view-program-list '(("llpp" "llpp %o"))
           TeX-view-program-selection '((output-pdf "llpp"))
           TeX-command-default "XeLaTeX"))

;; (use-package company-auctex
;;   :ensure t
;;   :config
;;   (setq-default
;;    ;; Ask the master file every time you compile
;;    TeX-master nil
;;    TeX-parse-self t
;;    TeX-auto-save t)
;;   :hook
;;   (LaTeX-mode . company-auctex-init))

(setq-default
 ;; Ask the master file every time you compile
 TeX-master nil
 TeX-parse-self t
 TeX-auto-save t)
(add-hook 'LaTeX-mode-hook 'company-auctex-init)

;; (use-package reftex
;;   :ensure nil
;;   :after company
;;   (add-to-list 'company-backends '(company-reftex-labels company-reftex-citations))
;;   :config
;;   (require 'reftex)
;;   (setq reftex-plug-into-AUCTeX t)
;;   :hook
;;   (LaTeX-mode . turn-on-reftex))

(require 'reftex)
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; (use-package cdlatex
;;   :ensure nil
;;   :hook
;;   (LaTeX-mode . turn-on-cdlatex))

(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)

(provide 'init-latex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-latex.el ends here
