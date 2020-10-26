(use-package nix-mode
  :mode "\\.nix\\'"
  )
(use-package company-nixos-options
  :after company
  :init
  (add-to-list 'company-backends 'company-nixos-options))

(provide 'lang-nix)
