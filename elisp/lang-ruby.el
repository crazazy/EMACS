(use-package enh-ruby-mode
  :mode
  (("\\.rb\\'" . ruby-mode)))

(use-package robe
  :after company-mode
  :config
  (push 'company-robe company-backends))

(use-package rinari)

(provide 'lang-ruby)
