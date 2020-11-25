;;;;;;;;;;;;;;;;;;;;; BASIC CONFIG ;;;;;;;;;;;;;;;;;;;;;

;; Fullscreen
(toggle-frame-maximized)

;; Font size
(set-face-attribute 'default nil :height 110)

;; Set bash as default shell
(setq explicit-shell-file-name "/bin/bash")

;; Backup files
(setq backup-directory-alist
      `((".*" ., temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" , temporary-file-directory t)))

;; Set temp files folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; Prepare base package repo
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ;("marmalade" . "https://marmalade-repo.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")))
(setq load-prefer-newer t)

;; Install base packages
(setq package-list '(use-package lsp-mode lsp-ui flycheck hydra helm helm-lsp company python-mode go-mode dockerfile-mode docker-compose-mode conf-mode doom-themes))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Set theme
;M-x load-theme <ret> <THEME_NAME>
;doom-dark+
;doom-acario-dark
;doom-dracula
;doom-horizon
;doom-Iosvkem
;doom-material ++
;doom-molokai
;doom-moonligth
;doom-oceanic-next
;doom-snazzy
;doom-tomorrow-night
(load-theme 'doom-molokai t)

;; Helm keybindings, replacing common files functionality in emacs
(use-package helm
 :diminish
 :init (helm-mode t)
 :bind (("M-x"     . helm-M-x)
        ("C-x C-f" . helm-find-files)
        ("C-x b"   . helm-mini)     ;; See buffers & recent files; more useful.
        ("C-x r b" . helm-filtered-bookmarks)
        ("C-x C-r" . helm-recentf)  ;; Search for recently edited files
        ("C-c i"   . helm-imenu)
        ("C-h a"   . helm-apropos)
        ;; Look at what was cut recently & paste it in.
        ("M-y" . helm-show-kill-ring)

        :map helm-map
        ;; We can list ‘actions’ on the currently selected item by C-z.
        ("C-z" . helm-select-action)
        ;; Let's keep tab-completetion anyhow.
        ("TAB"   . helm-execute-persistent-action)
        ("<tab>" . helm-execute-persistent-action)))


;; Switch among windows with shift-arrow
(windmove-default-keybindings)

;; Disable menu bar
(menu-bar-mode -1)

;; Disable tool bar
(tool-bar-mode -1)

;; Disable startup screen
(setq inhibit-startup-screen t)

;; Enable line numbers
(global-linum-mode t)

;; Show column number
(setq column-number-mode t)

;; Speedbar (tree view)
;(add-hook 'emacs-startup-hook (lambda ()
;  (sr-speedbar-open)
;  ))
;(setq speedbar-directory-unshown-regexp "^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")

;; Persist sessions
;(desktop-save-mode 1)
;(setq history-length 250)
;(add-to-list 'desktop-globals-to-save 'file-name-history)


;; Conf mode
(use-package conf-mode
  :mode (("\\.conf\\'" . conf-mode)
         ("\\.cfg\\'" . conf-mode)
         ("\\.*rc\\'" . conf-mode)
         ("\\.ssh/config\\'" . conf-mode)
         ("\\.ini\\'" . conf-mode)))


;;;;;;;;;;;;;;;;;;;;; LSP ;;;;;;;;;;;;;;;;;;;;;

;; Basic LSP 
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred)
  :hook (python-mode . lsp-deferred)
  )

;; LSP UI
(use-package lsp-mode
  ;; ..

  :config
  (setq lsp-prefer-flymake nil) ;; Prefer using lsp-ui (flycheck) over flymake.

  ;; ..
  )

(use-package lsp-ui
  :requires lsp-mode flycheck
  :config

  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'bottom
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25)

  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; Hydra / helm

(use-package hydra)

(use-package helm)

(use-package helm-lsp
  :config
  (defun netrom/helm-lsp-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-workspace-symbol)))

  (defun netrom/helm-lsp-global-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-global-workspace-symbol))))

(use-package lsp-mode
  :requires hydra helm helm-lsp
  :config
  (setq netrom--general-lsp-hydra-heads
        '(;; Xref
          ("d" xref-find-definitions "Definitions" :column "Xref")
          ("D" xref-find-definitions-other-window "-> other win")
          ("r" xref-find-references "References")
          ("s" netrom/helm-lsp-workspace-symbol-at-point "Helm search")
          ("S" netrom/helm-lsp-global-workspace-symbol-at-point "Helm global search")

          ;; Peek
          ("C-d" lsp-ui-peek-find-definitions "Definitions" :column "Peek")
          ("C-r" lsp-ui-peek-find-references "References")
          ("C-i" lsp-ui-peek-find-implementation "Implementation")

          ;; LSP
          ("p" lsp-describe-thing-at-point "Describe at point" :column "LSP")
          ("C-a" lsp-execute-code-action "Execute code action")
          ("R" lsp-rename "Rename")
          ("t" lsp-goto-type-definition "Type definition")
          ("i" lsp-goto-implementation "Implementation")
          ("f" helm-imenu "Filter funcs/classes (Helm)")
	  ("f" lsp-ui-imenu "Filter funcs/classes (plain iMenu)")
          ("C-c" lsp-describe-session "Describe session")

          ;; Flycheck
          ("l" lsp-ui-flycheck-list "List errs/warns/notes" :column "Flycheck"))

        netrom--misc-lsp-hydra-heads
        '(;; Misc
          ("q" nil "Cancel" :column "Misc")
          ("b" pop-tag-mark "Back")
	  ("C-q" lsp-restart-workspace "Restart workspace")
	  )

	)

  ;; Create general hydra.
  (eval `(defhydra netrom/lsp-hydra (:color blue :hint nil)
           ,@(append
              netrom--general-lsp-hydra-heads
              netrom--misc-lsp-hydra-heads)))

  (add-hook 'lsp-mode-hook
            (lambda () (local-set-key (kbd "C-c C-l") 'netrom/lsp-hydra/body))))  

;; Autocompletion

(use-package company
  :config
  (setq company-idle-delay 0.3)

  (global-company-mode 1)

  (global-set-key (kbd "C-<tab>") 'company-complete))

(use-package company-capf
  :requires company
  :config
  (push 'company-capf company-backends)

   ;; Disable client-side cache because the LSP server does a better job.
  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil
	lsp-prefer-capf t))

;; Golang specific

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(setq lsp-gopls-staticcheck t)
(setq lsp-eldoc-render-all t)
(setq lsp-gopls-complete-unimported t)


;; Python specific

(use-package lsp-mode
  :config
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)
     ("pyls.plugins.flake8.enabled" t t)
     ("pyls.plugins.pycodestyle.enabled" nil t)
     ("pyls.plugins.mccabe.enabled" nil t)
     ("pyls.plugins.pyflakes.enabled" nil t)
   ))
  )
