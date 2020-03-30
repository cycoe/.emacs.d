(setq telega-proxies
      (list
       '(:server "1.2.3.4" :port 8080 :enable :false
         :type (:@type "proxyTypeSocks5"
                :username "rkn" :password "jopa"))
       '(:server "127.0.0.1" :port 1088 :enable t
         :type (:@type "proxyTypeSocks5"
                :username "" :password ""))
       ))

(add-hook 'telega-chat-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (append '(telega-company-emoji
                           telega-company-username
                           telega-company-hashtag)
                         (when (telega-chat-bot-p telega-chatbuf--chat)
                           '(telega-company-botcmd))))
            (company-mode 1)))

(telega-notifications-mode 1)

(provide 'init-telega)
