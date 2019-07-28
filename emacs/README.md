# EMACS

## Useful resources

- Comprehensive list of emacs packages
https://github.com/emacs-tw/awesome-emacs

## Useful packages

- go-mode: go mode
- auto-complete: autocomplete mode
- go-autocomplete: go bindings for autocomplete mode
- material-theme: material theme
- elpy: base package for enhanced python functionality
- flycheck: check python scripts for common errors (syntax)
- py-autopep8: apply pep8 rules
- sr-speedbar: speedbar (tree view) integration in the same window
- flymd: flymd-flyit command to view your markdown file into your default browser
- markdown-mode: useful mode to write markdown files
- json-mode: useful mode to edit json files

## Util Commands

- M-x sr-speedbar-toogle: open/close speedbar tree view
- M-x compile: run compile command
- M-x flymd-flyit: view your markdown file in your browser
- M-; : comment/uncomment the selected region
- C-x C-; -> Comment / uncomment current line or current selected region
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
