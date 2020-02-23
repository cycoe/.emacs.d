(use-package evil-leader
   :ensure t
   :after evil
   :config
   (global-evil-leader-mode t)
   :init
   (evil-leader/set-leader "<SPC>")
   (evil-leader/set-key
    ";" 'counsel-M-x
    "0" 'select-window-0
    "1" 'select-window-1
    "2" 'select-window-2
    "3" 'select-window-3
    "4" 'select-window-4
    "w/" 'split-window-right
    "w-" 'split-window-below
    "wk" 'delete-window
    "bk" 'kill-buffer
    "bf" 'counsel-switch-buffer
    "ff" 'counsel-find-file
    "fr" 'counsel-recentf
    "e" 'eval-last-sexp))

(use-package evil-matchit
  :ensure t
  :after evil
  :config
  (global-evil-matchit-mode t))

(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-easymotion
  :ensure t
  :after evil
  :config
  (evilem-default-keybindings "m"))

(use-package evil
  :ensure t
  :config
  (evil-mode t))

(provide 'init-evil)
