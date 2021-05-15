;; haskell-mode configuration
;; https://github.com/haskell/haskell-mode
(use-package haskell-mode
  ;; haskell-mode swaps `C-m' and `C-j' behavior. Revert it back
  :after nix-sandbox
  :bind (:map haskell-mode-map
              ("C-m" . newline)
              ("C-j" . electric-newline-and-maybe-indent))
  :config
  (defun my-haskell-mode-hook ()
    "Hook for `haskell-mode'."
    (set (make-local-variable 'company-backends)
         '((dante-company company-files))))
  (setq haskell-sandbox (nix-env-from-packages "Haskell"
					       "ghc"
					       "stack"
					       "cabal-install"
					       "haskellPackages.fourmolu"))
  (setq haskell-process-wrapper-function
	(lambda (args)
	  (cons
	   (nix-executable-find haskell-sandbox (car args))
	   (cdr args))))
  (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
  (add-hook 'haskell-mode-hook 'company-mode)
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)

  ;; intero-mode for a complete IDE solution to haskell
  ;; commercialhaskell.github.io/intero
  (use-package dante
    :config
    (setq dante-repl-command-line (list (nix-executable-find haskell-sandbox "ghci")))
    (add-hook 'haskell-mode-hook 'dante-mode))

  ;; hindent - format haskell code automatically
  ;; https://github.com/chrisdone/hindent
  (when (nix-executable-find haskell-sandbox "fourmolu")
    (use-package ormolu
	:hook (haskell-mode . ormolu-format-on-save-mode)
	:bind
	(:map haskell-mode-map
	      ("C-c r" . ormolu-format-buffer))
	:config
	(add-hook 'ormolu-format-on-save-mode-hook
		  (lambda ()
		    (set (make-local-variable 'ormolu-process-path)
			 (nix-executable-find haskell-sandbox "fourmolu")))))))

(provide 'lang-haskell)
