;; Add your custom functions here

;; (defun something
;;    (do-something))
(defun intersperse (el ls)
  "put element EL inbetween each element of list LS"
  (if (cdr ls)
      (cons (car ls) (cons el (intersperse el (cdr ls))))
    ls))

(defun create-scratch-buffer nil
    "create a scratch buffer"
    (interactive)
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (lisp-interaction-mode))

;; irc quick logins
(defmacro irc-quickjoin (servername url &optional nick)
  "create a function to quickly join a server. Servers can be joined with M-x SERVERNAME-irc"
  `(defun ,(intern (concat (symbol-name servername) "-irc")) (password)
     (interactive (list (password-read "Password: ")))
     (erc-tls :server ,url
	      :nick ,(if nick
			 nick
		       "crazazy")
	      :port 6697
	      :password password)))

(irc-quickjoin tilde "eu.tilde.chat")
(irc-quickjoin libera "irc.libera.chat")

(provide 'base-functions)
