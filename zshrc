# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt nomatch
unsetopt autocd beep extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/lsc/.zshrc'

autoload -Uz compinit colors
compinit
colors
# End of lines added by compinstall

# Add git status to prompt
autoload -Uz vcs_info
setopt prompt_subst
precmd () { vcs_info }
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ':✔'
zstyle ':vcs_info:*' unstagedstr ':✘'
zstyle ':vcs_info:*' formats "  %{$fg_no_bold[magenta]%}%s:%b%u%c%{$reset_color%}"
zstyle ':vcs_info:*' actionformats " [%s|%a:%{$fg[red]%}%b%{$fg[yellow]%}%u%c%{$reset_color%}]"

PROMPT=$'%{$fg_no_bold[yellow]%}%n  %{$fg[green]%}%~%{$reset_color%}${vcs_info_msg_0_}
%{$fg[bg-black]%}$  %{$reset_color%}'

## OTHER ENVIRONMENT VARIABLES ##

# My favourite editor is nvim.
export EDITOR="nvim"

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m' # end the info box
export LESS_TERMCAP_so=$'\e[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# Colorful grep results
alias grep='grep --color=auto'

# Colorful ls
case $OSTYPE in
    darwin*)
        alias ls='ls -G'
        ;;
    linux*)
        alias ls='ls --color'
        ;;
esac

## ALIASES ##

# ls
alias lr="ls -1r"
alias lsa='ls -lah'
alias l='ls -lA1'
alias ll='ls -l'
alias la='ls -lA'

# Git
alias gst='git status'
compdef _git gst=git-status
alias gpl='git pull'
compdef _git gpl=git-pull
alias gp='git push'
compdef _git gp=git-push
alias gd='git diff'
compdef _git gd=git-diff
alias gc='git commit -v'
compdef _git gc=git-commit
alias gca='git commit -v -a'
compdef _git gca=git-commit
alias gco='git checkout'
compdef _git gco=git-checkout
alias gb='git branch'
compdef _git gb=git-branch
alias glg='git log --stat --max-count=5'
compdef _git glg=git-log
alias glgg='git log --graph --max-count=5'
compdef _git glgg=git-log
alias ga='git add'
compdef _git ga=git-add
alias grh='git reset HEAD'
