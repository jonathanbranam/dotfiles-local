;; -*- mode: elisp -*-

;; INSTALL PACKAGES
;; ------------------------------

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    evil
    ein
    elpy
    flycheck
    py-autopep8
    magit
    material-theme))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)


;; Disable spash screen
(setq inhibit-splash-screen t)

(load-theme 'material t)
(global-linum-mode t)

;; Enable transient mark mode
(transient-mark-mode 1)

;; EVIL - vim mode
(require 'evil)
(evil-mode 1)


;; PYTHON SETTINGS
(require 'py-autopep8)
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;;; Org mode configuration
;; Enable Org mod
(require 'org)
;; org-mode with .org files
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; This is the current default, previous line shouldn't be needed

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/files/personal/org/1.org" "~/files/personal/org/data-science-study.org" "~/files/personal/org/navigators.org" "~/files/personal/org/refile-beorg.org")))
 '(package-selected-packages
   (quote
    (py-autopep8 flycheck elpy material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; For apple keyboard, remap
(setq mac-command-modifier 'meta) ; map cmd key -> Meta
(setq mac-option-modifier 'super) ; map option key -> Super
(setq mac-control-modifier 'control) ; map control key -> Control

(desktop-save-mode 1)

; Disable emacs vim clipboard integration
; https://stackoverflow.com/questions/26472216/how-to-copy-text-in-emacs-evil-mode-without-overwriting-the-clipboard
(setq x-select-enable-clipboard nil)

;; https://emacs.stackexchange.com/questions/14940/emacs-doesnt-paste-in-evils-visual-mode-with-every-os-clipboard?newreg=f8f1a4e23261475384a07c8057b2e6a1
;; Imagine the following scenario.  One wants to paste some previously copied
;; (from application other than Emacs) text to the system's clipboard in place
;; of some contiguous block of text in a buffer.  Hence, one switches to
;; `evil-visual-state' and selects the corresponding block of text to be
;; replaced.  However, one either pastes some (previously killed) text from
;; `kill-ring' or (if `kill-ring' is empty) receives the error: "Kill ring is
;; empty"; see `evil-visual-paste' and `current-kill' respectively.  The
;; reason why `current-kill' does not return the desired text from the
;; system's clipboard is because `evil-visual-update-x-selection' is being run
;; by `evil-visual-pre-command' before `evil-visual-paste'.  That is
;; `x-select-text' is being run (by `evil-visual-update-x-selection') before
;; `evil-visual-paste'.  As a result, `x-select-text' copies the selected
;; block of text to the system's clipboard as long as
;; `x-select-enable-clipboard' is non-nil (and in this scenario we assume that
;; it is).  According to the documentation of `interprogram-paste-function',
;; it should not return the text from the system's clipboard if it was last
;; provided by Emacs (e.g. with `x-select-text').  Thus, one ends up with the
;; problem described above.  To solve it, simply make
;; `evil-visual-update-x-selection' do nothing:
;; (fset 'evil-visual-update-x-selection 'ignore)


(dolist (hook '(text-mode-hook
		latex-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

