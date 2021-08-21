(use-package meghanada
  :after nix-sandbox
  :config
  (setq java-env (nix-env-from-packages "java"
			 "adoptopenjdk-hotspot-bin-11"
			 "(maven.override {jdk = adoptopenjdk-hotspot-bin-11;})"))
  (add-hook 'java-mode-hook
          (lambda ()
	    (setq meghanada-java-path (nix-executable-find java-env "java"))
	    (setq meghanada-maven-path (nix-executable-find java-env "mvn"))
            ;; meghanada-mode on
            (meghanada-mode t)
            (flycheck-mode +1)
            (setq c-basic-offset 2)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save))))
