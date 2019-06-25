#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PROMPT
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

# ALIASES
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'

# Git
alias gst='git status'
alias gd='git diff'
alias glg='git log --stat --max-count=5'
alias ga='git add'

# Quickly reach directories
alias dotf="cd ~/code/dotfiles/"
alias mec="cd ~/teach/203-nya-mecanique/"
alias nyc="cd ~/teach/203-nyc-ondes/"
alias astro="cd ~/teach/203-cea-astro/"
alias radio="cd ~/teach/203-905-radiodiagnostic/"
