;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(package-initialize)

(when (not package-archive-contents)
(package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
; (add-to-list 'load-path (concat user-emacs-directory "borked"))

(require '_base)
(require 'base-theme)
(require 'base-extensions)
(require 'base-functions)
(require 'base-global-keys)
(require 'base-evil)

(require 'lang-python)
(require 'lang-javascript)
(require 'lang-web)
