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

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require '_base)
(require 'base-theme)
(require 'base-extensions)
(require 'base-functions)
(require 'base-global-keys)
(require 'base-evil)
(require 'lang-nix)
(require 'lang-python)

(require 'lang-javascript)

(require 'lang-web)
