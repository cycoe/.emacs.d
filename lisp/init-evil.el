(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  ";" 'counsel-M-x
  "w/" 'split-window-right
  "w-" 'split-window-below
  "wk" 'delete-window
  "bk" 'kill-buffer
  "bf" 'ivy-switch-buffer
  "bm" 'ibuffer
  "k" 'kill-current-buffer
  "ff" 'counsel-find-file
  "fr" 'counsel-recentf
  "e" 'eval-last-sexp

  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "."  'evilnc-copy-and-comment-operator
  "\\" 'evilnc-comment-operator)

;; Emacs key bindings
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-c l") 'evilnc-quick-comment-or-uncomment-to-the-line)
(global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
(global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)

(use-package evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode 1))

;; (use-package evil-surround
;;   :ensure t
;;   :config
;;   (global-evil-surround-mode 1))
(require 'evil-surround)
(global-evil-surround-mode 1)

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
  ;; Set some mode with emacs instead of evil
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'hexo-mode 'emacs)
  (evil-mode 1))

(provide 'init-evil)
