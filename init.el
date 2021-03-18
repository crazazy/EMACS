;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:

(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(when (not package-archive-contents)
(package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
; (add-to-list 'load-path (concat user-emacs-directory "borked"))

(setq dummy t)
(require '_base)
(require 'base-theme)
(require 'base-extensions)
(require 'base-org)
(require 'base-functions)
(require 'base-global-keys)
(require 'base-evil)

(require 'lang-python)
(require 'lang-javascript)
(require 'lang-web)
