;; the exact path may different -- check it
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

;; require the mu4e main package
(require 'mu4e)
;; use smtpmail to sent mail
(require 'smtpmail)
;; convert org content in mu4e to html
(require 'org-mime)
;; use org-mode in mu4e-message-mode
(require 'org-mu4e)

;; set default values about mu4e
(setq
 ;; auto update maildir with isync and index it
 mu4e-update-interval 300
 ;; don't do a full cleanup check
 mu4e-index-cleanup nil
 ;; don't consider up-to-date dirs
 mu4e-index-lazy-check t
 ;; show images in message mode
 mu4e-view-show-images t
 ;; set the default download dir for attachment
 mu4e-attachment-dir "/data/cycoe/Downloads"
 ;; prefer html view
 mu4e-view-prefer-html t
 ;; show fancy chars in mu4e head view
 mu4e-use-fancy-chars 't
 ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
 ;; (See the documentation for `mu4e-sent-messages-behavior' if you have
 ;; additional non-Gmail addresses and want assign them different
 ;; behavior.)
 mu4e-sent-messages-behavior 'delete
 )

;; set default values for sending mails
(setq
 ;; user agent when send mail
 mail-user-agent 'mu4e-user-agent
 ;; 设置邮件发送方法为 smtpmail
 message-send-mail-function 'smtpmail-send-it
 ;; 根据 from 邮件头使用正确的账户上下文发送 Email.
 message-sendmail-envelope-from 'header
 ;; 设置邮箱认证加密方式
 smtpmail-stream-type 'ssl
 ;; don't keep message buffers around
 message-kill-buffer-on-exit t
 )

;; Some information about me
(setq
 user-full-name  "朱浩南"
 ;; set a mail address list using when reply a message
 mu4e-user-mail-address-list '("cycoejoo@163.com"
                               "871873687@qq.com")
 mu4e-compose-signature
 (concat
  "朱浩南 Cycoe\n"
  "BLOG https://cycoe.cc\n")
 )

;; 该函数基于当前所在的 maildir 来判定所账户上下文。
;; (defun mu4e-message-maildir-matches (msg rx)
;;   (when rx
;;     (if (listp rx)
;;         ;; If rx is a list, try each one for a match
;;         (or (mu4e-message-maildir-matches msg (car rx))
;;             (mu4e-message-maildir-matches msg (cdr rx)))
;;       ;; Not a list, check rx
;;       (string-match rx (mu4e-message-field msg :maildir)))))

;; 设置 mu4e 上下文
(setq mu4e-contexts
      `( ,(make-mu4e-context
	         :name "Netease"
	         :enter-func (lambda ()
                         (mu4e-message "Entering Netease context")
                         ;; update index after switch context, otherwise the
                         ;; counting is not updated
                         (mu4e-update-index))
           :leave-func (lambda () (mu4e-message "Leaving Netease context"))
	         ;; we match based on the contact-fields of the message
	         :match-func (lambda (msg)
			                   (when msg
			                     (string-match-p "cycoejoo@163.com" (mu4e-message-field msg :maildir))))

	         :vars '((user-mail-address             . "cycoejoo@163.com")
                   (mu4e-sent-folder              . "/cycoejoo@163.com/Sent")
                   (mu4e-drafts-folder            . "/cycoejoo@163.com/Drafts")
                   (mu4e-trash-folder             . "/cycoejoo@163.com/Trash")
                   (mu4e-refile-folder            . "/cycoejoo@163.com/Refile")
                   (smtpmail-smtp-user            . "cycoejoo@163.com")
                   (smtpmail-default-smtp-server  . "smtp.163.com")
                   (smtpmail-smtp-server          . "smtp.163.com")
                   (smtpmail-smtp-service         . 994)
                   (mu4e-get-mail-command         . "mbsync -a")
                   (mu4e-maildir-shortcuts . (("/cycoejoo@163.com/INBOX"   . ?i)
                                              ("/cycoejoo@163.com/Sent"    . ?s)
                                              ("/cycoejoo@163.com/Refile"  . ?r)
                                              ("/cycoejoo@163.com/Trash"   . ?t)
                                              ("/cycoejoo@163.com/Drafts"  . ?d)))
                   (mu4e-bookmarks . ( ("maildir:/cycoejoo@163.com/INBOX AND flag:unread AND NOT flag:trashed"   "Unread messages"        ?u)
                                       ("maildir:/cycoejoo@163.com/INBOX AND date:today..now"                    "Today's messages"       ?t)
                                       ("maildir:/cycoejoo@163.com/INBOX AND date:7d..now"                       "Last 7 days"            ?w)
                                       ("maildir:/cycoejoo@163.com/INBOX AND date:1d..now"                       "Last 1 days"            ?o)
                                       ("maildir:/cycoejoo@163.com/INBOX"                                        "Inbox"                  ?i)
                                       ("maildir:/cycoejoo@163.com/Sent"                                         "Sent"                   ?s)
                                       ("maildir:/cycoejoo@163.com/Refile"                                       "Refile"                 ?r)
                                       ("maildir:/cycoejoo@163.com/Trash"                                        "Trash"                  ?t)
                                       ("maildir:/cycoejoo@163.com/Drafts"                                       "Drafts"                 ?d)
                                       ("maildir:/cycoejoo@163.com/INBOX AND mime:image/*"                       "Messages with images"   ?p)))
                   ))

         ,(make-mu4e-context
	         :name "QQ"
	         :enter-func (lambda ()
                         (mu4e-message "Switch to the QQ context")
                         (mu4e-update-index))
	         :match-func (lambda (msg)
			                   (when msg
			                     (string-match-p "871873687@qq.com" (mu4e-message-field msg :maildir))))

	         :vars '((user-mail-address             . "871873687@qq.com")
                   (mu4e-sent-folder              . "/871873687@qq.com/Sent")
                   (mu4e-drafts-folder            . "/871873687@qq.com/Drafts")
                   (mu4e-trash-folder             . "/871873687@qq.com/Trash")
                   (mu4e-refile-folder            . "/871873687@qq.com/Refile")
                   (smtpmail-smtp-user            . "871873687@qq.com")
                   (smtpmail-default-smtp-server  . "smtp.qq.com")
                   (smtpmail-smtp-server          . "smtp.qq.com")
                   (smtpmail-smtp-service         . 465)
                   (mu4e-get-mail-command         . "mbsync -a")
                   (mu4e-maildir-shortcuts . (("/871873687@qq.com/INBOX"   . ?i)
                                              ("/871873687@qq.com/Sent"    . ?s)
                                              ("/871873687@qq.com/Refile"  . ?r)
                                              ("/871873687@qq.com/Trash"   . ?t)
                                              ("/871873687@qq.com/Drafts"  . ?d)))
                   (mu4e-bookmarks . ( ("maildir:/871873687@qq.com/INBOX AND flag:unread AND NOT flag:trashed"   "Unread messages"        ?u)
                                       ("maildir:/871873687@qq.com/INBOX AND date:today..now"                    "Today's messages"       ?t)
                                       ("maildir:/871873687@qq.com/INBOX AND date:7d..now"                       "Last 7 days"            ?w)
                                       ("maildir:/871873687@qq.com/INBOX AND date:1d..now"                       "Last 1 days"            ?o)
                                       ("maildir:/871873687@qq.com/INBOX"                                        "Inbox"                  ?i)
                                       ("maildir:/871873687@qq.com/Sent"                                         "Sent"                   ?s)
                                       ("maildir:/871873687@qq.com/Refile"                                       "Refile"                 ?r)
                                       ("maildir:/871873687@qq.com/Trash"                                        "Trash"                  ?t)
                                       ("maildir:/871873687@qq.com/Drafts"                                       "Drafts"                 ?d)
                                       ("maildir:/871873687@qq.com/INBOX AND mime:image/*"                       "Messages with images"   ?p)))
                   ))))

;; start with the first (default) context;
;; default is to ask-if-none (ask when there's no context yet, and none match)
(setq mu4e-context-policy 'pick-first)

;; use imagemagick if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; Setup mu4e alert notification
(mu4e-alert-set-default-style 'libnotify)
(setq mu4e-alert-email-notification-types '(count))
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)

;; set a key jump along the links in message view
(add-hook 'mu4e-view-mode-hook
          (lambda ()
            (local-set-key (kbd "<tab>") 'shr-next-link)
            (local-set-key (kbd "<backtab>") 'shr-previous-link)))

;; set the luminosity if hard to read message in dark mode theme
;; (setq shr-color-visible-luminance-min 80)

;; auto enable the org-mu4e-compose-org-mode when enter the mu4e-compose-mode
(add-hook 'mu4e-compose-mode-hook
          (defun do-compose-stuff ()
            (org-mu4e-compose-org-mode)))

(defun htmlize-and-send ()
  "When in an org-mu4e-compose-org-mode message, htmlize and send it."
  (interactive)
  (when (member 'org~mu4e-mime-switch-headers-or-body post-command-hook)
    (org-mime-htmlize)
    (message-send-and-exit)))

(add-hook 'org-ctrl-c-ctrl-c-hook 'htmlize-and-send t)

;; store link to message if in header view, not to header query
(setq org-mu4e-link-query-in-headers-mode nil)

(provide 'init-mu4e)
