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

;; Indentation behavior
(setq c-basic-indent 2)
(setq-default tab-width 2)
(setq default-tab-width 2)
(setq-default indent-tabs-mode nil)
(setq cua-auto-tabify-rectangles nil)
(add-hook 'yaml-mode-hook '(lambda () (set (make-local-variable 'indent-tabs-mode) nil)))

;; Smart tabs
(require 'smarttabs "vendor/smarttabs.el")
(smart-tabs-advice js2-indent-line js2-basic-offset)

;; Auto-detect indentation
(require 'dtrt-indent "vendor/dtrt-indent/dtrt-indent.el")
(dtrt-indent-mode t)

;; Special rules for argument indentation (affecting PHP arrays)
(defun my-c-mode-hook ()
  (setq indent-tabs-mode nil)
  (dtrt-indent-mode t)

  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close 0)
  (c-set-offset 'innamespace 0)
)
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;; Indent CSS files in C-style
;(setq cssm-indent-function #'cssm-c-style-indenter)

;; Show whitespace
(setq whitespace-style '(face trailing spaces tabs newline space-mark))
(require 'whitespace)
(setq whitespace-display-mappings
      '((space-mark   ?\    [?\xB7]     [?.])	; space
        (space-mark   ?\xA0 [?\xA4]     [?_])	; hard space
        (newline-mark ?\n   [?\xB6 ?\n] [?$ ?\n])	; end-of-line
        (tab-mark     ?\t   [?\xBB ?\t] [?\\ ?\t])	; tab
        ))
(global-whitespace-mode t)

;; Backup without cluttering file system
(require 'backup-dir "vendor/backup-dir/backup-dir.el")
(make-variable-buffer-local 'backup-inhibited)
(setq bkup-backup-directory-info
      '((t "~/.backups/" ok-create full-path)))
(setq delete-old-versions t
      kept-old-versions 1
      kept-new-versions 3
      version-control t)

;; nXhtml
(load "vendor/nxhtml/autostart.el")
(tabkey2-mode t)

;; JavaScript
(add-to-list 'load-path "~/.emacs.d/vendor/js2-mode")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; MuMaMo-Mode for rhtml files
(add-to-list 'load-path "~/path/to/your/elisp/nxml-directory/util")
(require 'mumamo-fun)
(setq mumamo-chunk-coloring 'submode-colored)
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))

;; Coffeescript
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)

;; Line numbers
(require 'linum)
(global-linum-mode)
(add-hook 'linum-before-numbering-hook
		  (lambda ()
			(let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
			  (setq linum-format
					`(lambda (line)
					   (propertize (concat
									(truncate-string-to-width ""
															  (- ,w (length (number-to-string line)))
															  nil
															  ?\x2007)
									(number-to-string line)) 'face 'linum))))))

;; Column number in modeline
(column-number-mode 1)

;; Key rebinding
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)

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
;(setq windmove-wrap-around t)
(windmove-default-keybindings 'meta)
(eval-after-load 'paredit ; Paredit tries to steal meta-up and meta-down
  '(progn
     (define-key paredit-mode-map (kbd "<M-up>") nil)
     (define-key paredit-mode-map (kbd "<M-down>") nil)))

;; Start server for emacsclient
(server-start)

;; Try and fix weird copy/paste behavior
; (transient-mark-mode 1)  ; Now on by default: makes the region act quite like the text "highlight" in many apps.
(setq shift-select-mode t) ; Now on by default: allows shifted cursor-keys to control the region.
(setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
(setq x-select-enable-primary nil)  ; stops killing/yanking interacting with primary X11 selection
(setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection

; You need an emacs with bug #902 fixed for this to work properly. It has now been fixed in CVS HEAD.
; it makes "highlight/middlebutton" style (X11 primary selection based) copy-paste work as expected
; if you're used to other modern apps (that is to say, the mere act of highlighting doesn't
; overwrite the clipboard or alter the kill ring, but you can paste in merely highlighted
; text with the mouse if you want to)
(setq select-active-regions t) ;  active region sets primary X11 selection
(global-set-key [mouse-2] 'mouse-yank-primary)  ; make mouse middle-click only paste from primary X11 selection, not clipboard and kill ring.

;; CUA mode
;;(setq cua-enable-cua-keys nil)
;;(setq cua-auto-tabify-rectangles nil) ; Don't tabify after rect commands
;;(setq cua-highlight-region-shift-only t) ; No transient mark mode
;;(setq cua-keep-region-after-copy t) ; Standard Windows behavior
;;(setq cua-toggle-set-mark nil) ; Original set-mark behavior - no TMM
(cua-mode)

;; No debugger please
(setq debug-on-error nil)

;; Highlight column 80
;(require 'column-marker "vendor/column-marker/column-marker.el")
;(add-hook 'font-lock-mode-hook (lambda () (interactive) (column-marker-1 80)))

;; YASnippet
(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(yas/load-directory "~/.emacs.d/snippets")

;; Color scheme
(custom-set-faces
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background light)) (:foreground "#A52A2A"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background light)) (:foreground "#504984"))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background light)) (:foreground "#227A16"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background light)) (:foreground "#BA1F1D" :weight semi-bold))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light)) (:foreground "#026396"))))
 '(fringe ((((class color) (background light)) (:background "#F9FCFF"))))
 '(js2-external-variable-face ((t (:foreground "#6A5ACD"))))
 '(linum ((t (:inherit (shadow default)))))
 '(mode-line ((((class color) (min-colors 88)) (:background "#6E97CA" :foreground "#FFFFFF" :box (:line-width -1 :style released-button)))))
 '(mode-line-inactive ((default (:inherit mode-line)) (((class color) (min-colors 88) (background light)) (:background "#E6ECF3" :foreground "grey20" :box (:line-width -1 :color "grey75") :weight light))))
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background light)) nil)))
 '(mumamo-background-chunk-submode1 ((((class color) (min-colors 88) (background light)) (:background "#F7FBFF"))))
 '(mumamo-border-face-in ((t (:inherit font-lock-preprocessor-face))))
 '(mumamo-border-face-out ((t (:inherit font-lock-preprocessor-face))))
 '(whitespace-space ((((class color) (background light)) (:foreground "#dddddd"))))
 '(whitespace-tab ((((class color) (background light)) (:foreground "#dddddd"))))
 '(whitespace-trailing ((t (:background "#ffffdd" :foreground "red" :weight bold)))))

