;; haskell-mode configuration
;; https://github.com/haskell/haskell-mode
(use-package haskell-mode
  ;; haskell-mode swaps `C-m' and `C-j' behavior. Revert it back
  :bind (:map haskell-mode-map
              ("C-m" . newline)
              ("C-j" . electric-newline-and-maybe-indent))
  :config
  (defun my-haskell-mode-hook ()
    "Hook for `haskell-mode'."
    (set (make-local-variable 'company-backends)
         '((dante-company company-files))))
  (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
  (add-hook 'haskell-mode-hook 'company-mode)
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
  (add-hook 'haskell-mode-hook (lambda ()
				 (set (make-local-variable 'nix-buffer-sandbox
							   (nix-find-sandbox (nix-env-from-packages "Haskell"
												    "ghc"
												    "stack"
												    "cabal-install"
												    "haskellPackages.fourmolu"))))))

  ;; intero-mode for a complete IDE solution to haskell
  ;; commercialhaskell.github.io/intero
  (use-package dante
    :config
    (add-hook 'haskell-mode-hook 'dante-mode))

  ;; hindent - format haskell code automatically
  ;; https://github.com/chrisdone/hindent
  (when (nix-executable-find nix-buffer-sandbox "fourmolu")
    (use-package ormolu
	:hook (haskell-mode . ormolu-format-on-save-mode)
	:bind
	(:map haskell-mode-map
	      ("C-c r" . ormolu-format-buffer))
	:config
	(add-hook 'ormolu-format-on-save-mode-hook (lambda ()
						     (set (make-local-variable 'ormolu-process-path
									       (nix-executable-find nix-buffer-sandbox "fourmolu"))))))))

(provide 'lang-haskell)
