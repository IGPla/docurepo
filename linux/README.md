# Linux Utils

## Command line utils

### Sed

- sed [options] commands [file-to-edit]: basic sed usage pattern

## Screen utils

Screen is a really useful command that will allow us to detach a given tty to run commands (even to have another interactive shell). It shines when you need to let a command running while you disconnect your session (obviously, computer must be on :) )

### Command out of screen

- screen -S <name>: start a new screen session named <name>
- screen -list: list all sessions
- screen -x: attach to a running session
- screen -r: attach to detached session

### Commands inside screen

- C-a d: detach from session
- C-a D D: detach and close session
- C-a \: exit all programs in screen
- C-a c: create new window
- C-a C-a: change to last window
- C-a ' <number or title>: change to window by number or title
- C-a n: change to next window
- C-a p: change to previous window
- C-a ": show window list
- C-a w: show window bar
- C-a A: rename current window

- C-a S: split screen horizontally
- C-a V: split screen vertically
- C-a tab: jump to next tab
- C-a X: remove current region
- C-a Q: remove all regions but the one active
- C-a x: lock session

- C-a esc: enter the copy mode (useful to scroll up and down)
- C-a ?: show help
