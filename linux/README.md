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

## ZSH shell

### Install

apt-get install zsh -y

### Configure

use oh-my-zsh to configure it.

- Add zsh as your shell (edit /etc/passwd)
- curl -L http://install.ohmyz.sh | sh
- Edit ~/.zshrc and tune your shell (themes, plugins...)

More info in https://github.com/robbyrussell/oh-my-zsh

## Bash shell

### Useful, light minimal prompt

Type the following in .bashrc

```
# Util colors
GREEN="\[$(tput setaf 10)\]"
RED="\[$(tput setaf 9)\]"
RESET="\[$(tput sgr0)\]"

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}

export PS1="[\A]\u:${GREEN}\w${RESET}\`nonzero_return\` ${RED}\`parse_git_branch\`${RESET} "
```

Easy customization tool:

http://ezprompt.net/

If you want that customization works for all users, put it in 

/etc/bash.bashrc

This file holds the default for bash users.
