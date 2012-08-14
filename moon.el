;;; moon.el - Personal Emacs settings (v2)
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

;; Indentation
(setq c-basic-indent 2)
(setq js-indent-level 2)
(setq-default tab-width 2)
(setq default-tab-width 2)
(setq-default indent-tabs-mode nil)
(defun my-c-mode-hook ()
  (dtrt-indent-mode t)
  (c-set-offset 'innamespace 0)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;; Backspace should delete tabs (not convert tabs to spaces)
(setq c-backspace-function 'backward-delete-char)

;; Show whitespace
(setq whitespace-style '(face trailing spaces tabs newline space-mark))
(global-whitespace-mode t)

;; Enabling Semantic (code parsing, smart completion) features
(setq semantic-default-submodes
      '(global-semanticdb-minor-mode
        global-semantic-idle-scheduler-mode
        global-semantic-idle-summary-mode
        global-semantic-idle-completions-mode
;;      global-semantic-decoration-mode
        global-semantic-highlight-func-mode
        global-semantic-stickyfunc-mode))
(semantic-mode 1)
(global-ede-mode t)

;; JavaScript
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.gyp$" . js-mode))
(add-to-list 'interpreter-mode-alist '("node" . js-mode))

;; Line numbers
(global-linum-mode)
(add-hook
 'linum-before-numbering-hook
 (lambda ()
   (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
     (setq linum-format
           `(lambda (line)
              (propertize
               (concat
                (truncate-string-to-width ""
                                          (- ,w (length (number-to-string line)))
                                          nil
                                          ?\x2007)
                (number-to-string line)) 'face 'linum))))))

;; Column number in modeline
(column-number-mode 1)

;; Undo tree
(global-undo-tree-mode t)

;; Key rebinding
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)

(global-set-key (kbd "C-z") 'undo-tree-undo)
(global-set-key (kbd "C-S-z") 'undo-tree-redo)
(global-set-key (kbd "C-f") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-f") 'isearch-forward)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-M-%") 'query-replace)
(global-set-key (kbd "C-o") 'ido-find-file)
(global-set-key (kbd "C-s") 'save-buffer)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x m") 'eshell)
(global-set-key (kbd "C-x C-i") 'imenu)
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)
(global-set-key (kbd "C-c n") 'esk-cleanup-buffer)

;; Windmove
;;(setq windmove-wrap-around t)
(windmove-default-keybindings 'meta)

;; CUA mode
;;(setq cua-enable-cua-keys nil)
;;(setq cua-auto-tabify-rectangles nil) ; Don't tabify after rect commands
;;(setq cua-highlight-region-shift-only t) ; No transient mark mode
;;(setq cua-keep-region-after-copy t) ; Standard Windows behavior
;;(setq cua-toggle-set-mark nil) ; Original set-mark behavior - no TMM
(cua-mode)

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
