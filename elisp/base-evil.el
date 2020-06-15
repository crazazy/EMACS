(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-define-key 'normal global-map "," 'evil-execute-in-god-state)
  (evil-define-key 'god global-map "C-x" 'evil-god-state-bail)
  (evil-mode 1))

(use-package evil-god-state)
(use-package god-mode)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(provide 'base-evil)
