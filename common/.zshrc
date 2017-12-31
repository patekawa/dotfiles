# Display current path
PROMPT="%# "

# Settings for git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
_is_git_untracked() {
    local untracked="%F{red}?"
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

precmd() {
    vcs_info
    local left='%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~'
    local right='$(_is_git_untracked)${vcs_info_msg_0_}'
    local invisible='%([BSUbfksu]|([FK]){*})'
    local leftwidth=${#${(S%%)left//$~invisible/}}
    local rightwidth=${#${(S%%)right//$~invisible/}}
    local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth) % $COLUMNS))
    print -P $left${(r:$padwidth:: :)}$right
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


