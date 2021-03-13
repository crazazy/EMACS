(use-package ac-php)

(use-package php-mode
  :after company-mode
  :mode
  (("\\.php\\'" . php-mode))
  :config
  (add-hook 'php-mode-hook
	    '(lambda ()
	       (require 'company-php)
	       (company-mode t)
	       (add-to-list 'company-backends 'company-ac-php-backend))))

(use-package phpunit
  :mode
  (("\\.php\\'" . phpunit-mode)))

(provide 'lang-php)
