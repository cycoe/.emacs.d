;;; cnsunyour/telega/+telega-auto-input-method.el -*- lexical-binding: t; -*-

(defcustom +telega--chat-cn-list nil
  "`telega' 里中文对话列表，用于自动切换到中文输入。"
  :type 'list
  :group 'telega)

(defcustom +telega--chat-en-list nil
  "`telega' 里英文对话列表，用于自动切换到英文输入。"
  :type 'list
  :group 'telega)

(defun +telega--save-encn-list ()
  "保存中英文对话列表。"
  (customize-save-variable '+telega--chat-cn-list +telega--chat-cn-list)
  (customize-save-variable '+telega--chat-en-list +telega--chat-en-list))

(defun +telega--add-cn-list (chat)
  "将当前聊天对话加入到中文列表中，以自动激活中文输入法。"
  (interactive (list (or telega-chatbuf--chat
                         telega--chat
                         (telega-chat-at (point)))))
  (let ((chatid (plist-get chat :id)))
    (cl-pushnew chatid +telega--chat-cn-list)
    (setq +telega--chat-en-list (cl-remove chatid +telega--chat-en-list))
    (+telega--save-encn-list)
    (message (concat "telega.el: Chat [\""
                     (telega-chat-title chat)
                     "\"] is added to CN chat list."))))

(defun +telega--add-en-list (chat)
  "将当前聊天对话加入到英文列表中，以自动关闭中文输入法。"
  (interactive (list (or telega-chatbuf--chat
                         telega--chat
                         (telega-chat-at (point)))))
  (let ((chatid (plist-get chat :id)))
    (cl-pushnew chatid +telega--chat-en-list)
    (setq +telega--chat-cn-list (cl-remove chatid +telega--chat-cn-list))
    (+telega--save-encn-list)
    (message (concat "telega.el: Chat [\""
                     (telega-chat-title chat)
                     "\"] is added to EN chat list."))))

(defun +telega--remove-from-list (chat)
  "将当前聊天对话从中英文列表中删除，将根据对话名称自动切换中英文输入法。"
  (interactive (list (or telega-chatbuf--chat
                         telega--chat
                         (telega-chat-at (point)))))
  (let ((chatid (plist-get chat :id)))
    (setq +telega--chat-en-list (cl-remove chatid +telega--chat-en-list))
    (setq +telega--chat-cn-list (cl-remove chatid +telega--chat-cn-list))
    (+telega--save-encn-list)
    (message (concat "telega.el: Chat [\""
                     (telega-chat-title chat)
                     "\"] is removed from EN/CN chat list."))))

(defun +telega--active-input-method ()
  "Active input method."
  (activate-input-method default-input-method))

(defun +telega--deactive-input-method ()
  "Deactive input method"
  (deactivate-input-method))

(defun +toggle-input-method--telega-chat-mode-a (chat &optional no-history-load)
  "在 telega-chat-mode 里根据 chat 名称切换输入法，如果名称包含
中文，则激活中文输入法，否则关闭中文输入法"
  (let ((title (telega-chat-title chat))
        (chatid (plist-get chat :id)))
    (cond ((member chatid +telega--chat-cn-list) (+telega--active-input-method))
          ((member chatid +telega--chat-en-list) (+telega--deactive-input-method))
          ((string-match "\\cc" title) (+telega--active-input-method))
          ((telega-chat-bot-p chat) (+telega--deactive-input-method))
          ((telega-chat-private-p chat) (+telega--active-input-method))
          (t (+telega--deactive-input-method)))))

(use-package telega
  :commands (telega)
  :defer t
  :bind ("C-S-t" . #'telega)
  :init
  (unless (display-graphic-p) (setq telega-use-images nil))
  :hook
  ('telega-chat-mode . #'yas-minor-mode-on)
  ('telega-chat-mode . (lambda () (set (make-local-variable 'company-backends)
                                  (append '(telega-company-emoji
                                            telega-company-username
                                            telega-company-hashtag
                                            telega-company-telegram-emoji)
                                          (when (telega-chat-bot-p telega-chatbuf--chat)
                                            '(telega-company-botcmd))))
                         (company-mode 1)
                         (telega-notifications-mode 1)))
  :config
  ;; 为 telega 加上补丁，进入 chatbuf 自动开启输入法
  (advice-add 'telega-chat--pop-to-buffer
              :after #'+toggle-input-method--telega-chat-mode-a)
  (setq telega-proxies (list '(:server "127.0.0.1" :port 1088 :enable t
                               :type (:@type "proxyTypeSocks5")))
        telega-chat-reply-prompt "<<< "
        telega-chat-edit-prompt "+++ "
        telega-animation-play-inline t
        telega-emoji-use-images nil
        telega-sticker-set-download t))

(provide 'init-telega)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-telega.el ends here
