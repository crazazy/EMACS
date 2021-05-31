;;; package --- python configs
;;; Commentary:
;;; Contains my python configs

;;; Code:

(use-package python
  :mode ("\\.py" . python-mode)
  :config

  (setq python-sandbox
	(nix-env-from-packages
	 "Python"
	 "(python38.withPackages (p: with p; [flake8 mypy black virtualenv-wrapper pyenv]))"))
  (add-hook 'python-mode (set (make-local-variable 'nix-buffer-sandbox) python-sandbox))
  (use-package elpy
    :init
    (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
    :config
    (setq elpy-rpc-backend "jedi")
    ;; (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
    ;;flycheck-python-flake8-executable "/usr/local/bin/flake8"
    :bind (:map elpy-mode-map
	      ("M-." . elpy-goto-definition)
	      ("M-," . pop-tag-mark)))
  (elpy-enable)
  (use-package pyenv-mode
    :after python nix-sandbox
    :if
    (nix-executable-find python-sandbox "pyenv")
    :init
    (add-to-list 'exec-path "~/.pyenv/shims")
    (setenv "WORKON_HOME" "~/.pyenv/versions/")
    :config
    (pyenv-mode)
    :bind
    ("C-x p e" . pyenv-activate-current-project))

  (add-hook 'after-init-hook 'pyenv-init)
  (add-hook 'projectile-after-switch-project-hook 'pyenv-activate-current-project))

(use-package pip-requirements
  :config
  (add-hook 'pip-requirements-mode-hook #'pip-requirements-auto-complete-setup))

(use-package py-autopep8)


(defun pyenv-init()
  (setq global-pyenv (replace-regexp-in-string "\n" "" (shell-command-to-string "pyenv global")))
  (message (concat "Setting pyenv version to " global-pyenv))
  (pyenv-mode-set global-pyenv)
  (defvar pyenv-current-version nil global-pyenv))

(defun pyenv-activate-current-project ()
"Automatically activates pyenv version if .python-version file exists."
  (interactive)
  (f-traverse-upwards
    (lambda (path)
      (message path)
      (let ((pyenv-version-path (f-expand ".python-version" path)))
	(if (f-exists? pyenv-version-path)
	    (progn
      	      (setq pyenv-current-version (s-trim (f-read-text pyenv-version-path 'utf-8)))
      	      (pyenv-mode-set pyenv-current-version)
      	      (pyvenv-workon pyenv-current-version)
      	      (message (concat "Setting virtualenv to " pyenv-current-version))))))))


(provide 'lang-python)
;;; base-python.el ends here
