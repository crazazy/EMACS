(use-package nix-mode
  :mode "\\.nix\\'"
  :config
  ;; the company-nix backend is not available in melpa, but has no new dependencies
  (unless (package-installed-p 'company-nix)
    (with-temp-buffer
      (url-insert-file-contents "https://github.com/NixOS/nix-mode/raw/master/nix-company.el")
      (eval-buffer)))
  (add-hook 'nix-mode-hook (lambda ()
			     (set (make-local-variable 'company-backends)
				  '((company-nix)))))
  (add-hook 'nix-mode-hook 'company-mode)
  )

(defun nix-env-from-packages (name &rest packages)
  "create a nix environment from nix packages. returns the location of the environment"
  (interactive (append
		(list (read-string "Environment name: " nil nil "nameless"))
		(split-string (read-string "Packages: "))))
  (with-temp-buffer
    (insert (format "
{ pkgs ? import %s {}}:
with pkgs;
buildEnv {
name = %s;
paths = [
%s
];
}
    " (or nix-nixpkgs-path "<nixpkgs>") name (apply 'concat (intersperse "\n" packages))))
    (write-file (concat temporary-file-directory name "-env/default.nix"))
    (concat temporary-file-directory name "-env")))

(use-package nix-sandbox
  :after flycheck
  :config
  (setq nix-universal-sandbox
	(nix-find-sandbox (nix-env-from-packages "swiss-knife" "stdenv" "nix" "nixpkgs-fmt" "ripgrep"))
	nix-buffer-sandbox nil
        flycheck-command-wrapper-function
        (lambda (command) (apply 'nix-shell-command (or nix-buffer-sandbox nix-universal-sandbox) command))
        flycheck-executable-find
        (lambda (cmd) (nix-executable-find (or nix-buffer-sandbox nix-universal-sandbox) cmd))))

(provide 'lang-nix)
