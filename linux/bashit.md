# Bash-it

A collection of community Bash customizations and commands

## Install

```
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh

```

## Configuration

Change theme
```
echo "export BASH_IT_THEME='candy'" >> ~/.bashrc
```

Candy theme with git and virtualenvwrapper support
```
#!/usr/bin/env bash

function prompt_command() {
    ps_env="$(virtualenv_prompt)${normal}"
    PS1="$ps_env ${green}\u@\h $(clock_prompt) ${reset_color}${white}\w${reset_color}$(scm_prompt_info)${blue} →${bold_blue} ${reset_color}";
}

THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$blue"}
THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%I:%M:%S"}

safe_append_prompt_command prompt_command
```

## For further read

https://github.com/Bash-it/bash-it
