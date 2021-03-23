(use-package nix-mode
  :mode "\\.nix\\'"
  :config
  ;; the company-nix backend is not available in melpa, but has no new dependencies
  (unless (package-installed-p 'company-nix)
    (with-temp-buffer
      (url-insert-file-contents "https://github.com/NixOS/nix-mode/raw/master/nix-company.el")
      (eval-buffer)))
  (add-hook 'nix-mode-hook (lambda ()
			     (set (make-local-variable 'company-backends)
				  '((company-nix)))))
  (add-hook 'nix-mode-hook 'company-mode)
  )

(use-package nix-sandbox
  :after flycheck
  :config
  (setq flycheck-command-wrapper-function
        (lambda (command) (apply 'nix-shell-command (nix-current-sandbox) command))
        flycheck-executable-find
        (lambda (cmd) (nix-executable-find (nix-current-sandbox) cmd))))

(provide 'lang-nix)
