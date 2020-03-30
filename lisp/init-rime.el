(use-package rime
  :quelpa (rime :fetcher github
                :repo "DogLooksGood/emacs-rime"
                :files ("rime.el" "Makefile" "lib.c"))
  :custom
  (default-input-method "rime")
  (rime-show-candidate 'posframe)
  :config
  (setq rime-disable-predicates
        '(evil-normal-state-p
          rime--after-alphabet-char-p
          rime--prog-in-code-p))
  :bind
  (:map rime-mode-map
   ("C-`" . 'rime-send-keybinding)))

(provide 'init-rime)
