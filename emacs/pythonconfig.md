# This tutorial will help user to configure emacs to work with python.

Base init.el (~/.emacs.d/init.el)

```
(require 'package)

(add-to-list 'package-archives
	            '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
    (package-refresh-contents))

(defvar myPackages
    '(better-defaults
      elpy
      flycheck
      material-theme
      py-autopep8))

(mapc #'(lambda (package)
	      (unless (package-installed-p package)
		      (package-install package)))
            myPackages)

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(elpy-enable)
(elpy-use-ipython)
(when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
```

Needed packages to be installed.
- ipython
- pep8
- jedi
- rope
- importmagic
- autopep8
- yapf
- flake8
