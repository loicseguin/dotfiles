## PROMPT ##

prompt_git() {
    git branch &>/dev/null || return 1
    HEAD="$(git symbolic-ref HEAD 2>/dev/null)"
    BRANCH="${HEAD##*/}"
    [[ -n "$(git status 2>/dev/null | \
        grep -F 'working directory clean')" ]] || STATUS=" ÃÂÃÂÃÂÃÂ¢ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ"
    printf '[git:%s] ' "${BRANCH:-unknown}${STATUS}"
}
prompt_hg() {
    hg branch &>/dev/null || return 1
    BRANCH="$(hg branch 2>/dev/null)"
    [[ -n "$(hg status 2>/dev/null)" ]] && STATUS=" ÃÂÃÂÃÂÃÂ¢ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ"
    printf '[hg:%s] ' "${BRANCH:-unknown}${STATUS}"
}
prompt_vcs() {
    prompt_git || prompt_hg
}
export PS1='\[\e[0;33m\]\W \[\e[32m\]$(prompt_vcs)\[\e[0;33m\]\$\[\e[m\] '

# Personal scripts in ~/bin.
PATH="${HOME}/bin:${PATH}"

## HISTORY ##

# Longer history
export HISTFILESIZE=100000
export HISTSIZE=100000

# Don't put duplicate lines in the history
export HISTCONTROL=ignoredups

# Merge history of different terminal sessions
shopt -s histappend

## PATH ##

# cabal installed scripts.
PATH="/Users/loic/.cabal/bin:${PATH}"

export PATH

## OTHER ENVIRONMENT VARIABLES ##

# My favourite editor is vim.
export EDITOR="vim"

# Colors for ls
export CLICOLOR=1

# Colors for grep
export GREP_OPTIONS="--color=auto"

# Press Ctrl+D twice to quit current shell
export IGNOREEOF=1

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m' # end the info box
export LESS_TERMCAP_so=$'\e[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

## OTHER OPTIONS ##

# Correct typos
shopt -s cdspell

## ALIASES ##

# ls
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lr="ls -1r"

# quickly reach directories
alias dotf="cd ~/dotfiles/"

# Git
alias gi="git init"
alias ga="git add"
alias gc="git commit"
alias gca="git commit -a"
alias gco="git checkout"
alias gst="git status"
alias gp="git push"
alias gpl="git pull"
alias gd="git diff"

# Mercurial
alias hgi="hg init"
alias hga="hg add"
alias hgs="hg status"
alias hgc="hg commit"
alias hgl="hg log -l 5"
alias hgp="hg push"
alias hgpl="hg pull"
alias hgu="hg update"
alias hgd="hg diff"

# Mutt
alias m="mutt"

# ResearchNote: blogue
alias bnc="researchnote --config ~/.blognotesrc create"
alias bnl="researchnote --config ~/.blognotesrc list"
alias bne="researchnote --config ~/.blognotesrc edit"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
