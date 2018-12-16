# Tmux

Tmux is a terminal multiplexer. It allows you to work in a project with different views / tasks / commands typed in a comprehensive environment.

## Concepts

- Session: tmux session, where you can split different panes, detach and attach again. Session should be up until reboot or killed
- Status bar: information about currently opened windows (left), system information (right) and can be customized
- Pane: split of session screen. Each pane can contain a different view (i.e. different commands / tasks inside the same session)
- C-b: prefix key to start typing commands 

## Commands and usage

- Session
  - Start a new session
```
tmux
tmux new -s <session name> # To start a named session
```
- Rename session
```
tmux rename-session -t 0 <new session name>
```
- Detach a session
```
C-b d
```
- List sessions
```
tmux ls
```
- Attach to a detached session
```
tmux attach -t <session number>
tmux attach -t <session name>
```

- Panes
  - Split panes horizontally
```
C-b %
```
  - Split panes vertically
```
C-b "
```
  - To move to another pane
```
C-b <arrow key>
```
  - Close pane
```
exit (or C-d)
```
  - Full screen / shrink again
```
C-b z
```
  - Resize pane
```
C-b C-<arrow key>
```

- Windows
  - New window
```
C-b c
```
  - Switch to previous window
```
C-b p
```
  - Switch to next window
```
C-b n
```
  - Switch to n window
```
C-b <window number>
```
  - Rename the current window
```
C-b ,
```

- Help
  - Get commands list
```
C-b ?
```
