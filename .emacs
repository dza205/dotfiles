
;;appearance
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(font .  "Iosevka Nerd Font-8:antialias=true:hinting=false" ))
(setq fancy-splash-image "~/Pictures/emacs.svg")
(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;;Random shit
(setq make-backup-files nil)



;s;packages
(setq package-archives
	  '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
		("MELPA"        . "https://melpa.org/packages/")
		("ORG"          . "https://orgmode.org/elpa/")
		("MELPA Stable" . "https://stable.melpa.org/packages/")
		("nongnu"       . "https://elpa.nongnu.org/nongnu/"))
	  package-archive-priorities
	  '(("GNU ELPA"     . 20)
		("MELPA"        . 15)
		("ORG"          . 10)
		("MELPA Stable" . 5)
		("nongnu"       . 0)))

(package-initialize)
;;; BOOTSTRAP USE-PACKAGES
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)

(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8363207a952efb78e917230f5a4d3326b2916c63237c1f61d7e5fe07def8d378" default))
 '(package-selected-packages
   '(auto-complete auctex powerline-evil powerline flycheck-pos-tip flycheck company-box company lsp-treemacs lsp-ivy lsp-ui lsp-mode magit gruvbox-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(use-package all-the-icons
  :ensure t)
(use-package keycast
  :ensure t)
(use-package gruvbox-theme
  :ensure t
  :config (load-theme 'gruvbox-dark-hard))
(use-package magit
  :ensure t
  :config (setq magit-auto-revert-mode nil))


(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)


(use-package org
  :ensure t)

(use-package auto-complete
  :ensure t)
(ac-config-default)
;; company
(use-package company
  :ensure t
  :bind ("M-/" . company-complete-common-or-cycle) ;; overwritten by flyspell
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-show-numbers            t
	company-minimum-prefix-length   1
	company-idle-delay              0.5
	company-backends
	'((company-files          ; files & directory
	   company-keywords       ; keywords
	   company-capf           ; what is this?
	   company-yasnippet)
	  (company-abbrev company-dabbrev))))

(use-package company-box
  :ensure t
  :after company
  :hook (company-mode . company-box-mode))

;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-display-errors-function
	#'flycheck-display-error-messages-unless-error-list)

  (setq flycheck-indication-mode nil))

(use-package flycheck-pos-tip
  :ensure t
  :after flycheck
  :config
  (flycheck-pos-tip-mode))
 (use-package powerline
  :ensure t
  :config (powerline-default-theme))
(windmove-default-keybindings)
(setq windmove-wrap-around t)
;; (use-package powerline-evil
;;  :ensure t)
;; Language server, lang specific parts
(use-package auctex
  :ensure t
  :defer t
  :config
  :hook (LaTeX-mode . (lambda ()
            (push (list 'output-pdf "Zathura")
                  TeX-view-program-election))))

(add-hook 'LaTeX-mode-hook 'company-mode)
