(setq visible-bell nil)           ; Don't flash at me!
(setq inhibit-startup-message t)  ; Disable startup screen
(setq ring-bell-function 'ignore) ; Don't beep at me!

(scroll-bar-mode 0)               ; Disable scrollbars
(tool-bar-mode 0)                 ; Disable toolbar
(set-fringe-mode 10)              ; Give some breathing
;(global-display-line-numbers-mode 1) ; Line numbers

(load-theme 'gruvbox-dark-soft t)
(set-face-attribute 'default nil :font "FiraMono Nerd Font" :height 130)

;;(require 'package)

;; Fullscreen by default
(add-to-list 'default-frame-alist '(fullscreen . maximized))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" default))
 '(package-selected-packages '(paredit cider clojure-mode gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun mechanics ()
  (interactive)
  (run-scheme
    "/usr/local/bin/mechanics.sh"
  ))
