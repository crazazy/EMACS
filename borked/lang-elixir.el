;; Elixir is using some deprecated packages in order to get it's stuff done
;; The elixir emacs community has decided to from now on move to lsp-mode for their
;; programming enviroment, but since I don't want to deal with LSP yet, I'm just gonna
;; leave this here
(use-package alchemist
  :config
  (add-hook 'elixir-mode-hook 'alchemist-mode))

(use-package flycheck-mix
  :commands (flycheck-mix-setup))

(use-package elixir-mode)

(provide 'lang-elixir)
