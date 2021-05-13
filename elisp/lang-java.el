(use-package jdee
  :config
  ;; auto-compile jdee-server
  (defun compile-jdee-server ()
    (let ((jdee-dir (expand-file-name "jdee" user-emacs-directory))
	(git (executable-find "git"))
	(maven (executable-find "mvn")))
    (unless (file-exists-p jdee-dir)
      (unless (and git maven)
	(error "Make sure maven and git are installed"))
      (shell-command (concat git " clone https://github.com/jdee-emacs/jdee-server " jdee-dir))
      (shell-command (concat "cd " jdee-dir " && " maven " package")))
    (setq jdee-server-dir jdee-dir)))
  (add-hook 'jdee-mode 'compile-jdee-server))
