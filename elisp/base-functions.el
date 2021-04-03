;; Add your custom functions here

;; (defun something
;;    (do-something))
(defun create-scratch-buffer nil
    "create a scratch buffer"
    (interactive)
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (lisp-interaction-mode))

;; irc quick logins
(defmacro irc-quickjoin (serverfunc url &optional nick)
  "create a function to quickly join a server"
  `(defun ,serverfunc (password)
     (interactive (list (password-read "Password: ")))
     (erc-tls :server ,url
	      :nick ,(if nick
			 nick
		       "crazazy")
	      :port 6697
	      :password password)))

(irc-quickjoin tilde-irc "eu.tilde.chat")
(irc-quickjoin freenode-irc "irc.freenode.net")

(provide 'base-functions)
