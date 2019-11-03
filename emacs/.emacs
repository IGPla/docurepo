; Global config

;; Fullscreen
(toggle-frame-maximized)

;; Activate hs minor mode for all major modes
(add-hook 'prog-mode-hook #'hs-minor-mode)

;; Font size
(set-face-attribute 'default nil :height 110)

;; Set bash as default shell
(setq explicit-shell-file-name "/bin/bash")

;; Backup files
(setq backup-directory-alist
      `((".*" ., temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" , temporary-file-directory t)))

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

;; Set temp files folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; Install base packages
(setq package-list '(better-defaults go-mode exec-path-from-shell auto-complete go-autocomplete material-theme elpy flycheck py-autopep8 ein sr-speedbar flymd markdown-mode json-mode yaml-mode))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Load material-theme
(load-theme 'material t)
;; Disable menu bar
(menu-bar-mode -1)
;; Disable tool bar
(tool-bar-mode -1)
;; Disable startup screen
(setq inhibit-startup-screen t)
;; Enable line numbers
(global-linum-mode t)
;; Speedbar (tree view)
(add-hook 'emacs-startup-hook (lambda ()
  (sr-speedbar-open)
  ))
(setq speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")
;;;; Custom vars
(custom-set-variables
 '(speedbar-show-unknown-files t)
)

;; Show column number
(setq column-number-mode t)


; Python config

;; Basic setup
(elpy-enable)

;; Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Pep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


; Go config

;; Basic setup
(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

;; godoc tool
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;; Go utils (gofmt, Godef)
(defun my-go-mode-hook ()
  ; Call Gofmt before saving                                                    
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding                                                      
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  ; Compile command customization
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; Autocomplete
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

;; Code folding shortcuts
(global-set-key (kbd "C-1") 'hs-hide-all) ; Cntr+1
(global-set-key (kbd "C-2") 'hs-show-all) ; Cntr+2
(global-set-key (kbd "C-3") 'hs-show-block) ; Cntr+3

