(use-package alchemist
  :config
  (add-hook 'elixir-mode-hook 'alchemist-mode))

;; Deprecated package, need to find alternatives
;(use-package flycheck-mix
;  :commands (flycheck-mix-setup))

(use-package elixir-mode)

(provide 'lang-elixir)
