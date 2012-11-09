; load path customization
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/plugins")

(load-theme 'dvvc t)

(require 'rainbow-mode)
(require 'org-publish)

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
(global-set-key "\C-cx" 'org-publish-project)
(global-set-key "\C-cw" 'whitespace-mode)

(define-key global-map "\C-ca" 'org-agenda)


;; Add a key for running nosetests in python mode
(add-hook 'python-mode-hook
	  '(lambda ()
	     (define-key python-mode-map "\C-cn" 
	       '(lambda ()
		  (interactive)
		  (shell-command "nosetests")))))
	     
;; Set auto-fill-mode for different programming modes
(add-hook 'python-mode-hook 'auto-fill-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Other customizations
;;;;;;;;;;;;;;;;;;;;;;;;;;


; Disable splash screen
(setq inhibit-splash-screen t)

; Enable column numbers
(column-number-mode 1)

; Move all temporary files elsewhere
(defvar backup-dir "~/.emacs.d/tempfiles")
(setq backup-directory-alist (list (cons "." backup-dir)))

; frame size
(setq initial-frame-alist
      '((width . 85) (height . 36)))

; fill-paragraph options
(setq-default fill-column 80)

; open .m files in octave-mode
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

; disable cycling completion for eshell
(setq eshell-cmpl-cycle-completions nil)

;;;;;;;;;;;;;;;;;;;;;;
;;; Org mode
;;;;;;;;;;;;;;;;;;;;;;

; org directory
(setq org-directory "~/org")

; agenda files, notes
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-my-agenda-file (concat org-directory "/agenda.org"))
(setq org-agenda-files (list 
						org-default-notes-file 
						org-my-agenda-file))

; Don't allow org-agenda create a new frame
(setq org-agenda-window-setup 'current-window)


; make a custom face for the FIXME todo item
(defface fixme-face
  '((((background light)) (:foreground "gray" :background "red" :weight bold))
    (((background dark)) (:foreground "gray" :background "red" :weight bold)))
  "Custom face for FIXME todo items"
  :group 'org-faces
  )

; font faces for TODO items
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red"))
		("CURRENT" . (:foreground "pink" :weight bold))
		("IDEA" . (:foreground "orange" :weight bold))
		("FIXME" . fixme-face)
		("CANCELLED" . (:foreground "gray" :weight bold))
		("LATER" . (:foreground "LightSkyBlue" :weight bold))))

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
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "bf9d5728e674bde6a112979bd830cc90327850aaaf2e6f3cc4654f077146b406" "b0c36b57a7b0c0f347d0ccdc1a19eaa994a4174f09f18dea768cd62ea047bff8" "438e782d32b6dc513f4efc22859d82d8452dd1262ea8217ff2c0c78633320da8" "66c9fcff1257d00fc2a12f99f8a6058646c939405f3c2ad1beed1f524b9e1fd0" "cd3ce2b519cc3ed771ed03c85b6bf639a09c2bc2be61e4b7d9a839f001affdc6" "caaa255489972efe7fae8f6f0cf09bbdc5e90d4a966acf4b6d043f4ee26bd1be" default)))
 '(tab-width 4))


(setq eval-expression-debug-on-error t) 

