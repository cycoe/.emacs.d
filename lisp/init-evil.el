(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  ";" 'counsel-M-x
  "w/" 'split-window-right
  "w-" 'split-window-below
  "wk" 'delete-window
  "bk" 'kill-buffer
  "bf" 'counsel-switch-buffer
  "ff" 'counsel-find-file
  "fr" 'counsel-recentf
  "e" 'eval-last-sexp)

(use-package evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; optional: this is the evil state that evil-magit will use
;; (setq evil-magit-state 'normal)
;; optional: disable additional bindings for yanking text
;; (setq evil-magit-use-y-for-yank nil)
(require 'evil-magit)

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (when evil-want-C-u-scroll
    (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)
    (define-key evil-insert-state-map (kbd "C-u") 'evil-scroll-up))
  :config
  (evil-mode 1))

;; If above code errors, following code can be used
;;(setq evil-want-C-u-scroll t)
;;(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
;;(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
;;(define-key evil-insert-state-map (kbd "C-u") 'evil-scroll-up)
;;(require 'evil)
;;(evil-mode 1)

(provide 'init-evil)
