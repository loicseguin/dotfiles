## PROMPT ##

prompt_hg() {
    hg branch &>/dev/null || return 1
    BRANCH="$(hg branch 2>/dev/null)"
    [[ -n "$(hg status 2>/dev/null)" ]] && STATUS=" ✘"
    printf '[hg:%s] ' "${BRANCH:-unknown}${STATUS}"
}

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
		BLACK=$(tput setaf 190)
		MAGENTA=$(tput setaf 9)
		ORANGE=$(tput setaf 172)
		GREEN=$(tput setaf 190)
		PURPLE=$(tput setaf 141)
		WHITE=$(tput setaf 0)
	else
		BLACK=$(tput setaf 190)
		MAGENTA=$(tput setaf 5)
		ORANGE=$(tput setaf 4)
		GREEN=$(tput setaf 2)
		PURPLE=$(tput setaf 1)
		WHITE=$(tput setaf 7)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	BLACK="\033[01;30m"
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	WHITE="\033[1;37m"
	BOLD=""
	RESET="\033[m"
fi

export BLACK
export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="∰  "

export PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n$symbol\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'


## COMPLETION ##

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"


## HISTORY ##

# Longer history
export HISTFILESIZE=100000
export HISTSIZE=100000

# Don't put duplicate lines in the history
export HISTCONTROL=ignoredups

# Merge history of different terminal sessions
shopt -s histappend


## PATH ##

# Personal scripts in ~/bin.
PATH="${HOME}/bin:/usr/local/bin:${PATH}"

# cabal installed scripts.
PATH="${HOME}/.cabal/bin:${PATH}"

# Julia
PATH="${HOME}/Projects/julia:${PATH}"

# Ruby RVM
PATH="${HOME}/.rvm/bin:${PATH}"

# Added by the Heroku Toolbelt
PATH="/usr/local/heroku/bin:${PATH}"

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

# quickly reach directories
alias dotf="cd ~/dotfiles/"
alias mec="cd ~/Dropbox/Courses/nya-mecanique/"
alias nyc="cd ~/Dropbox/Courses/nyc-ondes/"
alias astro="cd ~/Dropbox/Courses/cea-astro/"

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

# Editors
v() { mvim "$@"; }

# ResearchNote: blogue
alias bnc="researchnote --config ~/.blognotesrc create"
alias bnl="researchnote --config ~/.blognotesrc list"
alias bne="researchnote --config ~/.blognotesrc edit"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Homebrew
alias bu="brew update"
alias bo="brew outdated"
alias bug="brew upgrade"
b() { brew "$@"; }
bi() { brew install "$@"; }

# Agenda
export AGENDAFILE=$HOME/agenda.txt
a() { agenda "$@" $AGENDAFILE; }

# IPython Notebook
alias ipn="ipython notebook"
alias ijulia="ipython notebook --profile julia"

# Print weekly schedule
a
