(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(setq load-path (cons (expand-file-name "~/.emacs.d/lisp") load-path))
(require 'cmake-mode)

(require 'evil)
(evil-mode 1)

(menu-bar-mode -1)

(add-hook 'prog-mode-hook 'linum-mode)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(setq column-number-mode t)

                                        ; i hate smarttabs
(setq-default indent-tabs-mode nil)

(setq c-default-style "k&r" c-basic-offset 4)

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ("C-SPC" . helm-dabbrev)
         ("C-x b" . helm-buffers-list))
  :config (progn
            (setq helm-buffers-fuzzy-matching t)
            (helm-mode 1)))

(use-package projectile
  :ensure t
  :config (projectile-mode +1))

(use-package helm-projectile
  :ensure t
  :bind (("C-c p f" . helm-projectile-find-file)
         ("C-c p s s" . helm-projectile-ag)))

(use-package go-mode
  :ensure t
  :config
  (setq gofmt-command "goimports")
  (defun go-mode-hook ()
    (add-hook 'before-save-hook 'gofmt-before-save)
    (if (not (string-match "go" compile-command))
        (set (make-local-variable 'compile-command)
             "go build -v && go test -v && go vet")))
  (add-hook 'go-mode-hook 'go-mode-hook))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(setq lsp-keymap-prefix "C-l")

(use-package lsp-mode
  :ensure t
  :hook (
         (c++-mode . lsp)
         )
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config (push 'company-lsp company-backends))

(use-package helm-lsp :commands helm-lsp-workspace-symbol)

(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports)))

;; Do not set the background color
(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
      (set-face-background 'default "unspecified-bg" frame)))
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)
(add-hook 'window-setup-hook 'on-after-init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(package-selected-packages
   (quote
    (lsp-mode flycheck evil-magit magit-evil magit go-mode projectile helm elpy use-package evil color-theme-sanityinc-tomorrow))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
