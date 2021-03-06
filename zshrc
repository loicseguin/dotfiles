## PROMPT ##

# Enable tab completion and colors
autoload -Uz compinit colors
compinit
colors

# Don't screw up directory names
unsetopt auto_name_dirs

# Add Git status to prompt
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

# Only gentle corrections suggested
setopt correct

## COMPLETION ##

unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

WORDCHARS=''
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/

## DIRECTORY NAVIGATION ##

unsetopt autocd    # automatically change to directory without cd
setopt auto_pushd        # push directory onto stack
setopt pushd_ignore_dups # don't put duplicates onto stack


## HISTORY ##

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

## KEYBINDINGS

# Fix delete key
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

## OTHER ENVIRONMENT VARIABLES ##

# My favourite editor is vim.
export EDITOR="vim"

# Still use emacs-style zsh bindings
#bindkey -e

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
alias sl=ls # often screw this up

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'
alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

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
alias gcl='git config --list'
alias glg='git log --stat --max-count=5'
compdef _git glg=git-log
alias glgg='git log --graph --max-count=5'
compdef _git glgg=git-log
alias ga='git add'
compdef _git ga=git-add
alias grh='git reset HEAD'

# Show history
alias history='fc -l 1'

# quickly reach directories
alias dotf="cd ~/code/dotfiles/"
alias mec="cd ~/teach/203-nya-mecanique/"
alias nyc="cd ~/teach/203-nyc-ondes/"
alias astro="cd ~/teach/203-cea-astro/"
alias radio="cd ~/teach/203-905-radiodiagnostic/"

# Homebrew
alias bu="brew update"
alias bo="brew outdated"
alias bug="brew upgrade"
b() { brew "$@"; }
bi() { brew install "$@"; }

# IPython Notebook
alias ipn="jupyter notebook"
alias ijulia="jupyter notebook --profile julia"

# Add tty info for vim-gnupg to work properly
#GPG_TTY=`tty`
#export GPG_TTY

# Make new tab in same directory requires the following hack in zsh.
#precmd () {print -Pn "\e]2; %~/ \a"}
#preexec () {print -Pn "\e]2; %~/ \a"}
