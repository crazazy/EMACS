(use-package avy
  :bind
  ("C-c SPC" . avy-goto-char))


(use-package company
  :bind
  ("C-SPC" . company-complete)
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'emacs-lisp-mode-hook 'company-mode)
  (add-hook 'lisp-mode-hook 'company-mode))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w"))

(use-package elfeed
  :bind
  ("C-x w" . elfeed)
  (:map elfeed-search-mode-map
	("C-c a" . elfeed-add-feed)
	("C-c u" . elfeed-update)
	("C-c f" . elfeed-update-feed)))

(use-package exec-path-from-shell
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package flycheck)


(use-package counsel
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-m" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x c k" . counsel-yank-pop))

(use-package counsel-projectile
  :bind
  ("C-x v" . counsel-projectile)
  ("C-x c p" . counsel-projectile-ag)
  :config
  (counsel-projectile-on))

(use-package ivy
  :bind
  ("C-x s" . swiper)
  ("C-x C-r" . ivy-resume)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))


(use-package hlinum
  :after linum
  :config
  (hlinum-activate))

(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode nil))

(use-package magit
  :defer t
  :config

  (setq magit-completing-read-function 'ivy-completing-read)

  :bind
  ;; Magic
  ;;("C-x g s" . magit-status)
  ;;("C-x g x" . magit-checkout)
  ;;("C-x g l" . magit-clone)
  ;;("C-x g c" . magit-commit)
  ;;("C-x g f" . magit-fetch)
  ;;("C-x g p" . magit-push)
  ;;("C-x g u" . magit-pull)
  ;;("C-x g e" . magit-ediff-resolve)
  ;;("C-x g r" . magit-rebase-interactive)
  ("C-x g" . magit-status))


(use-package magit-popup)

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this))

(use-package neotree
  :config
  (setq neo-theme 'arrow
        neotree-smart-optn t
        neo-window-fixed-size nil)
  ;; Disable linum for neotree
  (add-hook 'neo-after-create-hook 'disable-neotree-hook))

(use-package page-break-lines)

(use-package projectile
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" temp-dir))

  (setq projectile-completion-system 'ivy)

  (projectile-global-mode))

(use-package recentf
  :config
  (setq recentf-keep '(file-remote-p file-readable-p))
  (setq recentf-save-file (expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

(use-package restart-emacs
  :bind
  ("ESC C-r" . restart-emacs)) ;; This is like one of the few keybinds left

(use-package smartparens
  :config
  (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
  (add-hook 'lisp-mode-hook 'smartparens-mode)
  (sp-with-modes '(lisp-mode emacs-lisp-mode)
    (sp-local-pair "'" nil :actions nil)
    (sp-local-pair "`" nil :actions nil))

  (add-hook 'nix-mode-hook 'smartparens-mode)
  (sp-with-modes '(nix-mode)
    (sp-local-pair "'" nil :actions nil)
    (sp-local-pair "''" "''"))
  )

(use-package undo-tree
  :config
  ;; Remember undo history
  (setq
   undo-tree-auto-save-history nil
   undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/"))))
  (global-undo-tree-mode 1))

(use-package which-key
  :after god-mode
  :config
  (which-key-mode)
  (which-key-enable-god-mode-support))

(use-package windmove
  :bind
  ("C-x <up>" . windmove-up)
  ("C-x <down>" . windmove-down)
  ("C-x <left>" . windmove-left)
  ("C-x <right>" . windmove-right))

(use-package wgrep)

(use-package yasnippet
  :defer
  :config
  (setq yas-snippet-dirs '())
  (use-package yasnippet-snippets
    :config
    (yasnippet-snippets-initialize))
  ;; don't need to reload all, since we only load the library directory
  (add-hook 'prog-mode-hook 'yas-minor-mode))

(provide 'base-extensions)
