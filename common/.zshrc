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
zstyle ':vcs_info:*' formats "%{%F{green}%}%c%u(%b) %f"
zstyle ':vcs_info:*' actionformats '(%b|%a) '
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
_is_git_worktree() {
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]; then
        print -P "%F{cyan}(git) $(git remote get-url origin)%f"
    fi
}

# Show git status if available
precmd() {
    vcs_info
    local myname="[%n@%m] "
    local gitstat="$(_is_git_untracked)${vcs_info_msg_0_}%f"
    local curdir="%~ "
    print -P "${myname}${gitstat}${curdir}"
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
        print -P "\033[1A\033[${pos_date}C%{%F{cyan}%}%D{%Y/%m/%d} %*%f"
    else
        print -P "\033[${pos_date}C%{%F{cyan}%}%D{%Y/%m/%d} %*%f"
    fi
}

# Settings for auto-completion
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1

# auto-cd
setopt auto_cd

setopt correct

# exec. ls after cd
chpwd() {
    print -P "%F{green}-> $(pwd)%f"
    _is_git_worktree
    ls -A
}

# Aliases
alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias sudovim='sudo vim -u ~/.vimrc'

alias python='python3'

alias -s {txt,md}='cat'
alias -s py='python'

# History search
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
bindkey '^r' history-incremental-pattern-search-backward
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

if grep -q microsoft /proc/version; then
    export DISPLAY=$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0.0
fi

ZDOTDIR=$HOME
[ -f $ZDOTDIR/.zshrc_`uname` ] && . $ZDOTDIR/.zshrc_`uname`
[ -f $ZDOTDIR/.zshrc_local ] && . $ZDOTDIR/.zshrc_local

