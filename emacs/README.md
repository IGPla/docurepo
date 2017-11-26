# EMACS

* All config should go into ~/.emacs.d/init.el
* Add melpa package index. Config:

```
(require 'package)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
```

* Commands
  * M-x list-packages -> list packages and allows to install them
  * M-x hs-minor-mode / M-x hs-hide-all / M-x hs-show-all -> code folding
* Markdown
  * Package -> markdown-mode
  * Install a markdown system package (markdown)
  * C-c C-c l to activate live preview
  * [More info](https://jblevins.org/projects/markdown-mode/)
* Python
  * elpy: powerful editor for emacs
    * Useful packages: ipython, jedi, rope, importmagic, autopep8, yapf, flake8
    * Install / config
	
```
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
	
* Go
  * package -> go-mode
  
* File tree
  * package -> sr-speedbar
  * Common commands:
    * sr-speedbar-open: open speedbar in a window
	* sr-speedbar-close: close speebar
