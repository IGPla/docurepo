# Shortcuts

This document aims to be a useful respository of emacs shortcuts (both generic, comming from standard configuration and from custom configuration that you can find here: https://github.com/IGPla/docurepo/blob/master/emacs/.emacs)

## Common

- To remove the first n characters of a selected block
```
# Select block with c-space and move to the n character of the last line
M-x kill-rectangle (same functionality with C-x r k)
```
- To add a character (or several ones) in a selected block (very useful to comment several lines)
```
# Select block with c-space and move to the first character of the last line
M-x string-insert-rectangle -> character (or characters) to be inserted
```

- To pretty print a buffer with json code unformatted
```
M-x json-pretty-print-buffer
```

- To eval any lisp expression (such the ones you add in your .emacs file)
```
M-x eval-expression RET <expression>
```

- To change font size
```
M-x eval-expression RET (set-face-attribute 'default nil :height 110)
```

- To ensure that emacs is using /bin/bash as the default shell
```
M-x eval-expression RET (setq explicit-shell-file-name "/bin/bash")
```

- To summarize a regex into a buffer (really useful to find definitions in a given code file)
```
M-x occur RET <expression>

# Example: It will summarize all function definitions and link them to the code in a new buffer
M-x occur RET function

# Example: Same as above, but for python's function definition
M-x occur RET def
```

- Also, to have all the information about definitions in a given code file, speedbar menu offers file/definitions for lots of code 

- To effective achieve code folding
```
# To activate
M-x hs-minor-mode

# To hide all definitions
M-x hs-hide-all

# To show all definitions
M-x hs-show-all

# To show a single block
M-x hs-show-block

# If you want to activate on all modes (>Emacs 24)
(add-hook 'prog-mode-hook #'hs-minor-mode)
```

- To set up a keybinding
```
(global-set-key (kbd "<KEY BINDING>") '<FUNCTION>)

# Example

(global-set-key (kbd "M-a") 'backward-char) ; Alt+a
(global-set-key (kbd "C-a") 'backward-char) ; Ctrl+a
(global-set-key (kbd "C-c t") 'backward-char) ; Ctrl+c t
```

## Custom shortcuts

This ones are the custom shortcuts defined https://github.com/IGPla/docurepo/blob/master/emacs/.emacs

- Folding
```
# Fold all
C-1
# Unfold all
C-2
# Unfold single block
C-3
```
