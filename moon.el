;;; moon.el - Personal Emacs settings
;;
;; Author: Stefan 'justmoon' Thomas
;; Email: moon@justmoon.net
;;
;; Note: I suck at Lisp, so 99% of the code below is copied and
;;       butchered together from lots of different sources. Credit
;;       belongs to incredible Emacs community who are what makes
;;       this editor so awesome!
;;
;; This work is in the Public Domain.
;; See http://creativecommons.org/licenses/publicdomain/
;; Feel free to copy, modify and use this file as you wish!
;;

;; Emacs window size/position
;;(add-to-list 'default-frame-alist '(left . 0))
;;(add-to-list 'default-frame-alist '(top . 0))
;;(add-to-list 'default-frame-alist '(height . 60))
;;(add-to-list 'default-frame-alist '(width . 155))

;; Undo/redo
(require 'redo "vendor/redo.el")

;; Tab width
(setq default-tab-width 4)
(setq tab-width 4)
(setq indent-tabs-mode t)

;; Auto-detect indentation
(require 'dtrt-indent "vendor/dtrt-indent/dtrt-indent.el")
(add-hook 'c-mode-common-hook
          (lambda ()
            (dtrt-indent-mode t)))

;; Backup without cluttering file system
(require 'backup-dir "vendor/backup-dir/backup-dir.el")
(make-variable-buffer-local 'backup-inhibited)
(setq bkup-backup-directory-info
      '((t "~/.backups/" ok-create full-path)))
(setq delete-old-versions t
      kept-old-versions 1
      kept-new-versions 3
      version-control t)

;; Start XRefresh server
(require 'xrefresh "vendor/xrefresh/xrefresh.el")
(xrefresh-start)

;; nXhtml
(load "vendor/nxhtml/autostart.el")

;; Line numbers
(require 'linum)
(global-linum-mode)

;; Key rebinding
(global-unset-key (kbd "M-SPC")) ; Used by Launchy
(global-set-key (kbd "C-SPC") 'set-mark-command)

(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-M-f") 'isearch-forward-regexp)
(global-set-key (kbd "C-o") 'ido-find-file)
(global-set-key (kbd "C-s") 'save-buffer)

(global-set-key (kbd "M-j") 'backward-char)
(global-set-key (kbd "M-l") 'forward-char)
(global-set-key (kbd "M-u") 'backward-word)
(global-set-key (kbd "M-o") 'forward-word)
(global-set-key (kbd "M-S-j") 'move-beginning-of-line)
(global-set-key (kbd "M-S-l") 'move-end-of-line)
(global-set-key (kbd "M-i") 'previous-line)
(global-set-key (kbd "M-k") 'next-line)
(global-set-key (kbd "M-S-i") 'scroll-up)
(global-set-key (kbd "M-S-k") 'scroll-down)

;; Keys in isearch mode
(define-key isearch-mode-map (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map (kbd "C-y") 'isearch-yank-kill)

;; Windmove
(setq windmove-wrap-around t)

;; Start server for emacsclient
(server-start)

;; CUA mode
;;(setq cua-enable-cua-keys nil)
;;(setq cua-auto-tabify-rectangles nil) ; Don't tabify after rect commands
;;(setq cua-highlight-region-shift-only t) ; No transient mark mode
;;(setq cua-keep-region-after-copy t) ; Standard Windows behavior
;;(setq cua-toggle-set-mark nil) ; Original set-mark behavior - no TMM
(cua-mode)
