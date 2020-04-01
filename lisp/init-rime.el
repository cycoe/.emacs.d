(use-package rime
  :custom
  (default-input-method "rime")
  :config
  (setq rime-disable-predicates
        '(evil-normal-state-p
          rime--after-alphabet-char-p
          rime--prog-in-code-p))
  :bind
  (:map rime-mode-map
   ("C-`" . 'rime-send-keybinding)))

(provide 'init-rime)
