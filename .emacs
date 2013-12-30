
;; Package repositories
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" .
	       "http://melpa.milkbox.net/packages/") t)

(package-initialize)

;; Themes
(load-theme 'zenburn t)


(require 'rainbow-mode)
(require 'uniquify)

;;;;;;;;;;;;;;;;;;;;;;
;;  Custom functions
;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;
;;  Keybindings
;;;;;;;;;;;;;;;;;;;;;

(global-set-key "\C-ci" 'ispell)
(global-set-key "\C-ce" 'eshell)
(global-set-key "\C-cq" 'auto-fill-mode)
(global-set-key "\C-co" 'next-multiframe-window)
(global-set-key "\C-cw" 'whitespace-mode)

(define-key global-map "\C-ca" 'org-agenda)

;; Haskell mode
(eval-after-load "haskell-mode"
    '(progn
       (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
       (turn-on-haskell-indent)))

(eval-after-load "haskell-cabal"
    '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)

;; Add a key for running nosetests in python mode
(add-hook 'python-mode-hook
	  '(lambda ()
	     (define-key python-mode-map "\C-cn"
	       '(lambda ()
		  (interactive)
		  (shell-command "nosetests")))))

;; Set auto-fill-mode for different programming modes
(add-hook 'python-mode-hook 'auto-fill-mode)
(add-hook 'haskell-mode-hook 'auto-fill-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Other customizations
;;;;;;;;;;;;;;;;;;;;;;;;;;


; Disable splash screen
(setq inhibit-splash-screen t)

; Enable column numbers
(column-number-mode 1)

; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

; Move all temporary files elsewhere
(defvar backup-dir "~/.emacs.d/tempfiles")
(setq backup-directory-alist (list (cons "." backup-dir)))

; frame size
(setq initial-frame-alist
      '((width . 90) (height . 50)))

; fill-paragraph options
(setq-default fill-column 80)

; open .m files in octave-mode
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

; disable cycling completion for eshell
(setq eshell-cmpl-cycle-completions nil)

; uniquify buffer naming
(setq uniquify-buffer-name-style 'post-forward)

; remove trailing whitespaces on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;
;;; Java mode
;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'java-mode-hook
          (lambda ()
            "Treat Java 1.5 @-style annotations as comments."
            (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
            (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))

(add-hook 'java-mode-hook (lambda ()
                                (setq c-basic-offset 2)))

;;;;;;;;;;;;;;;;;;;;;;
;;; Org mode
;;;;;;;;;;;;;;;;;;;;;;

; org directory
(setq org-directory "~/Documents/org")

; color src
(setq org-src-fontify-natively t)

; agenda files, notes
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-my-agenda-file (concat org-directory "/agenda.org"))
(setq org-agenda-files (list
			org-default-notes-file
			org-my-agenda-file))

; Don't allow org-agenda create a new frame
(setq org-agenda-window-setup 'current-window)


; make a custom face for the FIXME todo item
;; (defface fixme-face
;;   '((((background light)) (:foreground "gray" :background "red" :weight bold))
;;     (((background dark)) (:foreground "gray" :background "red" :weight bold)))
;;   "Custom face for FIXME todo items"
;;   :group 'org-faces
;;   )

; font faces for TODO items
;; (setq org-todo-keyword-faces
;;       '(("TODO" . (:foreground "red"))
;; 		("CURRENT" . (:foreground "pink" :weight bold))
;; 		("IDEA" . (:foreground "orange" :weight bold))
;; 		("FIXME" . fixme-face)
;; 		("CANCELLED" . (:foreground "gray" :weight bold))
;; 		("LATER" . (:foreground "LightSkyBlue" :weight bold))))

;; for zenburn
;; (setq org-todo-keyword-faces
;; 	  `(("TODO" .  (:bold t :foreground ,zenburn-red :weight bold))
;; 		("CURRENT" . (:bold t :foreground ,zenburn-fg :weight bold))
;; 		("IDEA" . (:bold t :foreground ,zenburn-orange+1 :weight bold))
;; 		("FIXME" . (:bold t :foreground ,zenburn-bg :background ,zenburn-red-4 :weight bold))
;; 		("CANCELLED" . (:bold t :foreground "#909090" :weight bold))
;; 		("LATER" . (:bold t :foreground ,zenburn-blue :weight bold))))


; Define a key for capture, and a directory for captured notes
(define-key global-map "\C-cc" 'org-capture)

;; Capture templates
(setq org-capture-templates
 	  '(("t" "Todo" entry (file+datetree org-my-agenda-file)
 		 "* TODO %?")))

;; Remove unnecessary gui stuff
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))
(set-fringe-mode 0)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(tab-width 2))


(setq eval-expression-debug-on-error t)

(put 'narrow-to-region 'disabled nil)
(put 'scroll-left 'disabled nil)
