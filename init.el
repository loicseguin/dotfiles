;; More potent common lisp
(require 'cl)

;; Packages
(require 'package)
(package-initialize)

(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(setq package-archive-enable-alist '(("melpa" magit monokai-theme)))

(defvar my-packages '(deft
                      magit
                      auctex
                      markdown-mode
                      zenburn-theme
                      monokai-theme
                      evil
                      key-chord)
  "Default packages")

(dolist (pkg my-packages)
  (when (not (package-installed-p pkg))
    (package-install pkg)))

;; Left option key (alt) is META, right option key is Alt Char for special characters
;; on non-english keyboards.
(setq mac-option-key-is-meta t)
(setq mac-right-option-modifier nil)

;; Enable system clipboard
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t)

;; Enable ido mode for easy file navigation
(ido-mode t)
(setq ido-enable-flex-matching t)

;; Remove toolbar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Remove menu bar in terminal
(when (not (display-graphic-p))
  (menu-bar-mode -1))

;; M-z deletes up to and including the given character
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)
(global-set-key (kbd "M-z") 'zap-up-to-char)

;; Append directory name for multiple files with same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Save last position of point and reset it when buffer is reopened.
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

;; Saner keybindings
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-x M-t") 'delete-trailing-whitespace)

;; Show matching parenthesis
(show-paren-mode 1)

;; Indent with spaces not tabs
(setq-default indent-tabs-mode nil)

;; Don't beep
(setq visible-bell t)

;; Backup files all in the same place
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
      auto-save-file-name-transforms `((".*" "~/.emacs.d/autosaves/\\1" t)))

(make-directory "~/.emacs.d/autosaves/" t)


;; Startup options
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'markdown-mode)

;; Indicate empty lines at end of file and trailing whitespace
(setq-default indicate-empty-lines t
              show-trailing-whitespace t)

;; Short answer
(defalias 'yes-or-no-p 'y-or-n-p)

;; Show column number
(setq column-number-mode t)

;; Load-theme
(load-theme 'monokai t)

;; Deft for note taking
(require 'deft)
(setq deft-extension "md"
      deft-directory "~/Notebook"
      deft-text-mode 'markdown-mode
      deft-use-filename-as-title t)
(global-set-key [f8] 'deft)

;; Evil mode (yay!)
(require 'key-chord)
(key-chord-mode 1)
(require 'evil)
(evil-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9dae95cdbed1505d45322ef8b5aa90ccb6cb59e0ff26fef0b8f411dfc416c552" "64581032564feda2b5f2cf389018b4b9906d98293d84d84142d90d7986032d33" "9a9e75c15d4017c81a2fe7f83af304ff52acfadd7dde3cb57595919ef2e8d736" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
