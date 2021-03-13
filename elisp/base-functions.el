;; Add your custom functions here

;; (defun something
;;    (do-something))
(defun create-scratch-buffer nil
    "create a scratch buffer"
    (interactive)
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (lisp-interaction-mode))

(provide 'base-functions)
