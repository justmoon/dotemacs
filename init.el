;; Marmalade repo required by starter-kit
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; Package auto-install
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit undo-tree dtrt-indent coffee-mode
                                  markdown-mode php-mode less-css-mode
                                  auto-complete)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
