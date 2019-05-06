# Prompt
PROMPT="%# "

autoload colors
colors

# Settings for git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%{%F{yellow}%}!"
zstyle ':vcs_info:git:*' unstagedstr "%{%F{red}%}+"
zstyle ':vcs_info:*' formats "%{%F{green}%}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
_is_git_untracked() {
    local untracked="%{%F{red}%}?"
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]; then
        git_status=$(git status -s 2> /dev/null)
        if ! echo "$git_status" | grep "^??" > /dev/null 2>&1; then
            untracked=""
        fi

        if [ -n "$untracked" ]; then
            print "${untracked}"
        fi
    fi
}

# Show git status if available
precmd() {
    vcs_info
    # local left='%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~'
    local left="[%n@%m] %~"
    local right='$(_is_git_untracked)${vcs_info_msg_0_}${reset_color}'
    # local invisible='%([BSUbfksu]|([FK]){*})'
    # local leftwidth=${#${(S%%)left//$~invisible/}}
    # local rightwidth=${#${(S%%)right//$~invisible/}}
    # local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth) % $COLUMNS))
    # print -P $left${(r:$padwidth:: :)}$right
    print -P "%{${reset_color}%}$left $right"
}

# Show the datetime on executing a command
strlen() {
    FOO=$1
    local zero='%([BSUbfksu]|([FB]|){*})'
    LEN=${#${(S%%)FOO//$~zero/}}
    echo $LEN
}

preexec(){
    local pos_date=$(($COLUMNS - 20))
    local len_cmd=$(strlen "$@")
    if [ ${len_cmd} -lt ${pos_date} ]; then
        print -P "\033[1A\033[${pos_date}C%{%F{cyan}%}%D{%Y/%m/%d} %*%{${reset_color}%}"
    else
        print -P "\033[${pos_date}C%{%F{cyan}%}%D{%Y/%m/%d} %*%{${reset_color}%}"
    fi
}

# Settings for auto-completion
autoload -Uz compinit
compinit

# auto-cd
setopt auto_cd

# exec. ls after cd
chpwd() { echo "-> `pwd`"; ls -A}

# Aliases
alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias python='python3'

alias -s {txt,md}='cat'
alias -s py='python'

[ -f $ZDOTDIR/.zshrc_`uname` ] && . $ZDOTDIR/.zshrc_`uname`
[ -f $ZDOTDIR/.zshrc_local ] && . $ZDOTDIR/.zshrc_local

