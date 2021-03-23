(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-define-key 'normal global-map "," 'evil-execute-in-god-state)
  (evil-mode 1))

(use-package evil-god-state
  :bind
  ("M-," . evil-god-state-bail))

(use-package god-mode)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(provide 'base-evil)
