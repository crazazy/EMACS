(use-package org
  :config
  (setq org-directory "~/org-files"
        org-default-notes-file (concat org-directory "/todo.org"))
  (unless (file-exists-p org-default-notes-file)
    (make-empty-file org-default-notes-file t))
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda))

(use-package org-projectile
  :config
  (org-projectile-per-project)
  (setq org-projectile-per-project-filepath "todo.org")
  (add-hook 'after-init-hook (lambda ()
			      "add todo.org as a project file if it exists"
			      (when (file-exists-p (concat (file-name-directory buffer-file-name) org-projectile-per-project-filepath))
				(set org-agenda-files (append org-agenda-files (org-projectile-todo-files)))))))

(use-package org-bullets
  :config
  (setq org-hide-leading-stars t)
  (add-hook 'org-mode-hook
            (lambda ()
              (org-bullets-mode t))))

(provide 'base-org)
