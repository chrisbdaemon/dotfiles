(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(use-package evil
  :ensure t
  :config (evil-mode 1))

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x f" . helm-recentf)
	 ("C-x b" . helm-buffers-list))
  :config (helm-mode 1))

(use-package projectile
  :ensure t
  :config (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :config (helm-projectile-on))

(use-package base16-theme
  :ensure t)

(use-package go-mode
  :ensure t
  :bind ("C-x C" . compile)
  :config 
  (setq gofmt-command "goimports")
  (defun go-mode-hook ()
    (add-hook 'before-save-hook 'gofmt-before-save)
    (if (not (string-match "go" compile-command))
	(set (make-local-variable 'compile-command)
	     "go build -v && go test -v && go vet")))
  (add-hook 'go-mode-hook 'go-mode-hook))

(tool-bar-mode -1)

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#151515" "#ac4142" "#90a959" "#f4bf75" "#6a9fb5" "#aa759f" "#6a9fb5" "#d0d0d0"])
 '(ansi-term-color-vector
   [unspecified "#151515" "#ac4142" "#90a959" "#f4bf75" "#6a9fb5" "#aa759f" "#6a9fb5" "#d0d0d0"])
 '(beacon-color "#cc6666")
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "f2dd097452b79276ce522df2f8aeb37f6d90f504529616aa46122d549910e46d" "b9cbfb43711effa2e0a7fbc99d5e7522d8d8c1c151a3194a4b176ec17c9a8215" "291588d57d863d0394a0d207647d9f24d1a8083bb0c9e8808280b46996f3eb83" "cea3ec09c821b7eaf235882e6555c3ffa2fd23de92459751e18f26ad035d2142" "3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "36282815a2eaab9ba67d7653cf23b1a4e230e4907c7f110eebf3cdf1445d8370" "5a39d2a29906ab273f7900a2ae843e9aa29ed5d205873e1199af4c9ec921aaab" default)))
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (helm-ag ensime zenburn-theme color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow moe-theme use-package helm-projectile go-mode evil base16-theme)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(set-specifier menubar-visible-p)
 '(tool-bar-mode -1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
