;; init-fcitx.el --- Initialize LSP configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; fcitx imput method configurations
;;

;;; Code:

;; fcitx auto switch
(use-package fcitx
  :ensure nil
  :hook (after-init . fcitx-default-setup))

(provide 'init-fcitx)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-fcitx.el ends here
